-- 전체 조회
select * from hn_account;
select * from hn_member;
select * from hn_acnt_type;
select * from HN_TRANSACTION;


--계좌 조회

-- (1) 전화번호로 전체 계좌 조회
/* HN은행 */
-- 하이픈 없는 버전
select a.account account, a.balance balance, a.alias alias, c.type type
from hn_account@HN_BANK a, hn_member@HN_BANK b, hn_acnt_type@HN_BANK c
where a.type_code = c.code
    and b.tel1 = '010'
    and b.tel2 = '4225'
    and b.tel3 = '3870'
    and a.member_id = b.id;

-- 하이픈 있는 버전
select a.account account, a.balance balance, a.alias alias, c.type type
from hn_account@HN_BANK a, hn_member@HN_BANK b, hn_acnt_type@HN_BANK c
where a.type_code = c.code
    and b.tel1||'-'||b.tel2||'-'||b.tel3 = '010-3880-3302'
    and a.member_id = b.id;
    
    
/* @YB_BANK */
select acc_num, acc_pwd, acc_alias, acc_bal, acc_type, enroll_dt, user_id 
from t_account@YB_BANK
where user_id = (
    select user_id 
    from t_member@YB_BANK 
    where user_phone = '010-2121-7514'
);

/* @BANKER_BANK */
select * 
from account@BANKER_BANK 
where tel='01021217514' and holder='이해니';


/* @CM_BANK */
select * 
from account@CM_BANK
where id = (select id from t_member@CM_BANK where tel1='010' and tel2='2121' and tel3='7514');


-- (2) 상대 계좌번호 존재하는지 확인하기

/* @HN_BANK*/
select a.account, b.name, c.type 
from hn_account@HN_BANK a, hn_member@HN_BANK b, hn_acnt_type@HN_BANK c 
where a.account= '222222-222222' 
and a.member_id = b.id 
and a.Type_code = c.code;


-- 전체 계좌 중에서 일치하는 정보 있는지 확인
SELECT * FROM (
    select a.acc_num ACCOUNT_NUM, '4000' as bank_code, a2.user_name name
    from t_account@YB_BANK a, t_member@YB_BANK a2
    where a.user_id = a2.user_id
  UNION
    select b.anum, '1000' as bank_code, holder name
    from account@BANKER_BANK b
  UNION
    select c.account_num, '2000' as bank_code, name name
    from account@CM_BANK c
  UNION
    select d.account account_num, '3000' as bank_code, d2.name as name
    from hn_account d, hn_member d2
    where d.member_id = d2.id
)
WHERE ACCOUNT_NUM = '88888-88888' 
AND bank_code = '3000';




