-- q&a (계층형 게시판)
CREATE TABLE HN_QNA(
    no NUMBER(38),
    group_no number(38), -- 글그룹 (= 최상단 부모글번호)
    --group_order number(38) default 0, -- 그룹 동일 depth간 순서? (글번호로 정렬 가능할듯)
    group_depth number(38) default 0, -- 그룹 내 depth
    parent_no  number(38) default null, -- 직계 부모 글번호
    writer varchar2(20),
    subject varchar2(200),
    content varchar2(4000),
    type char(1) default 'Q',
    view_cnt number(38) default 0,
    regdate date default sysdate,
    CONSTRAINT hn_qna_no_pk PRIMARY key(no)  
);


-- alter table hn_qna drop column group_order;

-- qna 글번호 시퀀스
create SEQUENCE seq_hn_qna nocache;


-- 글 상세 조회 
select NO ,GROUP_NO  ,GROUP_DEPTH ,PARENT_NO ,
WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate
from hn_qna where no = 63 order by group_no desc;


-- 조회수 증가
--update hn_qna set view_cnt = view_cnt + 1 where no = 1;

-- 글 수정
--update hn_qna set subject = '하이', content = '바이' where no = 6;


-- 전체 글  조회 (단순 전체)
select NO ,GROUP_NO  ,GROUP_DEPTH ,PARENT_NO ,
WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate
from hn_qna order by group_no desc, parent_no, group_depth;


-- 전체 글  조회 (단순 페이징)
SELECT * FROM 
    (select ROWNUM AS RN, NO ,GROUP_NO ,GROUP_DEPTH ,PARENT_NO ,
    WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate
    from hn_qna order by group_no desc)
WHERE RN BETWEEN 1 AND 5;


-- 전체 글 조회 (계층형 쿼리)
SELECT 
    NO ,GROUP_NO  , GROUP_DEPTH ,PARENT_NO ,
    WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate,
    LEVEL
FROM hn_qna 
START WITH PARENT_NO IS NULL --최상위노드 설정,
CONNECT BY PRIOR NO = PARENT_NO
ORDER SIBLINGS BY GROUP_NO DESC;--부모노드와 자식노드 연결


-- 전체 글 조회 (계층형 쿼리 + 페이징)
SELECT * FROM (
    SELECT 
        ROWNUM AS RN, NO ,GROUP_NO  , GROUP_DEPTH ,PARENT_NO ,
        WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate
        --LEVEL
    FROM hn_qna 
    START WITH PARENT_NO IS NULL --최상위노드 설정,
    CONNECT BY PRIOR NO = PARENT_NO
    ORDER SIBLINGS BY GROUP_NO DESC
)WHERE RN BETWEEN 11 AND 11;--부모노드와 자식노드 연결



-- qna 새 질문 등록
insert into hn_qna(
    no,
    group_no, -- 글그룹 (= 최상단 부모글번호)
    --group_order, -- 그룹 동일 depth간 순서? (글번호로 정렬 가능할듯)
    --group_depth, -- 그룹 내 depth
    parent_no, -- 직계 부모 글번호
    writer,
    subject,
    content
)
values(
    SEQ_HN_QNA.nextval,
    SEQ_HN_QNA.currval,
    null,
    'test',
    '무한생성',
    '내용무'
);

commit;


-- 새 답변 등록
insert into hn_qna(
    no,
    group_no, -- 글그룹 (= 최상단 부모글번호)
    group_depth, -- 그룹 내 depth
    parent_no, -- 직계 부모 글번호
    writer,
    subject,
    content,
    type
)
select 
    SEQ_HN_QNA.nextval,
    group_no, 
    group_depth + 1,
    6,
    'haeni',
    '#1 답글 test',
    '#1 답글 test 내용',
    'A'
from hn_qna 
where no = 6;


commit;


-- 글삭제
--delete from hn_qna where no = 34;

-- 글삭제 가능 여부 체크 : 답변 달린 글이 있는지?
select count(*) from hn_qna where parent_no = 6;
