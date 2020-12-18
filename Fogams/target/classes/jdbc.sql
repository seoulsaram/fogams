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

drop table company

select company_img from company_info;
select * from member;
select * from company
select * from BOOKMARK;
ALTER TABLE company ADD COMPANY_CONTENT VARCHAR2(2000) DEFAULT '애름다운곳' not null;
ALTER TABLE company ADD COMPANY_TEL VARCHAR2(30) DEFAULT '020989-3339' not null;
ALTER TABLE company ADD COMPANY_NUMBER VARCHAR2(30) DEFAULT '00099888' not null;
ALTER TABLE company ADD COMPANY_IMG VARCHAR2(200) DEFAULT '스크린샷 2020-12-16 오전 1.19.47.png' not null;
ALTER TABLE company ADD COMPANY_ADDR VARCHAR2(200) DEFAULT '경기도 어쩌구저쩌' not null;
ALTER TABLE company ADD company_city VARCHAR2(50) DEFAULT '경기도' not null;
ALTER TABLE company DROP COLUMN company_city;


업체등록 시, 멤버테이블 멤버등급을 1 -> 2 바꾸기
insert, update 따로. -> 하나의 컨트롤러에서.
컨트롤러에서 유효성 검사 후.
update member set member_grade = 2
where member_grade = 1
and member_no = #{};



일반멤버(1)
사업자등록하면(2)
관리자(3)
탈퇴(0)

		UPDATE MEMBER SET MEMBER_GRADE = 1 
		WHERE MEMBER_GRADE = 1
		AND MEMBER_NO = 1


CREATE TABLE MEMBER(
	MEMBER_NO NUMBER PRIMARY KEY NOT NULL,
	MEMBER_ID VARCHAR2(20) UNIQUE NOT NULL,
	MEMBER_PW VARCHAR2(64) NOT NULL,
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