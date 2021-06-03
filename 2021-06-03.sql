-- <06/03>

-- 1. 하나 계좌 테이블에 은행 컬럼 추가

SELECT * FROM HANA_ACCOUNT;
ALTER TABLE HANA_ACCOUNT ADD BANK_CODE NUMBER(3);
ALTER TABLE HANA_ACCOUNT DROP COLUMN NAME;



UPDATE HANA_ACCOUNT SET BANK_CODE = '0';

ALTER TABLE HANA_ACCOUNT MODIFY BANK_CODE NOT NULL;


-- 2. 계좌 개설할 때 은행도 선택해서 입력하도록 쿼리문 수정

SELECT CODE FROM BANK WHERE NAME = '하나';


-- 3. 
SELECT * FROM OPENING_HISTORY;
/*
931202-2222222	111-000000004-003
999999-1111111	111-000000021-001
991212-1222222	111-000000041-003
*/
SELECT * FROM HANA_MEMBER;
SELECT * FROM HANA_ACCOUNT;




SELECT * FROM BANK B, HANA_ACCOUNT A
WHERE B.CODE = A.BANK_CODE
AND B.NAME = '하나'
AND A.MEMBER_ID = 'test3';

-- 거래 내역 테이블

SELECT * FROM HANA_ACCOUNT;


-- 은행별로 계좌 시퀀스를 따로 만들어줘야 계좌번호를 생성해줄때 겹칠 수도 있음

SELECT * FROM HANA_ACCOUNT;
SELECT * FROM OPENING_HISTORY;
SELECT * FROM HANA_MEMBER;
/*
111-000000063-002	test2	1111	1000	여행적금	Y	100000	21/06/03	2	4
111-000000004-003	haeni	1234	1000	급여용통장	Y	100000	21/06/02	3	0
111-000000021-001	test	1234	1000	테스트수정	Y	100000	21/06/02	1	0
111-000000041-003	test3	1111	1000	공과금	Y	100000	21/06/02	3	0
*/

UPDATE OPENING_HISTORY SET BANK_CODE = 4 WHERE ACCOUNT_NUMBER = '111-000000063-002';
COMMIT;


-- 이체
/*
A -> B
OPENING_HISTORY에서 상대방 조회 => 존재 안하면 에러
하나 계좌 테이블에서 내 금액 수정 => 내 잔액보다 보낼 금액이 많으면 에러
하나 계좌 테이블에서 상대방 금액 수정 
*/

-- 상대 계좌 존재하는지 검색
SELECT COUNT(*)
FROM HANA_ACCOUNT A, BANK B
WHERE B.CODE = A.BANK_CODE
AND (B.NAME = '신한' AND ACCOUNT_NUMBER = '111-000000063-002')
AND (B.NAME != '하나' AND ACCOUNT_NUMBER != '111-000000004-003'); -- 내 계좌는 제외

-- 에러
SELECT COUNT(*)
FROM HANA_ACCOUNT A, BANK B
WHERE B.CODE = A.BANK_CODE
AND (B.NAME = '하나' AND ACCOUNT_NUMBER = '111-000000041-003')
AND NOT(B.NAME = '하나' AND ACCOUNT_NUMBER = '111-000000004-003');


SELECT COUNT(*)
FROM HANA_ACCOUNT A, BANK B
WHERE B.CODE = A.BANK_CODE
AND (B.NAME = '하나' AND ACCOUNT_NUMBER = '111-000000041-003')
AND (B.NAME != '하나' AND ACCOUNT_NUMBER != '111-000000004-003');


SELECT COUNT(*)
FROM HANA_ACCOUNT A, BANK B
WHERE B.CODE = A.BANK_CODE
AND (B.NAME = '신한' AND ACCOUNT_NUMBER = '111-000000063-002')
AND (B.NAME != '하나' AND ACCOUNT_NUMBER != '111-000000004-003');



-- 계좌 + 멤버 전체
SELECT * FROM HANA_ACCOUNT A, HANA_MEMBER M, BANK B
WHERE A.MEMBER_ID = M.ID
AND A.BANK_CODE = B.CODE;

SELECT * FROM HANA_BANKING_LOG;

-- 잔액 확인
SELECT (A.BALANCE - 10000)
FROM HANA_ACCOUNT A, BANK B
WHERE B.CODE = A.BANK_CODE
AND (B.NAME = '신한' AND ACCOUNT_NUMBER = '111-000000063-002')
AND (B.NAME != '하나' AND ACCOUNT_NUMBER != '111-000000004-003');

-- 계좌 잔액 변경
UPDATE (
SELECT BALANCE FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나')
SET BALANCE = 500;

UPDATE HANA_ACCOUNT
SET BALANCE = (SELECT (BALANCE - 500) FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나')
WHERE BANK_CODE = (SELECT CODE  FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나')
AND ACCOUNT_NUMBER = '111-000000004-003';


SELECT CODE  FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나';

SELECT A.ACCOUNT_NUMBER  FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나';


SELECT (BALANCE - 500) FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나';


ROLLBACK;

SELECT * FROM HANA_ACCOUNT;

-- 계좌 이체 기록
SELECT * FROM HANA_BANKING_LOG;
DESC HANA_BANKING_LOG;
/*
SEQ            NOT NULL NUMBER(30)   
LOG_DATE                DATE         
OWNER_CODE     NOT NULL NUMBER(3)    
OWNER_ACCOUNT  NOT NULL VARCHAR2(30) 
TARGET_CODE    NOT NULL NUMBER(3)    
TARGET_ACCOUNT NOT NULL VARCHAR2(30) 
AMOUNT         NOT NULL NUMBER(38)   
TYPE_CODE      NOT NULL NUMBER(3)  
*/


DELETE FROM HANA_BANKING_LOG;
COMMIT;

SELECT * FROM HANA_ACCOUNT;


INSERT INTO HANA_BANKING_LOG(
SEQ, OWNER_CODE, OWNER_ACCOUNT, TARGET_CODE, TARGET_ACCOUNT, AMOUNT, TYPE_CODE) 
VALUES( 
    SELECT H_BANKING_LOG_SEQ.NEXTVAL, 500,
    (SELECT CODE FROM BANK WHERE NAME = '하나'), '111-000000004-003' , 
    (SELECT CODE FROM BANK WHERE NAME = '하나'), '111-000000041-003' , 
    CODE FROM BANKING_TYPE T
    WHERE NAME = '계좌이체'
);


INSERT INTO HANA_BANKING_LOG(
SEQ, OWNER_CODE, OWNER_ACCOUNT, TARGET_CODE, TARGET_ACCOUNT, AMOUNT, TYPE_CODE) 
VALUES(
    H_BANKING_LOG_SEQ.NEXTVAL,
    (SELECT CODE FROM BANK WHERE NAME = '하나'), '111-000000004-003' , 
    (SELECT CODE FROM BANK WHERE NAME = '하나'), '111-000000041-003' ,  500,
    (SELECT CODE FROM BANKING_TYPE WHERE NAME = '계좌이체')
    );

SELECT * FROM HANA_BANKING_LOG;



INSERT INTO BANKING_TYPE VALUES(BANKING_TYPE_SEQ.NEXTVAL, '입금');
INSERT INTO BANKING_TYPE VALUES(BANKING_TYPE_SEQ.NEXTVAL, '출금');
INSERT INTO BANKING_TYPE VALUES(BANKING_TYPE_SEQ.NEXTVAL, '계좌이체');


-- 내 계좌 잔액 업데이트

-- 은행 코드 구하기
SELECT CODE  FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나';

-- 기존 잔액 구하기
SELECT BALANCE  FROM HANA_ACCOUNT
WHERE BANK_CODE = 9 AND ACCOUNT_NUMBER = '111-000000004-003' ;

SELECT A.BALANCE  FROM HANA_ACCOUNT A, BANK B
WHERE A.BANK_CODE = B.CODE AND A.ACCOUNT_NUMBER = '111-000000004-003' AND B.NAME = '하나';

-- 
UPDATE HANA_ACCOUNT 
SET BABALANCE = (OLD - AMOUNT)
WHERE ACCOUNT_NUMBER = '' AND BANK_CODE = 0;


SELECT * FROM HANA_BANKING_LOG;
SELECT * FROM BANKING_TYPE;

UPDATE BANKING_TYPE SET NAME = '계좌이체(입금)' WHERE CODE = '3';
SELECT * FROM BANKING_TYPE;

INSERT INTO BANKING_TYPE VALUES(BANKING_TYPE_SEQ.NEXTVAL, '계좌이체(출금)');

COMMIT;



-- 계좌 이체 상대방 잔액 변경

UPDATE HANA_ACCOUNT
SET BALANCE = (1000 + 500) 
WHERE ACCOUNT_NUMBER = '111-000000063-002' AND BANK_CODE = 4;



-- 전체 계좌 중에서 오픈뱅킹 등록한 계좌 목록

SELECT ACCOUNT_NUMBER, MEMBER_ID, M.NAME ,ACCOUNT_PW,BALANCE,ALIAS,
OFTEN_USED,LIMIT_AMOUNT,OPENING_DATE, A.TYPE, P.NAME, BANK_CODE, B.NAME 
FROM HANA_ACCOUNT A, BANK B, HANA_PRODUCT P, HANA_MEMBER M
WHERE A.BANK_CODE = B.CODE AND A.TYPE = P.CODE AND A.MEMBER_ID = M.ID
AND MEMBER_ID = 'haeni' AND OFTEN_USED = 'Y';


SELECT ACCOUNT_NUMBER, MEMBER_ID, M.NAME ,ACCOUNT_PW,BALANCE,ALIAS,
OFTEN_USED,LIMIT_AMOUNT,OPENING_DATE, A.TYPE, P.NAME, BANK_CODE, B.NAME 
FROM HANA_ACCOUNT A, BANK B, HANA_PRODUCT P, HANA_MEMBER M
WHERE A.BANK_CODE = B.CODE AND A.TYPE = P.CODE AND A.MEMBER_ID = M.ID
AND MEMBER_ID = 'haeni' AND OFTEN_USED = 'Y'
AND B.NAME = '하나';



SELECT ACCOUNT_NUMBER, MEMBER_ID, M.NAME ,ACCOUNT_PW,BALANCE,ALIAS,
OFTEN_USED,LIMIT_AMOUNT,OPENING_DATE, A.TYPE, P.NAME, BANK_CODE, B.NAME 
FROM HANA_ACCOUNT A, BANK B, HANA_PRODUCT P, HANA_MEMBER M
WHERE A.BANK_CODE = B.CODE AND A.TYPE = P.CODE AND A.MEMBER_ID = M.ID
AND MEMBER_ID = 'haeni' AND OFTEN_USED = 'Y'
AND A.ACCOUNT_NUMBER = '111-000000004-003';





SELECT * FROM HANA_ACCOUNT;

/*
1	931202-2222222	111-000000004-003	0	21/06/02	이해니
21	999999-1111111	111-000000021-001	0	21/06/02	test
41	991212-1222222	111-000000041-003	0	21/06/02	test
61	999999-2222222	111-000000063-002	4	21/06/03	test2
*/
SELECT * FROM OPENING_HISTORY;


SELECT * FROM HANA_PRODUCT;
DESC HANA_ACCOUNT;



SELECT ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW,BALANCE,ALIAS, 
OFTEN_USED,LIMIT_AMOUNT,OPENING_DATE, A.TYPE, P.NAME, BANK_CODE, B.NAME, M.NAME 
FROM HANA_ACCOUNT A, BANK B, HANA_PRODUCT P, HANA_MEMBER M 
WHERE A.BANK_CODE = B.CODE AND A.TYPE = P.CODE AND A.MEMBER_ID = M.ID 
AND MEMBER_ID = 'haeni' AND OFTEN_USED = 'Y' AND B.NAME = '하나';


SELECT ACCOUNT_NUMBER, MEMBER_ID, ACCOUNT_PW,BALANCE,ALIAS, 
OFTEN_USED,LIMIT_AMOUNT,OPENING_DATE, A.TYPE, P.NAME, BANK_CODE, B.NAME, M.NAME 
FROM HANA_ACCOUNT A, BANK B, HANA_PRODUCT P, HANA_MEMBER M 
WHERE A.BANK_CODE = B.CODE AND A.TYPE = P.CODE AND A.MEMBER_ID = M.ID 
AND MEMBER_ID = 'haeni' AND OFTEN_USED = 'N';





SELECT COUNT(*) 
FROM HANA_ACCOUNT A, BANK B 
WHERE B.CODE = A.BANK_CODE 
AND (B.NAME = '하나' AND ACCOUNT_NUMBER = '111-000000004-003'); 



UPDATE HANA_ACCOUNT SET OFTEN_USED = 'Y' 
WHERE BANK_CODE = (SELECT CODE FROM BANK WHERE NAME = '하나') 
AND ACCOUNT_NUMBER = '' 
AND MEMBER_ID = '';


SELECT LOG_DATE, AMOUNT, B.NAME, T.NAME
FROM HANA_BANKING_LOG L, BANKING_TYPE T, BANK B
WHERE L.TYPE_CODE = T.CODE AND L.OWNER_CODE = B.CODE
AND L.OWNER_ACCOUNT = '111-000000004-003'
AND B.NAME = '하나' ORDER BY L.LOG_DATE DESC;


SELECT * FROM HANA_BANKING_LOG; -- 잔액 필요함
