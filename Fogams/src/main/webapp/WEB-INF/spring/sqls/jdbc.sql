DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE REVIEW_NO;
DROP SEQUENCE COMMENT_SEQ;
DROP SEQUENCE PAY_SEQ;
DROP SEQUENCE CHATLIST_SEQ;
DROP SEQUENCE PLANLIST_SEQ;
DROP SEQUENCE COMPANY_SEQ;
DROP SEQUENCE BOOKMARK_SEQ;

DROP TABLE MEMBER;
DROP TABLE REVIEW;
DROP TABLE COMMENT;
DROP TABLE PAY;
DROP TABLE CHAT;
DROP TABLE CHATLIST;
DROP TABLE PLANLIST;
DROP TABLE PLAN;
DROP TABLE COMPANY;
DROP TABLE COMPANY_PRICE;
DROP TABLE COMPANY_INFO;
DROP TABLE BOOKMARK;


CREATE SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE REVIEW_NO;
CREATE SEQUENCE COMMENT_SEQ;
CREATE SEQUENCE PAY_SEQ;
CREATE SEQUENCE CHATLIST_SEQ;
CREATE SEQUENCE PLANLIST_SEQ;
CREATE SEQUENCE COMPANY_SEQ;
CREATE SEQUENCE BOOKMARK_SEQ;

CREATE TABLE MEMBER(
	MEMBER_NO NUMBER PRIMARY KEY NOT NULL,
	MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
	MEMBER_PW VARCHAR2(20) NOT NULL,
	MEMBER_NAME VARCHAR2(20) NOT NULL,
	MEMBER_EMAIL VARCHAR2(40) NOT NULL,
	MEMBER_GRADE NUMBER
);

CREATE TABLE COMPANY(
	COMPANY_NO NUMBER PRIMARY KEY,
	COMPANY_NAME VARCHAR2(100) NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	COMPANY_SORT VARCHAR2(20),
	CONSTRAINT FK_COMPANY_MEMBER FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO)
);

CREATE TABLE REVIEW(
	REVIEW_NO NUMBER PRIMARY KEY,
	REVIEW_TITLE VARCHAR2(20) NOT NULL,
	REVIEW_CONTENT VARCHAR2(1000) NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	REVIEW_DATE DATE NOT NULL,
	PLAN_NO NUMBER NOT NULL,
	CONSTRAINT FK_REVIEW_MEMBER FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO)
);

CREATE TABLE COMMENT(
	COMMENT_NO NUMBER PRIMARY KEY,
	COMMENT_CONTENT VARCHAR2(200) NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	REVIEW_NO NUMBER NOT NULL,
	COMMENT_DATE DATE NOT NULL,
	CONSTRAINT FK_COMMENT_MEMBER FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
	CONSTRAINT FK_COMMENT_REVIEW FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW (REVIEW_NO)
);

CREATE TABLE PAY(
	PAY_NO NUMBER PRIMARY KEY,
	MEMBER_NO NUMBER NOT NULL,
	PAY_CONTENT VARCHAR2(200) NOT NULL,
	PAY_DATE DATE NOT NULL,
	COMPANY_NO NUMBER NOT NULL,
	CONSTRAINT FK_PAY_MEMBER FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
	CONSTRAINT FK_PAY_COMPANY FOREIGN KEY(COMPANY_NO) REFERENCES COMPANY (COMPANY_NO)
);

CREATE TABLE CHATLIST(
	CHAT_NO NUMBER PRIMARY KEY,
	COMPANY_NO NUMBER NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	CONSTRAINT FK_CHATLIST_MEMBER FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
	CONSTRAINT FK_CHATLIST_COMPANY FOREIGN KEY(COMPANY_NO) REFERENCES COMPANY (COMPANY_NO)
);
CREATE TABLE CHAT(
	CHAT_NO NUMBER NOT NULL,
	CHAT_CONTENT VARCHAR2(100) NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	CHAT_DATE DATE NOT NULL,
	CONSTRAINT FK_CHAT_CHATLIST FOREIGN KEY(CHAT_NO) REFERENCES CHATLIST (CHAT_NO)
);



CREATE TABLE PLANLIST(
	PLAN_NO NUMBER PRIMARY KEY,
	MEMBER_NO NUMBER NOT NULL,
	PLAN_DATE DATE NOT NULL,
	CONSTRAINT FK_PLANLIST_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO)
);

CREATE TABLE PLAN(
	PLAN_NO NUMBER NOT NULL,
	COMPANY_NO NUMBER NOT NULL,
	PLAN_TIME DATE NOT NULL,
	PLAN_PRICE VARCHAR2(200) NOT NULL,
	CONSTRAINT FK_PLAN_PLANLIST FOREIGN KEY(PLAN_NO) REFERENCES PLANLIST (PLAN_NO)
);



CREATE TABLE COMPANY_PRICE(
	COMPANY_NO NUMBER NOT NULL,
	COMPANY_PRODUCT VARCHAR2(20) NOT NULL,
	COMPANY_MONEY VARCHAR2(20)  NOT NULL,
	CONSTRAINT FK_COMPANY_PRICE_COMPANY FOREIGN KEY(COMPANY_NO) REFERENCES COMPANY (COMPANY_NO)
);


-- 업체정보 테이블
CREATE TABLE COMPANY_INFO(
	COMPANY_NO NUMBER NOT NULL,
	COMPANY_CONTENT VARCHAR2(2000) NOT NULL,
	COMPANY_TEL VARCHAR2(30) NOT NULL,
	COMPANY_NUMBER VARCHAR2(30) NOT NULL,
	COMPANY_ADDR1 VARCHAR2(200) NOT NULL,
	COMPANY_ADDR2 VARCHAR2(200) NOT NULL,
	COMPANY_IMG VARCHAR2(200),
	CONSTRAINT FK_COMPANY_INFO_COMPANY FOREIGN KEY(COMPANY_NO) REFERENCES COMPANY (COMPANY_NO)
);

CREATE TABLE BOOKMARK(
	BOOKMARK_NO NUMBER PRIMARY KEY,
	COMPANY_NO NUMBER NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	CONSTRAINT FK_BOOKMARK_MEMBER FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
	CONSTRAINT FK_BOOKMARK_COMPANY FOREIGN KEY(COMPANY_NO) REFERENCES COMPANY (COMPANY_NO)
);