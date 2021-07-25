select account_num, target_name, trans_date, trans_amount, balance
from HN_TRANSACTION a, HN_ACCOUNT b
where a.account_num = b.ACCOUNT
and b.account = '333333-333333'
order by a.trans_no desc;

select *
from HN_TRANSACTION a, HN_ACCOUNT b
where a.account_num = b.ACCOUNT
and b.account = '333333-333333'
order by a.trans_no desc;



-- 거래 내역
create table hn_transaction(
    trans_no number(38), -- 거래 고유 번호
    my_account varchar(50) not null,
    my_balance number(38) not null, -- 변경되는 내 잔액
    target_account varchar(50) not null, 
    target_bank char(4) not null,
    target_name varchar(50) not null,
    trans_date date default sysdate,
    trans_amount number(38) not null,
    trans_type varchar(50) not null, -- 입금, 출금, 타행이체
    CONSTRAINT hn_transaction_no_pk PRIMARY key(trans_no)
);

-- 거래 고유 번호 시퀀스 생성
create SEQUENCE seq_hn_transaction nocache;

/*

계좌 이체 : 

<transfer.jsp>
1. 내 계좌 선택 


(내 계좌 기억) => 폼태그로 히든 전송 => 세션에 저장해두기
- 문제 : 체크한 값을 자바스크립트에서 아는데 어캐 전송하지....?


2. 상대방 계좌/은행 입력 => 존재하는지 확인(ajax로 결과 받아와야함)

(상대방 계좌 / 은행 기억) => 폼태그로 히든 전송 => 세션에 저장해두기



3. 이체할 금액 입력 => 내 잔액보다 많지 않은지 확인(ajax로 결과 받아와야 함)

(이체할 금액 기억) => 



4. 
1) 내 통장에서 출금 => 내 계좌테이블 잔액 변경
2) 내 거래내역에 기록 => 내 거래테이블에 기록 : 보낸날짜, 받을 계좌주, 보낸 금액, 내 계좌번호 
3) 상대방 통장에 입금 => 상대방 계좌테이블 잔액 변경
4) 상대방 거래내역에 기록 => 
*/

-- 알고 있는 정보 : 내 계좌, 상대 계좌, 상대 은행, 보낼 금액
select * from hn_account;
select * from hn_transaction;


-- 1) 보낼 수 있는 잔고 있는지 확인 (0이면 실패)
select count(*)
from hn_account a --, hn_member 
where --a.member_id = b.id and 
a.account =  '99999-999999' --'88888-88888'
and (a.balance - 1000) > 0;

-- 2) 잔고 있으면, 잔액 update
update hn_account set balance = balance - 1000 where account = '99999-999999';


-- 3) 내 거래 내역에 기록 : 보내는 계좌, 받는 계좌, 송금액, 거래일, 메모, 입출금타입(내기준), 변경된 잔액 
insert into hn_transaction(
    TRANS_NO, MY_ACCOUNT, TARGET_ACCOUNT, MY_BALANCE, TARGET_BANK, TARGET_NAME, TRANS_AMOUNT, TRANS_TYPE, TRANS_MEMO) 
values(
    seq_hn_transaction.nextval -- 거래 식별 코드
    , '99999-999999' -- 내계좌
    , '111111-111111' -- 상대계좌
    , (select (balance - 1000) from hn_account where account = '99999-999999') -- 내 변경된 잔액
    , '3000' -- 상대 은행
    , (select name from hn_account a, hn_member b where a.member_id = b.id and a.account = '111111-111111') -- 상대 이름
    ,-1000 -- 거래 금액
    , '출금' -- 거래 유형
    , '당행이체' -- 거래 메모
); 


-- 4) 상대방 통장에 입금(잔액 update)
update hn_account set balance = balance + 1000 where account = '111111-111111';

-- 5) 상대방 거래내역에 기록  
insert into hn_transaction(
    TRANS_NO, MY_ACCOUNT, TARGET_ACCOUNT, MY_BALANCE, TARGET_BANK, TARGET_NAME, TRANS_AMOUNT, TRANS_TYPE, TRANS_MEMO) 
values(
    seq_hn_transaction.nextval -- 거래 식별 코드
    , '111111-111111' -- 내계좌
    , '99999-999999' -- 상대계좌
    , (select balance + 1000 from hn_account where account = '111111-111111') -- 내 변경된 잔액
    , '3000' -- 상대 은행
    , (select name from hn_account a, hn_member b where a.member_id = b.id and a.account = '99999-999999') -- 상대 이름
    , 1000 -- 거래 금액
    , '입금' -- 거래 유형
    , '당행이체' -- 거래 메모
); 
commit;
ROLLBACK;





-- 계좌이체 프로시저 
DROP PROCEDURE TRANSFER;

CREATE OR REPLACE PROCEDURE transfer (
     V_TOACCNUM IN VARCHAR2 -- 상대 계좌번호
    ,V_TRMONEY IN NUMBER -- 상대 이체금액 (마이너스 포함))
    ,V_TOACCBANKCODE IN VARCHAR2 -- 상대 은행코드
    ,V_TONAME IN VARCHAR2 -- 상대 이름
    ,V_MYACCNUM IN VARCHAR2 -- 내 계좌번호
)IS
    --V_MY_NAME               hn_member.name%TYPE;
    V_MY_BALANCE            hn_account.balance%TYPE;
    --V_TARGET_NAME         hn_member.name%TYPE;
    V_TRTYPE                HN_TRANSACTION.TRANS_TYPE%TYPE; -- 입금 or 출금
BEGIN
    BEGIN 
        -- 1. 내 계좌 이름 매핑
        --SELECT NAME INTO V_MY_NAME from hn_account a, hn_member b where a.member_id = b.id and a.account = V_MYACCNUM;
        --DBMS_OUTPUT.PUT_LINE('V_MY_NAME => ' || V_MY_NAME);    
        
        -- 2. 입금인지 출금인지 판단
        IF V_TRMONEY < 0 THEN 
            V_TRTYPE := '출금';
        ELSIF V_TRMONEY > 0 THEN 
            V_TRTYPE := '입금';
        END IF;
    
        -- 3. 잔액 UPDATE
        update hn_account set balance = balance + V_TRMONEY where account = V_MYACCNUM;
        
        -- 4. 내 잔액 변수에 저장
        select balance INTO V_MY_BALANCE from hn_account where account = V_MYACCNUM;
        
        -- 5. 거래 내역 INSERT
        insert into hn_transaction(
            TRANS_NO, MY_ACCOUNT, TARGET_ACCOUNT, MY_BALANCE, TARGET_BANK, TARGET_NAME, TRANS_AMOUNT, TRANS_TYPE) 
        values(
            seq_hn_transaction.nextval -- 거래 식별 코드
            , V_MYACCNUM -- 내계좌
            , V_TOACCNUM -- 상대계좌
            , V_MY_BALANCE -- 내 변경된 잔액
            , V_TOACCBANKCODE -- 상대 은행
            , V_TONAME -- 상대 이름
            , V_TRMONEY -- 거래 금액
            , V_TRTYPE -- 거래 유형
        ); 
   END;
    EXCEPTION
        WHEN OTHERS THEN
    rollback;
END;
/



 -- 상대 계좌번호 : '111111-111111' 이해니
 -- 이체금액 (마이너스 포함)) : 1000
 -- 상대 은행코드 : 3000
 -- 상대 이름 : 이해니
 -- 내 계좌번호 : '99999-999999' 리해리

-- 받는 사람
select * from hn_account where ACCOUNT = '111111-111111'; -- 298000 -> 299000

-- 보내는 사람
select * from hn_account where ACCOUNT = '99999-999999'; -- 502000 -> 501000

select * from hn_transaction order by trans_no desc;



exec transfer('111111-111111', -1000, 3000, '이해니','99999-999999');  -- 상대 계좌 , 출금금액, 상대 은행코드 상대 이름, 내 계좌
exec transfer('99999-999999', 1000, 3000, '리해리','111111-111111');


-- 거래 내역 조회
select MY_BALANCE, TARGET_NAME, TRANS_DATE, TRANS_AMOUNT, TRANS_TYPE 
from HN_TRANSACTION where MY_ACCOUNT = '111111-111111' order by trans_no desc;




-- 통합 프로시저
DROP PROCEDURE executePro;

CREATE OR REPLACE PROCEDURE executePro(
     V_TOACCNUM IN VARCHAR2 -- 상대 계좌번호
    ,V_TRMONEY IN NUMBER -- 이체 금액
    ,V_TOACCBANKCODE IN VARCHAR2 -- 상대 은행코드
    ,V_TONAME IN VARCHAR2 -- 상대 이름
    ,V_MYACCNUM IN VARCHAR2 -- 내 계좌번호
    ,V_RESULT OUT NUMBER -- 결과 (0이면 성공!)
)IS
   V_MY_NAME               hn_member.name%TYPE;              -- 내 이름
   V_MY_BANK_CODE          hn_account.BANK_CODE%TYPE := 3000; -- 내은행 코드
BEGIN
BEGIN
    -- 0. 결과 0으로 초기화하기
     V_RESULT := 0;

    -- 1. 내 이름 변수에 매핑하기 
    SELECT NAME INTO V_MY_NAME from hn_account a, hn_member b where a.member_id = b.id and a.account = V_MYACCNUM;
    
    -- 2. 내 계좌에서 출금시키기 + 내 거래내역 업데이트
   BEGIN
          -- 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌
        transfer(V_TOACCNUM, -1 * V_TRMONEY, V_TOACCBANKCODE, V_TONAME,V_MYACCNUM);
   EXCEPTION
    WHEN OTHERS THEN
     V_RESULT:=1;
    ROLLBACK;
    END;
    -- 3. 상대 계좌에 입금시키기 + 상대 거래내역 업데이트 
    BEGIN
        -- 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌
        CASE 
        WHEN V_TOACCBANKCODE = '1000' THEN
             transfer@BANKER_BANK(V_MYACCNUM, V_TRMONEY, V_MY_BANK_CODE, V_MY_NAME, V_TOACCNUM); 
        WHEN V_TOACCBANKCODE = '2000' THEN
             transfer@CM_BANK(V_MYACCNUM, V_TRMONEY, V_MY_BANK_CODE, V_MY_NAME, V_TOACCNUM); 
        WHEN V_TOACCBANKCODE = '4000' THEN
             transfer@YB_BANK(V_MYACCNUM, V_TRMONEY, V_MY_BANK_CODE, V_MY_NAME, V_TOACCNUM); 
        ELSE
            transfer(V_MYACCNUM, V_TRMONEY, V_MY_BANK_CODE, V_MY_NAME, V_TOACCNUM); 
        END CASE;
        
   EXCEPTION
    WHEN OTHERS THEN
    V_RESULT :=2;
    ROLLBACK;
    END;
   COMMIT;
END;
EXCEPTION
    WHEN OTHERS THEN
    V_RESULT := 3;
    ROLLBACK;
END;
/





select * from hn_bank_code;

/* 시나리오 */

 -- 상대 계좌번호 : '111111-111111' 이해니
 -- 이체금액 (마이너스 포함)) : 1000
 -- 상대 은행코드 : 3000
 -- 상대 이름 : 이해니
 -- 내 계좌번호 : '99999-999999' 리해리

-- 받는 사람(상대)
select * from hn_account where ACCOUNT = '111111-111111'; -- 299000 -> 300000

-- 보내는 사람(나)
select * from hn_account where ACCOUNT = '99999-999999'; -- 501000 -> 500000

select * from hn_transaction order by trans_no desc;



--exec transfer('111111-111111', -1000, 3000, '이해니','99999-999999');  -- 상대 계좌 , 출금금액, 상대 은행코드 상대 이름, 내 계좌
--exec transfer('99999-999999', 1000, 3000, '리해리','111111-111111');


-- 오류 메시지 찍기
SET SERVEROUTPUT ON
DECLARE
    OUTDATA VARCHAR2(20);
BEGIN
    -- 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌
    executePro('111111-111111', 1000, 3000, '이해니','99999-999999',OUTDATA);
    DBMS_OUTPUT.PUT_LINE(OUTDATA);
END;




select * from hn_transaction;

/* 시나리오 */


 -- 상대 계좌번호 : '101021453103' 김충만 2000 => 20만 5천원
 -- 이체금액 (마이너스 포함)) : 1000
 -- 상대 은행코드 : 2000
 -- 상대 이름 : 김충만
 -- 내 계좌번호 : '99999-999999' 리해리 => 50만원

-- 받는 사람(상대)
select * from hn_account where ACCOUNT = '111111-111111'; -- 299000 -> 300000

-- 보내는 사람(나)
select * from hn_account where ACCOUNT = '99999-999999'; -- 501000 -> 500000

select * from hn_transaction order by trans_no desc;



--exec transfer('111111-111111', -1000, 3000, '이해니','99999-999999');  -- 상대 계좌 , 출금금액, 상대 은행코드 상대 이름, 내 계좌
--exec transfer('99999-999999', 1000, 3000, '리해리','111111-111111');


-- 오류 메시지 찍기
SET SERVEROUTPUT ON
DECLARE
    OUTDATA VARCHAR2(20);
BEGIN
    -- 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌
    executePro('101021453103', 1000, '2000', '김충만','99999-999999',OUTDATA);
    DBMS_OUTPUT.PUT_LINE(OUTDATA);
END;

