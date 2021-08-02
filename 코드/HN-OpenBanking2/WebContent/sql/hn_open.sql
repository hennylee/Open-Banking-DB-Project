-- 오픈뱅킹 서비스를 신청한 회원
drop table hn_open_register;

create table hn_open_register(
    --agree_no number(38) not null,    -- 정보 동의 no
    member_id varchar(50),-- 회원 아이디
    regdate date default sysdate ,-- 신청일자
    password number not null, -- 비밀번호
    CONSTRAINT hn_open_register_id_pk PRIMARY key(member_id)
);



-- 오븐뱅킹 정보 동의 번호 시퀀스
drop sequence seq_hn_open_agreement;
create sequence seq_hn_open_agreement nocache;


select holder, type, bank from account@BANKER_BANK where anum= '100015389398';

select * from hn_account;
select * from HN_TRANSACTION;