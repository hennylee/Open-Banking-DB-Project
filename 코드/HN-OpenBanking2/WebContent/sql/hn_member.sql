-- HN은행 회원테이블
create table hn_member(
    id varchar2(50),
    name varchar2(20) not null,
    resident_num1 char(6) not null,
    resident_num2 char(7) not null,
    password varchar2(20) not null,
    email_id varchar2(30),
    email_domain varchar2(20),
    tel1 char(3),
    tel2 char(4),
    tel3 char(4),
    post char(7),
    basic_addr varchar2(200),
    detail_addr varchar2(200),
    type char(1) default 'U',
    reg_date date default sysdate,
    CONSTRAINT hn_member_id_pk PRIMARY key(id)    
);


-- HN은행 회원 더미 데이터　＆　회원가입
INSERT INTO hn_member VALUES(
'test'
, '테스트'
,'959912'
,'2222222'
, '1111'
,'nee1202'
,'naver.com'
,'010'
, '2121'
,'7514'
,41220
,'경기도 고양시 덕양구 화신로76'
,'101-601'
,'U'
,sysdate);

commit;

-- 전체 회원 검색
select * from hn_member;
desc hn_member;

-- 로그인
select id, name, type 
from hn_member
where id = 'test' and password = '1111' and type = 'U' ;

-- 회원가입
INSERT INTO hn_member(
    id
    ,name
    ,resident_num1
    ,resident_num2
    ,password
    ,email_id
    ,email_domain
    ,tel1
    ,tel2
    ,tel3
    ,post
    ,basic_addr
    ,detail_addr
    ,type
)
VALUES(
'nee1202'
, '리해리'
,'931202'
,'2252232'
, '1111'
,'nee1993'
,'daum.net'
,'010'
, '2324'
,'7514'
,10519
,'경기 고양시 덕양구 화신로 76'
,'101-601'
,'U');

commit;


INSERT INTO hn_member(
    id
    ,name
    ,resident_num1
    ,resident_num2
    ,password
    ,email_id
    ,email_domain
    ,tel1
    ,tel2
    ,tel3
    ,post
    ,basic_addr
    ,detail_addr
    ,type
)
VALUES(
'haeni'
, '이해니'
,'931202'
,'2222222'
, '1111'
,'nee1202'
,'naver.com'
,'010'
, '2121'
,'7514'
,10519
,'경기 고양시 덕양구 화신로 76'
,'101-601'
,'U');

INSERT INTO hn_member(
    id
    ,name
    ,resident_num1
    ,resident_num2
    ,password
    ,email_id
    ,email_domain
    ,tel1
    ,tel2
    ,tel3
    ,post
    ,basic_addr
    ,detail_addr
    ,type
)
VALUES(
'hwani'
, '윤정환'
,'921022'
,'1234567'
, '1111'
,'hwani'
,'naver.com'
,'010'
, '4225'
,'3870'
,22783
,'인천 서구 가남로 373 중앙하이츠빌'
,'102동 203호'
,'U');

INSERT INTO hn_member(
    id
    ,name
    ,resident_num1
    ,resident_num2
    ,password
    ,email_id
    ,email_domain
    ,tel1
    ,tel2
    ,tel3
    ,post
    ,basic_addr
    ,detail_addr
    ,type
)
VALUES(
'veryflow'
, '김충만'
,'951010'
,'1652735'
, '1111'
,'veryflow'
,'naver.com'
,'010'
, '5221'
,'8493'
,61937
,'광주광역시 서구 무진대로 904'
,'903호'
,'U');

INSERT INTO hn_member(
    id
    ,name
    ,resident_num1
    ,resident_num2
    ,password
    ,email_id
    ,email_domain
    ,tel1
    ,tel2
    ,tel3
    ,post
    ,basic_addr
    ,detail_addr
    ,type
)
VALUES(
'dohwi1226'
, '김도희'
,'951226'
,'1234567'
, '1234'
,'dohwi1226'
,'naver.com'
,'010'
, '3880'
,'3302'
,08327
,'서울시 구로구 가마산로 77'
,'우리집'
,'U');

commit;

-- 본인 개인정보 확인
select count(*) from hn_member 
    where id='test'
    and resident_num1 = '959912'
    and resident_num2 = '2222222'
    and tel1 = '010'
    and tel2 = '2121'
    and tel3 = '7514'
;

