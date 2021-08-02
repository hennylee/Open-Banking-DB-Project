-- hn계좌 종류 코드 : 수시입출금, 예적금
create table hn_acnt_type(
    code char(4),
    type varchar2(50)
);

select * from hn_acnt_type;

-- hn계좌 종류 코드 데이터 삽입
insert into hn_acnt_type values(
    '0001',
    '수시입출금'
);

insert into hn_acnt_type values(
    '0002',
    '예적금'
);

commit;





-- 은행 코드
create table hn_bank_code(
    code char(4),
    name varchar2(50)
);

select * from hn_bank_code;

-- 은행 코드 삽입
insert into hn_bank_code VALUES(
    '3000',
    'HN은행'
);
insert into hn_bank_code VALUES(
    '4000',
    'YB은행'
);


insert into hn_bank_code VALUES(
    '1000',
    'banker'
);
insert into hn_bank_code VALUES(
    '2000',
    'CM-Bank'
);
commit;