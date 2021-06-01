select * from tab;

desc HANA_MEMBER;

/*
이름              널?       유형           
--------------- -------- ------------ 
ID              NOT NULL VARCHAR2(14) 
PW              NOT NULL VARCHAR2(30) 
RESIDENT_NUMBER NOT NULL VARCHAR2(14) 
NAME            NOT NULL VARCHAR2(30) 
AGE             NOT NULL NUMBER(4)    
SEX                      CHAR(1)      
JOIN_DATE                DATE    
*/

-- 회원가입
INSERT INTO HANA_MEMBER(ID, PW, RESIDENT_NUMBER, NAME, AGE, SEX) 
VALUES('haeni', '1234', '931202-2222222', '이해니', '20' , 'F');

SELECT * FROM HANA_MEMBER;

SELECT to_CHAR(JOIN_DATE, 'yyyy-MM-dd HH:SS') FROM HANA_MEMBER;

commit;

SELECT COUNT(*) FROM HANA_MEMBER WHERE ID = 'haeni';

SELECT * FROM HANA_MEMBER WHERE ID = 'haeni' AND pw = '1234';