-- NAIN DB 스크립트 테이블 생성구문
-- PK만 설정 FK및 NOTNULL 추가 필요함
-- FK >> 테이블_FK_컬럼명
-- CHECK 제약 조건 생성시 이름 CH_컬럼명 테이블 레벨로 작성
-- 예) CONSTRAINT CH_ANSWER_NO CHECK (ANSWER_NO BETWEEN 1 AND 10)
-- DATE 형식
-- 날짜컬럼명 DATE NOT NULL DEFAULT SYSDATE,
-- 컬럼명 아래처럼 적어주세요
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '명칭’;

DROP TABLE TB_MEMBER CASCADE CONSTRAINTS;
DROP TABLE TB_SOCIAL_MEMBER CASCADE CONSTRAINTS;
DROP TABLE TB_SUBSCRIBE CASCADE CONSTRAINTS;
DROP TABLE TB_BLOCK_MEMBER CASCADE CONSTRAINTS;
DROP TABLE TB_RESUME  CASCADE CONSTRAINTS;
DROP TABLE TB_VISIT_COUNT CASCADE CONSTRAINTS;
DROP TABLE TB_EXPERIENCE CASCADE CONSTRAINTS;
DROP TABLE TB_EDUCATION CASCADE CONSTRAINTS;
DROP TABLE TB_ACTIVITY CASCADE CONSTRAINTS;
DROP TABLE TB_SKILL  CASCADE CONSTRAINTS;
DROP TABLE TB_RESUME_SKILL CASCADE CONSTRAINTS;
DROP TABLE TB_ACCEPTED_KEYWORDS CASCADE CONSTRAINTS;
DROP TABLE TB_INTERVIEW CASCADE CONSTRAINTS;
DROP TABLE TB_INTERVIEW_ANALYSIS CASCADE CONSTRAINTS;
DROP TABLE TB_INTERVIEW_QUESTION CASCADE CONSTRAINTS;
DROP TABLE TB_VOICE_SENTENCE CASCADE CONSTRAINTS;
DROP TABLE TB_VIDEO CASCADE CONSTRAINTS;
DROP TABLE TB_VOICE CASCADE CONSTRAINTS;
DROP TABLE TB_TREND  CASCADE CONSTRAINTS;
DROP TABLE TB_SEARCHWORD CASCADE CONSTRAINTS;
DROP TABLE TB_NOTICE CASCADE CONSTRAINTS;
DROP TABLE TB_CHATBOT CASCADE CONSTRAINTS;
DROP TABLE TB_COMMUNITY_BOARD CASCADE CONSTRAINTS;
DROP TABLE TB_CB_COMMENT CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT_REPORT CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD_REPORT CASCADE CONSTRAINTS;
DROP TABLE TB_COMPANY_LIST CASCADE CONSTRAINTS;
DROP TABLE TB_REFRESH_TOKENS CASCADE CONSTRAINTS;
DROP TABLE TB_CHATROOM CASCADE CONSTRAINTS;
DROP TABLE TB_CHATROOM_MEMBERS CASCADE CONSTRAINTS;
DROP TABLE TB_MESSAGES CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_COM_NO;
DROP SEQUENCE SEQ_B_REPORT_NO;
DROP SEQUENCE SEQ_COMMUNITY_NO;
DROP SEQUENCE SEQ_CHATBOT_NO;
DROP SEQUENCE SEQ_NOTICE_NO;
DROP SEQUENCE SEQ_SEARCHWORD_NO;
DROP SEQUENCE SEQ_TREND_NO;
DROP SEQUENCE SEQ_VOICE_NO;
DROP SEQUENCE SEQ_ITV_NO;
DROP SEQUENCE SEQ_ACTIVITY_NO;
DROP SEQUENCE SEQ_EDUCATION_NO;
DROP SEQUENCE SEQ_EXPERIENCE_NO;
DROP SEQUENCE SEQ_RESUME_NO;
DROP SEQUENCE RESUME_NO_SEQ;
DROP SEQUENCE SEQ_VISIT_NO;
DROP SEQUENCE SEQ_BLOCK_NO;
DROP SEQUENCE SEQ_PAY_NO;
DROP SEQUENCE SEQ_SOCIAL_NO;
DROP SEQUENCE SEQ_MEMBER_NO;
DROP SEQUENCE SEQ_CHAT_ROOMS_NO;
DROP SEQUENCE SEQ_MESSAGES_NO;

-- 24개

-- 회원 정보

CREATE TABLE TB_MEMBER (
    MEMBER_NO NUMBER,
    MEMBER_EMAIL VARCHAR2(500) NOT NULL,
    MEMBER_PWD VARCHAR2(500),
    MEMBER_NAME VARCHAR2(200) NOT NULL,
    NICKNAME VARCHAR2(200),
    SUBSCRIBE_YN VARCHAR2(1),
    ADMIN VARCHAR2(200),
    PAYMENT_DATE DATE,
    EXPIRE_DATE DATE,
    SIGNUP_DATE DATE NOT NULL,
    WITHDRAWAL_DATE DATE,
    MEMBER_UPDATE DATE,
    LOGIN_TYPE VARCHAR2(50) NOT NULL,
    SNS_ACCESS_TOKEN VARCHAR2(255),
    CONSTRAINT MEMBER_PK_MEMBER_NO PRIMARY KEY (MEMBER_NO)
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_EMAIL IS '회원 이메일';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN TB_MEMBER.NICKNAME IS '회원 닉네임';
COMMENT ON COLUMN TB_MEMBER.SUBSCRIBE_YN IS '회원 구독여부';
COMMENT ON COLUMN TB_MEMBER.ADMIN IS '관리자';
COMMENT ON COLUMN TB_MEMBER.PAYMENT_DATE IS '회원 결제일';
COMMENT ON COLUMN TB_MEMBER.EXPIRE_DATE IS '회원 구독 만료일';
COMMENT ON COLUMN TB_MEMBER.SIGNUP_DATE IS '회원 가입일';
COMMENT ON COLUMN TB_MEMBER.WITHDRAWAL_DATE IS '회원 탈퇴일';
COMMENT ON COLUMN TB_MEMBER.MEMBER_UPDATE IS '회원 정보수정일';
COMMENT ON COLUMN TB_MEMBER.LOGIN_TYPE IS '로그인타입';
COMMENT ON COLUMN TB_MEMBER.SNS_ACCESS_TOKEN IS 'SNS access token for any login type';

-- 토큰 정보

CREATE TABLE TB_REFRESH_TOKENS(
    ID RAW(36) DEFAULT SYS_GUID() NOT NULL,
    MEMBER_NO NUMBER NOT NULL,
    TOKEN_VALUE VARCHAR2(255) NOT NULL,
    ISSUED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EXPIRES_IN NUMBER NOT NULL,
    EXPIRATION_DATE TIMESTAMP NOT NULL,
    MEMBER_AGENT VARCHAR2(255),
    STATUS VARCHAR2(50),
    CONSTRAINT PK_RTOKENS PRIMARY KEY (ID),
    CONSTRAINT FK_RTOKENS FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO) ON DELETE CASCADE
    );
    
    COMMENT ON COLUMN TB_REFRESH_TOKENS.ID IS '토큰식별ID';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.MEMBER_NO IS '토큰사용자고유번호';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.TOKEN_VALUE IS '토큰값';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.ISSUED_AT IS '토큰생성날짜시간';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.EXPIRES_IN IS '토큰만료시간';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.EXPIRATION_DATE IS '토큰만료날짜시간';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.MEMBER_AGENT IS '토큰발급에이전트';
    COMMENT ON COLUMN TB_REFRESH_TOKENS.STATUS IS '토큰상태';



-- 소셜 회원정보

CREATE TABLE TB_SOCIAL_MEMBER (
    SOCIAL_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    EMAIL VARCHAR2(500) NOT NULL,
    NICKNAME VARCHAR2(200),
    CONSTRAINT SOCIAL_PK_SOCIAL_NO PRIMARY KEY (SOCIAL_NO),
    CONSTRAINT SOCIAL_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_SOCIAL_MEMBER.SOCIAL_NO IS '회원 소셜번호';
COMMENT ON COLUMN TB_SOCIAL_MEMBER.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_SOCIAL_MEMBER.EMAIL IS '회원 이메일';
COMMENT ON COLUMN TB_SOCIAL_MEMBER.NICKNAME IS '회원 닉네임';


-- 방문자 테이블

CREATE TABLE TB_VISIT_COUNT (
VISIT_NO NUMBER,
MEMBER_NO NUMBER NOT NULL,
VISIT_COUNT NUMBER,
VISIT_DATE DATE,
CONSTRAINT VISIT_PK_VISIT_NO PRIMARY KEY (VISIT_NO),
CONSTRAINT VISIT_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_VISIT_COUNT.VISIT_NO IS '방문자 번호';
COMMENT ON COLUMN TB_VISIT_COUNT.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_VISIT_COUNT.VISIT_COUNT IS '방문 횟수';
COMMENT ON COLUMN TB_VISIT_COUNT.VISIT_DATE IS '방문일';


-- 구독결제 회원

CREATE TABLE TB_SUBSCRIBE (
    PAY_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    AMOUNT NUMBER,
    PAYMENT_DATE DATE,
    EXPIRY_DATE DATE,
    CONSTRAINT SUB_PK_PAY_NO PRIMARY KEY (PAY_NO),
    CONSTRAINT SUB_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_SUBSCRIBE.PAY_NO IS '회원 결제번호';
COMMENT ON COLUMN TB_SUBSCRIBE.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_SUBSCRIBE.PAY_AMOUNT IS '회원 결제누적금액';
COMMENT ON COLUMN TB_SUBSCRIBE.PAYMENT_DATE IS '회원 결제일';
COMMENT ON COLUMN TB_SUBSCRIBE.EXPIRY_DATE IS '회원 구독 만료일';

-- 차단회원
CREATE TABLE TB_BLOCK_MEMBER (
    BLOCK_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    BLOCK_YN VARCHAR2(1) NOT NULL,
    BLOCK_COMMENT VARCHAR2(3000),
    BLOCK_DATE DATE NOT NULL,
    CONSTRAINT BLOCK_PK_BLOACK_NO PRIMARY KEY (BLOCK_NO),
    CONSTRAINT BLOCK_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_BLOCK_MEMBER.BLOCK_NO IS '회원 차단번호';
COMMENT ON COLUMN TB_BLOCK_MEMBER.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_BLOCK_MEMBER.BLOCK_YN IS '회원 차단 여부';
COMMENT ON COLUMN TB_BLOCK_MEMBER.BLOCK_COMMENT IS '회원 차단 사유';
COMMENT ON COLUMN TB_BLOCK_MEMBER.BLOCK_DATE IS '차단일';


-- 이력서
CREATE TABLE TB_RESUME (
RESUME_NO NUMBER,
MEMBER_NO NUMBER NOT NULL,
TITLE VARCHAR2(100) NOT NULL,
RESUME_NAME VARCHAR2(100) NOT NULL,
EMAIL VARCHAR2(100) NOT NULL,
PHONE VARCHAR2(100) NOT NULL,
BOOKMARKED VARCHAR2(1) DEFAULT 'N',
JOB_CATEGORY VARCHAR2(100) NOT NULL,
CREATE_DATE DATE DEFAULT(SYSDATE) NOT NULL,
MODIFICATION_DATE DATE,
DELETE_DATE DATE,
INTRODUCTION VARCHAR2(4000) NOT NULL,
CONSTRAINT RESUME_PK_RESUME_NO PRIMARY KEY (RESUME_NO),
CONSTRAINT RESUME_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_RESUME.RESUME_NO IS '이력서 번호';
COMMENT ON COLUMN TB_RESUME.MEMBER_NO IS '멤버 번호';
COMMENT ON COLUMN TB_RESUME.TITLE IS '이력서 제목';
COMMENT ON COLUMN TB_RESUME.RESUME_NAME IS '이름';
COMMENT ON COLUMN TB_RESUME.EMAIL IS '이메일';
COMMENT ON COLUMN TB_RESUME.PHONE IS '전화번호';
COMMENT ON COLUMN TB_RESUME.BOOKMARKED IS '스크랩 여부';
COMMENT ON COLUMN TB_RESUME.JOB_CATEGORY IS '직무 카테고리';
COMMENT ON COLUMN TB_RESUME.CREATE_DATE IS '이력서 생성일';
COMMENT ON COLUMN TB_RESUME.MODIFICATION_DATE IS '이력서 수정일';
COMMENT ON COLUMN TB_RESUME.DELETE_DATE IS '이력서 삭제일';
COMMENT ON COLUMN TB_RESUME.INTRODUCTION IS '자기 소개서';


-- 경력
CREATE TABLE TB_EXPERIENCE (
EXPERIENCE_NO NUMBER,
RESUME_NO NUMBER NOT NULL,
COM_NAME VARCHAR2(100) NOT NULL,
EX_DURATION NUMBER NOT NULL,
EX_CURRENT VARCHAR2(1) NOT NULL,
DEPARTMENT VARCHAR2(100) NOT NULL,
EX_POSITION VARCHAR2(100) NOT NULL,
RESPONSIBILITIES VARCHAR2(2000) NOT NULL,
START_DATE DATE NOT NULL,
END_DATE DATE,
CONSTRAINT EX_PK_EXPERIENCE_NO PRIMARY KEY (EXPERIENCE_NO),
CONSTRAINT EX_FK_RESUME_NO FOREIGN KEY (RESUME_NO) REFERENCES TB_RESUME (RESUME_NO)
);

COMMENT ON COLUMN TB_EXPERIENCE.EXPERIENCE_NO IS '경력 번호';
COMMENT ON COLUMN TB_EXPERIENCE.RESUME_NO IS '이력서 번호';
COMMENT ON COLUMN TB_EXPERIENCE.COM_NAME IS '회사명';
COMMENT ON COLUMN TB_EXPERIENCE.EX_DURATION IS '근무기간';
COMMENT ON COLUMN TB_EXPERIENCE.EX_CURRENT IS '재직 여부';
COMMENT ON COLUMN TB_EXPERIENCE.DEPARTMENT IS '부서명';
COMMENT ON COLUMN TB_EXPERIENCE.EX_POSITION IS '직책';
COMMENT ON COLUMN TB_EXPERIENCE.RESPONSIBILITIES IS '담당업무';
COMMENT ON COLUMN TB_EXPERIENCE.START_DATE IS '시작일';
COMMENT ON COLUMN TB_EXPERIENCE.END_DATE IS '종료일';

-- 학력
CREATE TABLE TB_EDUCATION (
EDUCATION_NO NUMBER,
RESUME_NO NUMBER NOT NULL,
SCHOOLNAME VARCHAR2(100) NOT NULL,
EDUCATION_CURRENT VARCHAR2(1) NOT NULL,
MAJOR VARCHAR2(100) NOT NULL,
DEGREE VARCHAR2(100) NOT NULL,
SCORE NUMBER NOT NULL,
START_DATE DATE NOT NULL,
END_DATE DATE,
CONSTRAINT EDU_PK_EDUCATION_NO PRIMARY KEY (EDUCATION_NO),
CONSTRAINT EDU_FK_RESUME_NO FOREIGN KEY (RESUME_NO) REFERENCES TB_RESUME (RESUME_NO)
);

COMMENT ON COLUMN TB_EDUCATION.EDUCATION_NO IS '학력 번호';
COMMENT ON COLUMN TB_EDUCATION.RESUME_NO IS '이력서 번호';
COMMENT ON COLUMN TB_EDUCATION.SCHOOLNAME  IS '학교명';
COMMENT ON COLUMN TB_EDUCATION.EDUCATION_CURRENT IS '재학 여부';
COMMENT ON COLUMN TB_EDUCATION.MAJOR IS '전공';
COMMENT ON COLUMN TB_EDUCATION.DEGREE IS '학위';
COMMENT ON COLUMN TB_EDUCATION.SCORE IS '학점';
COMMENT ON COLUMN TB_EDUCATION.START_DATE IS '입학일';
COMMENT ON COLUMN TB_EDUCATION.END_DATE IS '졸업일';

-- 활동
CREATE TABLE TB_ACTIVITY (
ACTIVITY_NO NUMBER,
RESUME_NO NUMBER NOT NULL,
ACTIVITY_NAME VARCHAR2(100) NOT NULL,
ACTIVITY_DESCRIPTION VARCHAR2(2000) NOT NULL,
ORGANIZER	 VARCHAR2(200) NOT NULL,
START_DATE DATE NOT NULL,
END_DATE DATE NOT NULL,
CONSTRAINT ACT_PK_ACTIVITY_NO PRIMARY KEY (ACTIVITY_NO),
CONSTRAINT ACT_FK_RESUME_NO FOREIGN KEY (RESUME_NO) REFERENCES TB_RESUME (RESUME_NO)
);

COMMENT ON COLUMN TB_ACTIVITY.ACTIVITY_NO IS '활동 번호';
COMMENT ON COLUMN TB_ACTIVITY.RESUME_NO IS '이력서 번호';
COMMENT ON COLUMN TB_ACTIVITY.ACTIVITY_NAME IS '활동명';
COMMENT ON COLUMN TB_ACTIVITY.ACTIVITY_DESCRIPTION IS '활동 내용';
COMMENT ON COLUMN TB_ACTIVITY.ORGANIZER IS '주최기관';
COMMENT ON COLUMN TB_ACTIVITY.START_DATE IS '시작일';
COMMENT ON COLUMN TB_ACTIVITY.END_DATE IS '종료일';

-- 스킬
CREATE TABLE TB_SKILL (
SKILL_ID NUMBER NOT NULL,
SKILL_NAME VARCHAR2(100)UNIQUE,
CONSTRAINT SKILL_PK_SKILL_ID PRIMARY KEY (SKILL_ID)
);

COMMENT ON COLUMN TB_SKILL.SKILL_ID IS '스킬 번호';
COMMENT ON COLUMN TB_SKILL.SKILL_NAME IS '스킬명';


-- TB_RESUME_SKILL 테이블 생성
CREATE TABLE TB_RESUME_SKILL (
RESUME_NO NUMBER,
SKILL_ID NUMBER,
PRIMARY KEY (RESUME_NO, SKILL_ID),
FOREIGN KEY (RESUME_NO) REFERENCES TB_RESUME(RESUME_NO),
FOREIGN KEY (SKILL_ID) REFERENCES TB_SKILL(SKILL_ID)
);

COMMENT ON COLUMN TB_RESUME_SKILL.RESUME_NO IS '이력서 번호';
COMMENT ON COLUMN TB_RESUME_SKILL.SKILL_ID IS '스킬 번호';

-- 합격 키워드
CREATE TABLE TB_ACCEPTED_KEYWORDS (
  JOB_TITLE VARCHAR2(100),
  KEYWORD VARCHAR2(2000) NOT NULL,
  CONSTRAINT ACCEPTED_PK_JOB_TITLE PRIMARY KEY (JOB_TITLE)
);

COMMENT ON COLUMN TB_ACCEPTED_KEYWORDS.JOB_TITLE IS '직무 카테고리';
COMMENT ON COLUMN TB_ACCEPTED_KEYWORDS.KEYWORD IS '키워드 사용빈도';



-- AI 면접

CREATE TABLE TB_INTERVIEW (
    ITV_NO NUMBER,
    MEMBER_NO NUMBER,
    TITLE VARCHAR2(500) NOT NULL,
    VIDEO_SCORE NUMBER NOT NULL,
    VOICE_SCORE NUMBER NOT NULL,
    ITV_DATE DATE DEFAULT SYSDATE NOT NULL,
URL VARCHAR2(500) NOT NULL,
    CONSTRAINT PK_ITV_NO PRIMARY KEY (ITV_NO),
    CONSTRAINT FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO),
CONSTRAINT CH_VIDEO_SCORE CHECK (VIDEO_SCORE BETWEEN 1 AND 100),
CONSTRAINT CH_VOICE_SCORE CHECK (VOICE_SCORE BETWEEN 1 AND 100)
);

COMMENT ON COLUMN TB_INTERVIEW.ITV_NO IS '면접 번호';
COMMENT ON COLUMN TB_INTERVIEW.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_INTERVIEW.TITLE IS '제목';
COMMENT ON COLUMN TB_INTERVIEW.VIDEO_SCORE IS '영상총점수';
COMMENT ON COLUMN TB_INTERVIEW.VOICE_SCORE IS '음성총점수';
COMMENT ON COLUMN TB_INTERVIEW.ITV_DATE IS '등록 날짜';
COMMENT ON COLUMN TB_INTERVIEW.URL  IS '영상위치 URL';


-- AI 면접 VIDEO 데이터

CREATE TABLE TB_VIDEO (
    VIDEO_NO NUMBER,
    ITV_NO NUMBER NOT NULL,
    ANSWER_NO NUMBER NOT NULL,
    RESULT_DATA NUMBER NOT NULL,
    ITV_TYPE VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_VIDEO_DATA PRIMARY KEY (VIDEO_NO),
    CONSTRAINT VIDEO_FK_ITV_NO FOREIGN KEY (ITV_NO) REFERENCES TB_INTERVIEW(ITV_NO),
CONSTRAINT CH_ANSWER_NO CHECK (ANSWER_NO BETWEEN 1 AND 10),
CONSTRAINT CH_RESULT_DATA CHECK (RESULT_DATA BETWEEN 1 AND 100),
CONSTRAINT CH_ITV_TYPE CHECK (ITV_TYPE IN ('ANS', 'POS', 'EMO', 'EYE'))
);
COMMENT ON COLUMN TB_VIDEO.VIDEO_NO IS '비디오 번호';
COMMENT ON COLUMN TB_VIDEO.ITV_NO IS '면접 번호';
COMMENT ON COLUMN TB_VIDEO.ANSWER_NO IS '답변 순서';
COMMENT ON COLUMN TB_VIDEO.RESULT_DATA IS '결과 수치';
COMMENT ON COLUMN TB_VIDEO.ITV_TYPE IS '결과 타입';

-- 면접 질문
CREATE TABLE TB_INTERVIEW_QUESTION (
    Q_NO NUMBER, 
    Q_CONTENT VARCHAR2(500) NOT NULL,
    Q_TYPE VARCHAR2(200) NOT NULL,
    CONSTRAINT INTERVIEW_PK_Q_NO PRIMARY KEY (Q_NO)
);

COMMENT ON COLUMN TB_INTERVIEW_QUESTION.Q_NO IS '질문 번호';
COMMENT ON COLUMN TB_INTERVIEW_QUESTION.Q_CONTENT  IS '질문 내용';
COMMENT ON COLUMN TB_INTERVIEW_QUESTION.Q_TYPE  IS '질문 유형';

-- AI 음성
CREATE TABLE TB_VOICE (
    VOICE_NO NUMBER,
    ITV_NO NUMBER NOT NULL,
    Q_NO NUMBER NOT NULL,
    VOICE_CONTENT CLOB NOT NULL,
    ANSWER_NO NUMBER NOT NULL,
FREQUENT_WORD VARCHAR2(50),
    CONSTRAINT VOICE_PK_VOICE_NO PRIMARY KEY (VOICE_NO),
    CONSTRAINT VOICE_FK_ITV_NO FOREIGN KEY (ITV_NO) REFERENCES TB_INTERVIEW(ITV_NO),
    CONSTRAINT VOICE_FK_Q_NO FOREIGN KEY (Q_NO) REFERENCES TB_INTERVIEW_QUESTION(Q_NO)
);

COMMENT ON COLUMN TB_VOICE.VOICE_NO IS '답변 번호';
COMMENT ON COLUMN TB_VOICE.ITV_NO IS '면접 번호';
COMMENT ON COLUMN TB_VOICE.Q_NO IS '질문 번호';
COMMENT ON COLUMN TB_VOICE.VOICE_CONTENT IS '답변 내용';
COMMENT ON COLUMN TB_VOICE.ANSWER_NO IS '답변 순서';
COMMENT ON COLUMN TB_VOICE.FREQUENT_WORD  IS '자주 사용한 단어';

-- 면접 결과분석
CREATE TABLE TB_INTERVIEW_ANALYSIS (
    ANALYSIS_NO NUMBER, 
    ANALYSIS_CONTENT VARCHAR2(500) NOT NULL, 
    ANALYSIS_TYPE VARCHAR2(1) NOT NULL,
    ANALYSIS_CATEGORY VARCHAR2(50) NOT NULL,
    CONSTRAINT INTERVIEW_PK_ANALYSIS_NO PRIMARY KEY (ANALYSIS_NO)
);
COMMENT ON COLUMN TB_INTERVIEW_ANALYSIS.ANALYSIS_NO IS '멘트 번호';
COMMENT ON COLUMN TB_INTERVIEW_ANALYSIS.ANALYSIS_CONTENT IS '분석멘트 내용';
COMMENT ON COLUMN TB_INTERVIEW_ANALYSIS.ANALYSIS_TYPE  IS '분석 타입';
COMMENT ON COLUMN TB_INTERVIEW_ANALYSIS.ANALYSIS_CATEGORY IS '분석 분류';


-- 문장별 분석
CREATE TABLE TB_VOICE_SENTENCE (
    VS_NO NUMBER,
    VOICE_NO NUMBER NOT NULL,
    SENTENCE VARCHAR2(500) NOT NULL,
    VSEN_POSITIVE NUMBER,
    VSEN_NEGATIVE NUMBER,
    CONSTRAINT VSEN_PK_VS_NO PRIMARY KEY (VS_NO),
    CONSTRAINT VSEN_FK_VOICE_NO FOREIGN KEY (VOICE_NO) REFERENCES TB_VOICE (VOICE_NO)
);
COMMENT ON COLUMN TB_VOICE_SENTENCE.VS_NO  IS '문장 번호';
COMMENT ON COLUMN TB_VOICE_SENTENCE.VOICE_NO IS '답변 번호';
COMMENT ON COLUMN TB_VOICE_SENTENCE.SENTENCE IS '문장 내용';
COMMENT ON COLUMN TB_VOICE_SENTENCE.VSEN_POSITIVE IS '긍정수치';
COMMENT ON COLUMN TB_VOICE_SENTENCE.VSEN_NEGATIVE IS '부정수치';

-- 트렌드 서칭
CREATE TABLE TB_TREND (
    TREND_NO NUMBER,
    TITLE VARCHAR2(500) NOT NULL,
    TREND_CONTENT VARCHAR2(4000) NOT NULL,
    TREND_LINK VARCHAR2(1000) NOT NULL,
    TREND_DATE DATE NOT NULL,
    CONSTRAINT TREND_PK_TREND_NO PRIMARY KEY (TREND_NO)
);

COMMENT ON COLUMN TB_TREND.TREND_NO IS '트렌드 번호';
COMMENT ON COLUMN TB_TREND.TITLE IS '트렌드 제목';
COMMENT ON COLUMN TB_TREND.TREND_CONTENT IS '트렌드 내용';
COMMENT ON COLUMN TB_TREND.TREND_LINK IS '트렌드 하이퍼링크 주소';
COMMENT ON COLUMN TB_TREND.TREND_DATE IS '트렌드 등록일';

-- 인기 검색어
CREATE TABLE TB_SEARCHWORD (
    SEARCHWORD_NO NUMBER,
    KEYWORD VARCHAR2(400) NOT NULL,
    SEARCHWORD_COUNT NUMBER NOT NULL,
    CONSTRAINT SEARCHWORD_PK_SEARCHWORD_NO PRIMARY KEY (SEARCHWORD_NO)
);
COMMENT ON COLUMN TB_SEARCHWORD.SEARCHWORD_NO IS '검색어 번호';
COMMENT ON COLUMN TB_SEARCHWORD.KEYWORD IS '검색어';
COMMENT ON COLUMN TB_SEARCHWORD.SEARCHWORD_COUNT IS '검색된 횟수';

-- 공지
CREATE TABLE TB_NOTICE (
    NOTICE_NO NUMBER,
    NOTICE_TITLE VARCHAR2(50) NOT NULL,
    NOTICE_DATE DATE NOT NULL,
    MEMBER_NO NUMBER NOT NULL,
    NOTICE_CONTENT VARCHAR2(1000) NOT NULL,
    NOTICE_READCOUNT NUMBER NOT NULL,
    NOTICE_IMPORTENT DATE NOT NULL,
    CONSTRAINT NOTICE_PK_NOTICE_NO PRIMARY KEY (NOTICE_NO),
    CONSTRAINT NOTICE_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_NOTICE.NOTICE_NO IS '공지글 번호';
COMMENT ON COLUMN TB_NOTICE.NOTICE_TITLE IS '공지글 제목';
COMMENT ON COLUMN TB_NOTICE.NOTICE_DATE IS '등록 날짜';
COMMENT ON COLUMN TB_NOTICE.MEMBER_NO IS '회원 번호';
COMMENT ON COLUMN TB_NOTICE.NOTICE_CONTENT IS '내용';
COMMENT ON COLUMN TB_NOTICE.NOTICE_READCOUNT IS '조회수';
COMMENT ON COLUMN TB_NOTICE.NOTICE_IMPORTENT IS '중요도 표시기한';



-- 챗봇

CREATE TABLE TB_CHATBOT (
    CHATBOT_NO NUMBER,	
    CHATBOT_QUESTION VARCHAR2(500) NOT NULL,
    CHATBOT_ANSWER VARCHAR2(500) NOT NULL,
    CONSTRAINT CHATBOT_PK_CHATBOT_NO PRIMARY KEY (CHATBOT_NO)
);

COMMENT ON COLUMN TB_CHATBOT.CHATBOT_NO IS '챗봇기능 번호';
COMMENT ON COLUMN TB_CHATBOT.CHATBOT_QUESTION  IS  '질문 내용';
COMMENT ON COLUMN TB_CHATBOT.CHATBOT_ANSWER IS '답변 내용';

-- 커뮤니티 게시판
CREATE TABLE TB_COMMUNITY_BOARD (
    COMMUNITY_NO NUMBER, 
    MEMBER_NO NUMBER NOT NULL, 
    TITLE VARCHAR2(200) NOT NULL,
    COMMUNITY_CONTENT VARCHAR2(3000) NOT NULL, 
    FILE_UPLOAD VARCHAR2(100),
    FILE_MODIFIED VARCHAR2(100), 
    COMMUNITY_DATE DATE NOT NULL,
MODIFIED_DATE DATE,
DELETED_DATE DATE,
READCOUNT NUMBER DEFAULT 0,
    CONSTRAINT BOARD_PK_COMMUNITY_NO PRIMARY KEY (COMMUNITY_NO),
    CONSTRAINT BOARD_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO)
);

COMMENT ON COLUMN TB_COMMUNITY_BOARD.COMMUNITY_NO IS '게시글 번호';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.MEMBER_NO IS '작성자 번호';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.TITLE IS '게시글 제목';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.COMMUNITY_CONTENT IS '게시글 내용';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.FILE_UPLOAD IS '파일 업로드명';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.FILE_MODIFIED IS '파일 수정명';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.COMMUNITY_DATE IS '작성 날짜';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.MODIFIED_DATE   IS '수정 날짜';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.DELETED_DATE    IS '삭제 날짜';
COMMENT ON COLUMN TB_COMMUNITY_BOARD.READCOUNT  IS '조회수';

-- 신고 게시판
CREATE TABLE TB_BOARD_REPORT (
    B_REPORT_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    COMMUNITY_NO NUMBER NOT NULL,
    REPORT_TYPE VARCHAR2(100) NOT NULL CHECK (REPORT_TYPE IN ('욕설 및 비방', '광고', '도배')), 
    REPORT_DATE DATE NOT NULL,
    HANDLED_YN VARCHAR2(2) DEFAULT 'N' NOT NULL,
    ADMIN_NO NUMBER,
    HANDLED_DATE DATE,
    CONSTRAINT REPORT_PK_B_REPORT_NO PRIMARY KEY (B_REPORT_NO),
    CONSTRAINT REPORT_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO),
CONSTRAINT REPORT_FK_COMMUNITY_NO FOREIGN KEY (COMMUNITY_NO) REFERENCES TB_COMMUNITY_BOARD (COMMUNITY_NO)
);

ALTER TABLE TB_BOARD_REPORT
ADD CONSTRAINT REPORT_FK_ADMIN_NO FOREIGN KEY (ADMIN_NO) REFERENCES TB_MEMBER (MEMBER_NO);

COMMENT ON COLUMN TB_BOARD_REPORT.B_REPORT_NO IS '신고 번호';
COMMENT ON COLUMN TB_BOARD_REPORT.MEMBER_NO IS '신고자 번호';
COMMENT ON COLUMN TB_BOARD_REPORT.COMMUNITY_NO IS '글 번호';
COMMENT ON COLUMN TB_BOARD_REPORT.REPORT_TYPE IS '신고 사유';
COMMENT ON COLUMN TB_BOARD_REPORT.REPORT_DATE IS '신고 날짜';
COMMENT ON COLUMN TB_BOARD_REPORT.HANDLED_YN  IS '처리 여부';
COMMENT ON COLUMN TB_BOARD_REPORT.ADMIN_NO IS '처리 관리자';
COMMENT ON COLUMN TB_BOARD_REPORT.HANDLED_DATE IS '처리 날짜';

-- 댓글
CREATE TABLE TB_CB_COMMENT (
    COMMENT_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    COMMUNITY_NO NUMBER NOT NULL,
    COMMENT_PARENT NUMBER,
    COMMENT_CONTENT VARCHAR2(500) NOT NULL,
    COMMENT_DATE DATE NOT NULL,
MODIFIED_DATE DATE,
DELETED_DATE DATE,
    CONSTRAINT COMMENT_PK_COMMENT_NO PRIMARY KEY (COMMENT_NO),
    CONSTRAINT COMMENT_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO),
CONSTRAINT COMMENT_FK_COMMUNITY_NO FOREIGN KEY (COMMUNITY_NO) REFERENCES TB_COMMUNITY_BOARD (COMMUNITY_NO)
);

ALTER TABLE TB_CB_COMMENT
ADD CONSTRAINT COMMENT_FK_COMMENT_PARENT FOREIGN KEY (COMMENT_PARENT) REFERENCES TB_CB_COMMENT (COMMENT_NO);

COMMENT ON COLUMN TB_CB_COMMENT.COMMENT_NO IS '댓글 번호';
COMMENT ON COLUMN TB_CB_COMMENT.MEMBER_NO IS '작성자 번호';
COMMENT ON COLUMN TB_CB_COMMENT.COMMUNITY_NO IS '게시글 번호';
COMMENT ON COLUMN TB_CB_COMMENT.COMMENT_PARENT IS '원댓글 번호';
COMMENT ON COLUMN TB_CB_COMMENT.COMMENT_CONTENT IS '댓글 내용';
COMMENT ON COLUMN TB_CB_COMMENT.MODIFIED_DATE   IS '수정 날짜';
COMMENT ON COLUMN TB_CB_COMMENT.DELETED_DATE    IS '삭제 날짜';
COMMENT ON COLUMN TB_CB_COMMENT.COMMENT_DATE IS '작성 날짜';



-- 신고 댓글
CREATE TABLE TB_COMMENT_REPORT (
    C_REPORT_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    COMMENT_NO NUMBER,
    REPORT_TYPE VARCHAR2(100) NOT NULL,
    REPORT_DATE DATE NOT NULL,
HANDLED_YN VARCHAR2(2) DEFAULT 'N' NOT NULL,
    ADMIN_NO NUMBER,
    HANDLED_DATE DATE,
    CONSTRAINT CREPORT_PK_C_REPORT_NO PRIMARY KEY (C_REPORT_NO),
    CONSTRAINT CREPORT_FK_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES TB_MEMBER (MEMBER_NO),
    CONSTRAINT CREPORT_FK_COMMENT_NO FOREIGN KEY (COMMENT_NO) REFERENCES TB_CB_COMMENT (COMMENT_NO)
);

ALTER TABLE TB_COMMENT_REPORT
ADD CONSTRAINT CREPORT_FK_ADMIN_NO FOREIGN KEY (ADMIN_NO) REFERENCES TB_MEMBER (MEMBER_NO);
COMMENT ON COLUMN TB_COMMENT_REPORT.C_REPORT_NO IS '신고 번호';
COMMENT ON COLUMN TB_COMMENT_REPORT.MEMBER_NO IS '신고자 번호';
COMMENT ON COLUMN TB_COMMENT_REPORT.COMMENT_NO IS '댓글 번호';
COMMENT ON COLUMN TB_COMMENT_REPORT.REPORT_TYPE IS '신고 사유';
COMMENT ON COLUMN TB_COMMENT_REPORT.REPORT_DATE IS '신고 날짜';
COMMENT ON COLUMN TB_COMMENT_REPORT.HANDLED_YN  IS '처리 여부';
COMMENT ON COLUMN TB_COMMENT_REPORT.ADMIN_NO IS '처리 관리자';
COMMENT ON COLUMN TB_COMMENT_REPORT.HANDLED_DATE IS '처리 날짜';



-- 공고 리스트

CREATE TABLE TB_COMPANY_LIST (
    COM_NO NUMBER,
    COM_NAME VARCHAR2(100) NOT NULL,
    COM_TITLE VARCHAR2(200) NOT NULL,
    COM_DATE DATE NOT NULL,
    COM_LINK VARCHAR2(500) NOT NULL,
    CONSTRAINT COMPANY_PK_COM_NO PRIMARY KEY (COM_NO)
);
COMMENT ON COLUMN TB_COMPANY_LIST.COM_NO IS '기업공고번호';
COMMENT ON COLUMN TB_COMPANY_LIST.COM_NAME IS '회사명';
COMMENT ON COLUMN TB_COMPANY_LIST.COM_TITLE IS '공고명';
COMMENT ON COLUMN TB_COMPANY_LIST.COM_DATE IS '공고 날짜';
COMMENT ON COLUMN TB_COMPANY_LIST.COM_LINK IS '공고 사이트 링크';

-- 채팅방

CREATE TABLE TB_CHATROOM (
    CHATROOM_NO NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    NAME VARCHAR2(100) NOT NULL,
    CHATROOM_DATE DATE DEFAULT SYSDATE NOT NULL,
    MODIFIED_DATE DATE,
    DELETED_DATE DATE,
    CONSTRAINT PK_CHATROOM_NO PRIMARY KEY(CHATROOM_NO),
    CONSTRAINT FK_CHATROOM_MEMNO FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO)
);

COMMENT ON COLUMN TB_CHATROOM.CHATROOM_NO IS '채팅방번호';
COMMENT ON COLUMN TB_CHATROOM.MEMBER_NO IS '생성자 번호';
COMMENT ON COLUMN TB_CHATROOM.NAME IS '채팅방 이름';
COMMENT ON COLUMN TB_CHATROOM.CHATROOM_DATE IS '생성 날짜';
COMMENT ON COLUMN TB_CHATROOM.MODIFIED_DATE IS '수정 날짜';
COMMENT ON COLUMN TB_CHATROOM.DELETED_DATE IS '삭제 날짜';

-- 채팅방멤버

CREATE TABLE TB_CHATROOM_MEMBERS (
    CHATROOM_NO NUMBER,
    MEMBER_NO NUMBER,
    JOIN_DATE DATE DEFAULT SYSDATE NOT NULL,
    PRIMARY KEY(CHATROOM_NO, MEMBER_NO),
    CONSTRAINT FK_CHATROOM_MEMBERS_CHATNO FOREIGN KEY(CHATROOM_NO) REFERENCES TB_CHATROOM(CHATROOM_NO),
    CONSTRAINT FK_CHATROOM_MEMBERS_MEMNO FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO)
);

COMMENT ON COLUMN TB_CHATROOM_MEMBERS.CHATROOM_NO IS '채팅방번호';
COMMENT ON COLUMN TB_CHATROOM_MEMBERS.MEMBER_NO IS '채팅방 멤버 번호';
COMMENT ON COLUMN TB_CHATROOM_MEMBERS.JOIN_DATE IS '참여 날짜';

-- 메세지

CREATE TABLE TB_MESSAGES (
    MESSAGE_NO NUMBER,
    CHATROOM_NO NUMBER NOT NULL,
    MEMBER_NO NUMBER NOT NULL,
    MESSAGE_TEXT CLOB,
    MESSAGE_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_MESSAGES_NO PRIMARY KEY(MESSAGE_NO),
    CONSTRAINT FK_MESSAGES_CHATNO FOREIGN KEY(CHATROOM_NO) REFERENCES TB_CHATROOM(CHATROOM_NO),
    CONSTRAINT FK_MESSAGES_MEMNO FOREIGN KEY(MEMBER_NO) REFERENCES TB_MEMBER(MEMBER_NO)
);

COMMENT ON COLUMN TB_MESSAGES.MESSAGE_NO IS '메세지 번호';
COMMENT ON COLUMN TB_MESSAGES.CHATROOM_NO IS '채팅방번호';
COMMENT ON COLUMN TB_MESSAGES.MEMBER_NO IS '생성자 번호';
COMMENT ON COLUMN TB_MESSAGES.MESSAGE_TEXT IS '메세지 내용';
COMMENT ON COLUMN TB_MESSAGES.MESSAGE_DATE IS '전송 날짜';

CREATE SEQUENCE SEQ_MEMBER_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;


CREATE SEQUENCE SEQ_SOCIAL_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_PAY_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_BLOCK_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_VISIT_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_RESUME_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_EXPERIENCE_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_EDUCATION_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_ACTIVITY_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_ITV_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_VOICE_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_TREND_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_SEARCHWORD_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_NOTICE_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_CHATBOT_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_COMMUNITY_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_B_REPORT_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_COM_NO
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_CHAT_ROOMS_NO
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_MESSAGES_NO
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE RESUME_NO_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 트리거 (각각 실행 필요)

CREATE OR REPLACE TRIGGER TRG_RESUME_NO
BEFORE INSERT ON TB_RESUME
FOR EACH ROW
WHEN (NEW.RESUME_NO IS NULL)
BEGIN
  SELECT RESUME_NO_SEQ.NEXTVAL INTO :NEW.RESUME_NO FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER TRG_BEFORE_INSERT_RESUME
BEFORE INSERT ON TB_RESUME
FOR EACH ROW
BEGIN
  IF :NEW.RESUME_NO IS NULL THEN
    SELECT RESUME_NO_SEQ.NEXTVAL INTO :NEW.RESUME_NO FROM dual;
  END IF;
END;
/

-- 채팅방 테이블 트리거
CREATE OR REPLACE TRIGGER trg_chat_rooms_before_insert
BEFORE INSERT ON TB_CHATROOM
FOR EACH ROW
BEGIN
    :NEW.CHATROOM_NO := chat_rooms_seq.NEXTVAL;
END;
/
-- 메세지 테이블 트리거
CREATE OR REPLACE TRIGGER trg_messages_before_insert
BEFORE INSERT ON tb_messages
FOR EACH ROW
BEGIN
    :NEW.message_no := messages_seq.NEXTVAL;
END;
/

COMMIT;


