/*
CREATE TABLE TST_CUSTOMER2(
    ID VARCHAR2(8) NOT NULL,
    PWD VARCHAR2(8) CONSTRAINT TST_CUSTOMER2_PWD_NN NOT NULL,
    NAME VARCHAR2(20), 
    SEX CHAR(1) CONSTRAINT TST_CUSTOMER2_SEX_CK CHECK(SEX IN ('M', 'F')), 
    AGE NUMBER(3) CHECK (AGE > 0 AND AGE < 100)
);
*/

-- 한국 내 은행 코드
CREATE TABLE BANK (
    CODE NUMBER(3) CONSTRAINT BANK_CODE_PK PRIMARY KEY, -- 은행코드
    NAME VARCHAR2(30) NOT NULL CONSTRAINT BANK_NAME_UK UNIQUE -- 은행명
);

SELECT TO_CHAR(1, '000') FROM DUAL;


-- 계좌 은행 등록
INSERT INTO BANK VALUES(0, '하나');
INSERT INTO BANK VALUES(1, '국민');
INSERT INTO BANK VALUES(2, '기업');
INSERT INTO BANK VALUES(3, '우리');
INSERT INTO BANK VALUES(4, '신한');




-- 한국 국민 계좌 개설 내역
DROP TABLE OPENING_HISTORY;

CREATE TABLE OPENING_HISTORY (
    OPEN_HISTORY_SEQ NUMBER(3) CONSTRAINT OPEN_HISTORY_SEQ_PK PRIMARY KEY, 
    RESIDENT_NUMBER VARCHAR2(14) NOT NULL,-- 주민번호
    ACCOUNT_NUMBER VARCHAR2(30) NOT NULL, -- 계좌번호
    BANK_CODE NUMBER(3) NOT NULL,
    OPENING_DATE DATE NOT NULL,
    CONSTRAINT OPENING_BANK_FK FOREIGN KEY(BANK_CODE)
         REFERENCES BANK(CODE)
);
ALTER TABLE OPENING_HISTORY ADD NAME VARCHAR2(30) NOT NULL;

DESC OPENING_HISTORY;

-- 하나은행 멤버
CREATE TABLE HANA_MEMBER(
    ID VARCHAR2(14)CONSTRAINT HANA_MEM_ID_PK PRIMARY KEY,
    PW VARCHAR2(30) NOT NULL,
    RESIDENT_NUMBER VARCHAR2(14) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    AGE NUMBER(4) NOT NULL CONSTRAINT HANA_MEM_AGE_CK CHECK(AGE > 0 AND AGE < 1000),
    SEX CHAR(1) DEFAULT 'M' CONSTRAINT HANA_MEM_SEX_CK CHECK(SEX IN('M', 'F')),
    JOIN_DATE DATE DEFAULT SYSDATE
);

-- 하나은행 계좌 상품
CREATE TABLE HANA_PRODUCT (
    CODE NUMBER(3) CONSTRAINT HANA_PRODUCT_CODE_PK PRIMARY KEY, -- 상품코드
    NAME VARCHAR2(30) NOT NULL CONSTRAINT HANA_PRODUCT_NAME_UK UNIQUE -- 상품명
);



-- 하나은행 계좌
CREATE TABLE HANA_ACCOUNT(
    ACCOUNT_NUMBER VARCHAR2(30) CONSTRAINT HANA_ACNT_NUM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    ACCOUNT_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    BALANCE NUMBER(38) NOT NULL,
    ALIAS VARCHAR2(30),
    OFTEN_USED CHAR(1) DEFAULT 'N' CONSTRAINT HANA_ACNT_OFTEN_CK CHECK(OFTEN_USED IN('Y', 'N')),
    LIMIT_AMOUNT NUMBER(20) CONSTRAINT HANA_ACNT_LIMIT_CK CHECK (LIMIT_AMOUNT > 0),
    OPENING_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT HANA_ACNT_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES HANA_MEMBER(ID)
);

ALTER TABLE HANA_ACCOUNT ADD(TYPE NUMBER(3));
ALTER TABLE HANA_ACCOUNT ADD(NAME VARCHAR2(30));



-- ㄱㅜㅁㅣㄴ은행 계좌
CREATE TABLE KB_ACCOUNT(
    ACCOUNT_NUMBER VARCHAR2(30) CONSTRAINT KB_ACNT_NUM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    ACCOUNT_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    BALANCE NUMBER(38) NOT NULL,
    ALIAS VARCHAR2(30),
    OFTEN_USED CHAR(1) DEFAULT 'N' CONSTRAINT KB_ACNT_OFTEN_CK CHECK(OFTEN_USED IN('Y', 'N')),
    LIMIT_AMOUNT NUMBER(20) DEFAULT 100000 CONSTRAINT KB_ACNT_LIMIT_CK CHECK (LIMIT_AMOUNT > 0),
    OPENING_DATE DATE DEFAULT SYSDATE
    -- DEL FOREIGN
);

ALTER TABLE KB_ACCOUNT ADD(TYPE NUMBER(3));
ALTER TABLE KB_ACCOUNT ADD(NAME VARCHAR2(30));

-- shinhan은행 계좌
CREATE TABLE SHINHAN_ACCOUNT(
    ACCOUNT_NUMBER VARCHAR2(30) CONSTRAINT SHINHAN_ACNT_NUM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    ACCOUNT_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    BALANCE NUMBER(38) NOT NULL,
    ALIAS VARCHAR2(30),
    OFTEN_USED CHAR(1) DEFAULT 'N' CONSTRAINT SHINHAN_ACNT_OFTEN_CK CHECK(OFTEN_USED IN('Y', 'N')),
    LIMIT_AMOUNT NUMBER(20) DEFAULT 100000 CONSTRAINT SHINHAN_ACNT_LIMIT_CK CHECK (LIMIT_AMOUNT > 0),
    OPENING_DATE DATE DEFAULT SYSDATE
    -- DEL FOREIGN
);

ALTER TABLE SHINHAN_ACCOUNT ADD(TYPE NUMBER(3));
ALTER TABLE SHINHAN_ACCOUNT ADD(NAME VARCHAR2(30));

-- ibk은행 계좌
CREATE TABLE IBK_ACCOUNT(
    ACCOUNT_NUMBER VARCHAR2(30) CONSTRAINT IBK_ACNT_NUM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    ACCOUNT_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    BALANCE NUMBER(38) NOT NULL,
    ALIAS VARCHAR2(30),
    OFTEN_USED CHAR(1) DEFAULT 'N' CONSTRAINT IBK_ACNT_OFTEN_CK CHECK(OFTEN_USED IN('Y', 'N')),
    LIMIT_AMOUNT NUMBER(20) DEFAULT 100000 CONSTRAINT IBK_ACNT_LIMIT_CK CHECK (LIMIT_AMOUNT > 0),
    OPENING_DATE DATE DEFAULT SYSDATE
    -- DEL FOREIGN
);

ALTER TABLE IBK_ACCOUNT ADD(TYPE NUMBER(3));
ALTER TABLE IBK_ACCOUNT ADD(NAME VARCHAR2(30));

-- woori은행 계좌
CREATE TABLE WOORI_ACCOUNT(
    ACCOUNT_NUMBER VARCHAR2(30) CONSTRAINT WOORI_ACNT_NUM_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    ACCOUNT_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    BALANCE NUMBER(38) NOT NULL,
    ALIAS VARCHAR2(30),
    OFTEN_USED CHAR(1) DEFAULT 'N' CONSTRAINT WOORI_ACNT_OFTEN_CK CHECK(OFTEN_USED IN('Y', 'N')),
    LIMIT_AMOUNT NUMBER(20) DEFAULT 100000 CONSTRAINT WOORI_ACNT_LIMIT_CK CHECK (LIMIT_AMOUNT > 0),
    OPENING_DATE DATE DEFAULT SYSDATE
    -- DEL FOREIGN
);

ALTER TABLE WOORI_ACCOUNT ADD(TYPE NUMBER(3));
ALTER TABLE WOORI_ACCOUNT ADD(NAME VARCHAR2(30));

/*
KB_ACCOUNT
SHINHAN_ACCOUNT
IBK_ACCOUNT
WOORI_ACCOUNT
*/
INSERT INTO KB_ACCOUNT(ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW, BALANCE, ALIAS, OFTEN_USED, TYPE, NAME) VALUES('01-111-1111-1111', 'KB', 1234, 1000, 'mykb', 'Y' , 1 , '국민' );
INSERT INTO SHINHAN_ACCOUNT(ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW, BALANCE, ALIAS, OFTEN_USED, TYPE, NAME) VALUES('04-111-1111-1111', 'KB', 1234, 1000, 'mySH', 'Y' , 1 , '신한' );
INSERT INTO IBK_ACCOUNT(ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW, BALANCE, ALIAS, OFTEN_USED, TYPE, NAME) VALUES('02-111-1111-1111', 'KB', 1234, 1000, 'myIBK', 'Y' , 1 , '기업' );
INSERT INTO WOORI_ACCOUNT(ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW, BALANCE, ALIAS, OFTEN_USED, TYPE, NAME) VALUES('03-111-1111-1111', 'KB', 1234, 1000, 'myWOORI', 'Y' , 1 , '우리' );

INSERT INTO OPENING_HISTORY VALUES(OPEN_HISTORY_SEQ.NEXTVAL, '911111-1111111', '01-111-1111-1111', 1 , SYSDATE, '국민');
INSERT INTO OPENING_HISTORY VALUES(OPEN_HISTORY_SEQ.NEXTVAL, '941111-1111111', '04-111-1111-1111', 4 , SYSDATE, '신한');
INSERT INTO OPENING_HISTORY VALUES(OPEN_HISTORY_SEQ.NEXTVAL, '921111-1111111', '02-111-1111-1111', 2 , SYSDATE, '기업');
INSERT INTO OPENING_HISTORY VALUES(OPEN_HISTORY_SEQ.NEXTVAL, '931111-1111111', '03-111-1111-1111', 3 , SYSDATE, '우리');


DESC OPENING_HISTORY;

/*
이름               널?       유형           
---------------- -------- ------------ 
OPEN_HISTORY_SEQ NOT NULL NUMBER(3)    
RESIDENT_NUMBER  NOT NULL VARCHAR2(14) 
ACCOUNT_NUMBER   NOT NULL VARCHAR2(30) 
BANK_CODE        NOT NULL NUMBER(3)    
OPENING_DATE     NOT NULL DATE         
NAME             NOT NULL VARCHAR2(30) 
*/

DESC KB_ACCOUNT;
/*
ACCOUNT_NUMBER NOT NULL VARCHAR2(30) 
MEMBER_ID      NOT NULL VARCHAR2(14) 
ACCOUNT_PW     NOT NULL NUMBER(4)    
BALANCE        NOT NULL NUMBER(38)   
ALIAS                   VARCHAR2(30) 
OFTEN_USED              CHAR(1)      
LIMIT_AMOUNT            NUMBER(20)   
OPENING_DATE            DATE         
TYPE                    NUMBER(3)    
NAME                    VARCHAR2(30) 
*/
SELECT * FROM BANK;


/*
디폴트 제약조건 추가하려다 실패함
ALTER TABLE HANA_ACCOUNT
ADD LIMIT_AMOUNT NUMBER(20) DEFAULT 1000000;

select *
from user_constraints
where table_name = 'HANA_ACCOUNT';
*/
-- 오픈 뱅킹 신청
CREATE TABLE HANA_OPEN_BANKING_MEMBER(
    MEMBER_ID VARCHAR2(14) CONSTRAINT OPEN_MEM_ID_PK PRIMARY KEY,
    OPEN_PW NUMBER(4) NOT NULL, -- 음수 나오면 안됨, 무조건 4자리 숫자
    CONSTRAINT OPEN_MEM_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES HANA_MEMBER(ID)
);

DROP TABLE HANA_OPEN_BANKING_MEMBER;


-- 오픈 뱅킹 계좌 리스트
CREATE TABLE HANA_OPEN_BANKING_ACCOUNT (
    OPEN_ACNT_SEQ NUMBER(30) CONSTRAINT OPEN_ACNT_SEQ_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(14) NOT NULL,
    BANK_CODE NUMBER(3) NOT NULL, -- 뱅크코드는 무조건 3자리 숫자 000 부터 시작
    ACCOUNT_NUMBER VARCHAR2(30) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    CONSTRAINT OPEN_ACNT_BANK_FK FOREIGN KEY(BANK_CODE) REFERENCES BANK(CODE),
    CONSTRAINT OPEN_ACNT_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES HANA_OPEN_BANKING_MEMBER(MEMBER_ID)
);

DROP TABLE HANA_OPEN_BANKING_ACCOUNT;

-- 거래내역 로그 테이블 생성
CREATE TABLE HANA_BANKING_LOG(
    SEQ NUMBER(30) CONSTRAINT H_BANKING_LOG_SEQ_PK PRIMARY KEY,
    LOG_DATE DATE DEFAULT SYSDATE,
    OWNER_CODE NUMBER(3) NOT NULL,
    OWNER_ACCOUNT VARCHAR2(30) NOT NULL,
    TARGET_CODE NUMBER(3) NOT NULL,
    TARGET_ACCOUNT VARCHAR2(30) NOT NULL,
    AMOUNT NUMBER(38) NOT NULL,
    TYPE_CODE NUMBER(3) NOT NULL,
    CONSTRAINT H_BANKING_TYPE_FK FOREIGN KEY(TYPE_CODE) REFERENCES BANKING_TYPE(CODE)
);

-- 외래키 아직 안걸음...근데 너무 많은걸???? = > HANA ACCOUNT의 PK를 계좌 + 은행코드로 변경해야함

-- 거래 유형 테이블
CREATE TABLE BANKING_TYPE(
    CODE NUMBER(3) CONSTRAINT BANKING_TYPE_CODE_PK PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL
);





-- 다 하고 시퀀스 만들기
-- 오픈 히스토리 시퀀스 : 1부터 시작해서 1/2/3/
CREATE SEQUENCE OPENING_HISTORY_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999
    MINVALUE 1
    NOCYCLE;

ALTER SEQUENCE OPENING_HISTORY_SEQ NOCACHE;

-- 은행 코드 시퀀스 : 0부터 시작해서 000/001/002
CREATE SEQUENCE ACNT_CODE_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999
    MINVALUE 1
    NOCYCLE;

ALTER SEQUENCE ACNT_CODE_SEQ NOCACHE;

-- 계좌 가운데 번호 시퀀스 : 0부터 시작해서 000/001/002
CREATE SEQUENCE HANA_ACNT_CODE_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999999
    MINVALUE 0
    NOCYCLE;

DROP SEQUENCE HANA_ACNT_CODE_SEQ;
    
ALTER SEQUENCE HANA_ACNT_CODE_SEQ NOCACHE;

-- 오픈뱅킹 멤버 시퀀스 : 1부터 시작 1/2/3/4
CREATE SEQUENCE HANA_OPEN_B_MEM_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999999
    MINVALUE 1
    NOCYCLE;

ALTER SEQUENCE HANA_OPEN_B_MEM_SEQ NOCACHE;

DROP SEQUENCE HANA_OPEN_B_MEM_SEQ;
    
    
-- 오픈뱅킹 시퀀스 : 1부터 시작 1/2/3/4
CREATE SEQUENCE OPEN_B_ACNT_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999999
    MINVALUE 1
    NOCYCLE;
    
    ALTER SEQUENCE OPEN_B_ACNT_SEQ NOCACHE;

-- 거래유형 시퀀스 : 1부터 시작 1/2/3/4
CREATE SEQUENCE BANKING_TYPE_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999999
    MINVALUE 1
    NOCACHE
    NOCYCLE;

DROP SEQUENCE BANKING_TYPE_SEQ;

-- 거래 로그 시퀀스 : 1부터 시작 1/2/3/4
CREATE SEQUENCE H_BANKING_LOG_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999999999
    MINVALUE 1
    NOCACHE
    NOCYCLE;



