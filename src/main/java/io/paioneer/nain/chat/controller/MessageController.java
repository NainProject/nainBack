package io.paioneer.nain.chat.controller;

import io.paioneer.nain.chat.model.dto.ChatRoomDto;
import io.paioneer.nain.chat.model.dto.MessageDto;
import io.paioneer.nain.chat.model.service.ChatRoomService;
import io.paioneer.nain.chat.model.service.MessageService;
import io.paioneer.nain.member.model.dto.MemberDto;
import io.paioneer.nain.member.model.service.MemberService;
import io.paioneer.nain.security.jwt.util.JWTUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class MessageController {

    private final MessageService messageService;
    private final RestTemplate restTemplate;
    private final ChatRoomService chatRoomService;
    private final MemberService memberService;
    private final JWTUtil jwtUtil;

    @Value("${flask.server.url}")
    private String flaskServerUrl;

    @PostMapping("/rooms")
    public ResponseEntity<ChatRoomDto> createRoom(HttpServletRequest request, @RequestBody ChatRoomDto chatRoomDto) {
        String token = request.getHeader("Authorization").substring("Bearer ".length());
        Long memberNo = jwtUtil.getMemberNoFromToken(token);
        chatRoomDto.setMemberNo(memberNo);
        ChatRoomDto createdRoom = chatRoomService.createChatRoom(chatRoomDto);
        return ResponseEntity.ok(createdRoom);
    }

    @PostMapping("/rooms/{roomId}/send")
    public ResponseEntity<?> saveMessage(HttpServletRequest request, @PathVariable Long roomId, @RequestBody MessageDto messageDto) {
        String token = request.getHeader("Authorization").substring("Bearer ".length());
        Long memberNo = jwtUtil.getMemberNoFromToken(token);
        messageDto.setMemberNo(memberNo);
        messageDto.setChatRoomNo(roomId);
        messageDto.setMessageDate(new Date());
        MemberDto loginMember = memberService.findById(memberNo);
        messageDto.setNickname(loginMember.getMemberNickName());

        messageService.saveMessage(messageDto);

        log.info("Received message: " + messageDto);
        // Flask 서버로 메시지 전달
        restTemplate.postForEntity(flaskServerUrl + "/publish", messageDto, Void.class);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/rooms/{roomId}/messages")
    public ResponseEntity<List<MessageDto>> getAllMessages(@PathVariable Long roomId) {
        List<MessageDto> messages = messageService.getMessagesByRoomId(roomId);
        return ResponseEntity.ok(messages);
    }

    @GetMapping("/rooms")
    public ResponseEntity<List<ChatRoomDto>> getAllRooms() {
        List<ChatRoomDto> rooms = messageService.getAllRooms();
        return ResponseEntity.ok(rooms);
    }
}
