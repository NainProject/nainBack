// 필요한 클래스와 인터페이스를 import합니다.
package io.paioneer.nain.security.jwt.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.paioneer.nain.member.jpa.entity.MemberEntity;
import io.paioneer.nain.member.model.input.InputMember;
import io.paioneer.nain.member.model.output.CustomMemberDetails;
import io.paioneer.nain.member.model.service.MemberService;
import io.paioneer.nain.security.jwt.util.JWTUtil;
import io.paioneer.nain.security.model.entity.RefreshToken;
import io.paioneer.nain.security.service.RefreshService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.parameters.P;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

// Lombok의 @Slf4j 어노테이션을 사용하여 로깅을 간편하게 합니다.
@Slf4j
public class LoginFilter extends UsernamePasswordAuthenticationFilter {

    private final Long accessExpiredMs;
    private final Long refreshExpiredMs;

    private final MemberService memberService;
    private final RefreshService refreshService;

    private final AuthenticationManager authenticationManager;
    private final JWTUtil jwtUtil;

    // 생성자를 통해 AuthenticationManager와 JWTUtil의 인스턴스를 주입받습니다.
    public LoginFilter(MemberService memberService, RefreshService refreshService, AuthenticationManager authenticationManager, JWTUtil jwtUtil) {
        this.memberService = memberService;
        this.refreshService = refreshService;
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
        refreshExpiredMs = 86400000L;
        accessExpiredMs = 360000L;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 요청 본문에서 사용자의 로그인 데이터를 InputUser 객체로 변환합니다.
            InputMember loginData = new ObjectMapper().readValue(request.getInputStream(), InputMember.class);
            // 사용자 이름과 비밀번호를 기반으로 AuthenticationToken을 생성합니다. 이 토큰은 사용자가 제공한 이메일과 비밀번호를 담고 있으며, 이후 인증 과정에서 사용됩니다.
            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                    loginData.getMemberEmail(), loginData.getMemberPwd());
            // AuthenticationManager를 사용하여 실제 인증을 수행합니다. 이 과정에서 사용자의 이메일과 비밀번호가 검증됩니다.
            return authenticationManager.authenticate(authToken);
        } catch (AuthenticationException e) {
            // 요청 본문을 읽는 과정에서 오류가 발생한 경우, AuthenticationServiceException을 던집니다.
            throw new AuthenticationServiceException("인증 처리 중 오류가 발생했습니다.", e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // 로그인 성공 시 실행되는 메소드입니다. 인증된 사용자 정보를 바탕으로 JWT를 생성하고, 이를 응답 헤더에 추가합니다.
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) throws IOException {
        // 인증 객체에서 CustomUserDetails를 추출합니다.
        CustomMemberDetails customMemberDetails = (CustomMemberDetails) authentication.getPrincipal();

        // CustomUserDetails에서 사용자 이름(이메일)을 추출합니다.
        String username = customMemberDetails.getUsername();

        // 사용자 이름을 사용하여 JWT를 생성합니다.
        String access  = jwtUtil.generateToken(username,"access",accessExpiredMs);
        String refresh  = jwtUtil.generateToken(username,"refresh",refreshExpiredMs);
        log.info(access, refresh);
        Optional<MemberEntity> memberEntityOptional = memberService.findByMemberEmail(username);
        Long memberNo = 0L;
        if(memberEntityOptional.isPresent()){
            MemberEntity memberEntity = memberEntityOptional.get();
            memberNo = memberEntity.getMemberNo();
            RefreshToken refreshToken = RefreshToken.builder()
                    .id(UUID.randomUUID())
                    .status("activated")
                    .memberAgent(request.getHeader("Member-Agent"))
                    .memberEntity(memberEntity)
                    .tokenValue(refresh)
                    .expiresIn(refreshExpiredMs)
                    .build();

            refreshService.save(refreshToken);
        }

        // 응답 헤더에 JWT를 'Bearer' 토큰으로 추가합니다.
        response.addHeader("Authorization", "Bearer " + access);

        // 클라이언트가 Authorization 헤더를 읽을 수 있도록, 해당 헤더를 노출시킵니다.
        response.setHeader("Access-Control-Expose-Headers", "Authorization");


        // 여기서 부터 사용자 정보를 응답 바디에 추가하는 코드입니다.
        // 사용자의 권한이나 추가 정보를 JSON 형태로 변환하여 응답 바디에 포함시킬 수 있습니다.


        boolean admin = customMemberDetails.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"));

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("username", username);
        responseBody.put("isAdmin", admin);
        responseBody.put("refresh",refresh);
        responseBody.put("memberNo", memberNo);

        boolean subscribe = customMemberDetails.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_SUBSCRIBE"));
        responseBody.put("isSubscribe", subscribe);
        customMemberDetails.getAuthorities().forEach(authority -> {
            log.info("Authority: " + authority.getAuthority());
        });



        log.info(memberNo.toString());
        log.info("Admin: " + admin);


        // ObjectMapper를 사용하여 Map을 JSON 문자열로 변환합니다.
        String responseBodyJson = new ObjectMapper().writeValueAsString(responseBody);

        // 응답 컨텐츠 타입을 설정합니다.
        response.setContentType("application/json");

        // 응답 바디에 JSON 문자열을 작성합니다.
        response.getWriter().write(responseBodyJson);
        response.getWriter().flush();
    }

    // 로그인 실패 시 실행되는 메소드입니다. 실패한 경우, HTTP 상태 코드 401을 반환합니다.
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {

        // failed 객체로부터 최종 원인 예외를 찾습니다.
        Throwable rootCause = failed;
        while (rootCause.getCause() != null && rootCause.getCause() != rootCause) {
            rootCause = rootCause.getCause();
        }

        // rootCause를 기반으로 오류 메시지를 설정합니다.
        String message;
        if (rootCause instanceof UsernameNotFoundException) {
            message = "존재하지 않는 이메일입니다.";
        } else if (rootCause instanceof BadCredentialsException) {
            message = "잘못된 비밀번호입니다.";
        } else if (rootCause instanceof DisabledException) {
            message = "계정이 비활성화되었습니다.";
        } else if (rootCause instanceof LockedException) {
            message = "계정이 잠겨 있습니다.";
        } else {
            // 다른 예외들을 처리
            message = "인증에 실패했습니다.";
        }

        // 응답 데이터를 준비합니다.
        Map<String, Object> responseData = new HashMap<>();
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpStatus.BAD_REQUEST.value());
        responseData.put("timestamp", LocalDateTime.now().toString());
        responseData.put("status", HttpStatus.BAD_REQUEST.value());
        responseData.put("error", "Unauthorized");
        responseData.put("message", message);
        responseData.put("path", request.getRequestURI());

        // 응답을 보냅니다.
        try {
            String jsonResponse = new ObjectMapper().writeValueAsString(responseData);
            response.getWriter().write(jsonResponse);
            response.getWriter().flush();
        } catch (IOException ignored) {
        }
    }
}
