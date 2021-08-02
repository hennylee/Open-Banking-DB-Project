-- HN은행 계좌 테이블
create table hn_account(
	account varchar2(50),
	password char(4) not null,
	member_id varchar2(50) not null,
	balance number(38) default 0,
	alias varchar2(50),
	opening_date date default sysdate,
    type_code char(4) not null,
    bank_code char(4) not null,
    CONSTRAINT hn_account_account_pk PRIMARY key(account) 
);

-- HN계좌 더미 데이터 삽입
INSERT INTO hn_account(
	account
	,password
	,member_id
	,alias
    ,opening_date
    ,type_code
    ,bank_code
)
VALUES(
	'88888-88888'
	,'1993'
	,'nee1202'
	,null
    ,sysdate - 57
    ,'0001'
    ,'3000'
);

INSERT INTO hn_account(
	account
	,password
	,member_id
	,alias
    ,opening_date
    ,type_code
    ,bank_code
)
VALUES(
	'99999-999999'
	,'1993'
	,'nee1202'
	,null
    ,sysdate - 47
    ,'0001'
    ,'3000'
);

commit;


-- hn계좌 종류별 계좌번호 생성 시퀀스
create sequence seq_hn_acnt_mid_1 nocache;
create sequence seq_hn_acnt_mid_2 nocache;
create sequence seq_hn_acnt_mid_3 nocache;
create sequence seq_hn_acnt_mid_4 nocache;

-- 중간 번호 생성
--select to_char(seq_hn_acnt_mid_1.nextval, 'FM000000') from dual;

--계좌 생성
INSERT INTO hn_account(
	account
	,password
	,member_id
	,alias
    ,type_code
    ,bank_code
) VALUES(
	'111111-111111'
	,'1993'
	,'haeni'
	,null
    ,'0001'
    ,'3000'
);


INSERT INTO hn_account(
	account
	,password
	,member_id
	,alias
    ,type_code
    ,bank_code
) VALUES(
	'222222-222222'
	,'1993'
	,'hwani'
	,'소중한 생활비'
    ,'0001'
    ,'3000'
);


INSERT INTO hn_account(
	account
	,password
	,member_id
	,alias
    ,type_code
    ,bank_code
) VALUES(
	'333333-333333'
	,'1111'
	,'veryflow'
	,'훈련비'
    ,'0001'
    ,'3000'
);


-- dohwi1226
INSERT INTO hn_account(
	account
	,password
	,member_id
	,alias
    ,type_code
    ,bank_code
) VALUES(
	'555555-555555'
	,'1111'
	,'dohwi1226'
	,'빌린돈'
    ,'0001'
    ,'3000'
);


commit;



-- id로 전체 계좌 조회
select a.account account, a.balance balance, a.alias alias, c.type type
from hn_account a, hn_member b, hn_acnt_type c
where a.type_code = c.code
    and a.member_id = b.id
    and a.member_id = 'test';


-- 전화번호로 전체 계좌 조회
select a.account account, a.balance balance, a.alias alias, c.type type
from hn_account a, hn_member b, hn_acnt_type c
where a.type_code = c.code
    and b.tel1 = '010'
    and b.tel2 = '2121'
    and b.tel3 = '7514'
    and a.member_id = b.id;


-- 계좌 생성일에 따른 생성 가능 여부 판단

select possible_date from(
    select to_char((b.opening_date + 30), 'yyyy-MM-dd') as possible_date
    from hn_member a, hn_account b
    where a.tel1||'-'||a.tel2||'-'||a.tel3='010-2121-7514' 
    and a.id = b.member_id and (b.opening_date + 30) > sysdate
    order by b.opening_date desc
)
where rownum = 1;

-- 비밀번호 조회
select count(*) from hn_account where account = '555555-555555' and password = 1111;


 -- 내 잔액 update
update hn_account set balance = 300000 where account = '111111-111111';
commit;