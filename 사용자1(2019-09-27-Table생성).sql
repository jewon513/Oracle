-- 여기는 User 1 사용자 화면입니다.
-- DBA 역할중에서
-- 데이터 저장소의 기초인 Table을 만드는 것

-- 학생정보를 저장할 tbl_student Table 생성
-- tbl_student : 생성할 table의 이름
-- 이름명명규칙 : Java에서 var, class, method 등의 이름을 명명하는 것과 같다.
--                단, 오라클에서는 대소문자를 구별하지 않는다.
--                일반적으로 테이블을 만들때 테이블 이름 앞에 접두사 tbl_을 사용한다.

CREATE TABLE tbl_student (
    -- 칼럼 : 필드(멤버)변수와 같은 개념
    -- 칼럼들은 컴마(,)로 구분하여 나열한다.
    -- 칼럼들의 data type을 지정을 한다.
    -- data type에는 ()을 사용하여 최대 저장할 크기를 byte 단위로 지정한다.
    
    -- Char() : 고정길이 문자열 칼럼
    -- 저장할 데이터가 항상 일정한 길이를 유지할 경우
    -- 최대 2000글자까지 지정
    
    -- 오라클에서 CHAR칼럼에 순수 숫자로만 되어있는 데이터를 저장할 경우
    -- 약간의 문제를 일으킨다.
    -- A0001 형식으로 저장하면 당연히 문자열로 인식한다.
    -- 0001 형식으로 저장하면 오라클 DB에서는 문자열로 저장이 되는데
    -- Java 또는 다른 프로그래밍 언어를 통해 DB를 접속할 경우
    -- 숫자로 인식을 해버리는 오류가 있다.
    -- 그래서 오라클에서는 CHAR는 아주 특별한 경우가 아니면 VARCHAR2로 사용한다. 
    
    -- VARCHAR2() : 가변길이 문자열 저장 칼럼
    -- 최대 4000글자까지 저장
    -- 최대글자까지 저장하는 것은 CHAR와 유사하지만
    -- 만약 저장하는 데이터의 길이가 일정하지 않은 경우는 데이터 길이만큼 칼럼이 변환되어 파일이 저장된다.
    st_num CHAR(5),
    
    --nVARCHAR2() : 유니코드, 다국어 지원 칼럼
    --만약 한글 데이터가 입력될 가능성이 있는 칼럼은, 반드시 nVARCHAR2()를 사용하자.
    --한글이 입력될 가능성이 없는 경우 VARCHAR2()를 사용하지만, nVARCHAR2()를 사용해도 큰 문제는 없다.
    st_name nVARCHAR2(20),
    st_addr nVARCHAR2(125),
    
    st_tel VARCHAR2(20),
    
    --숫자를 저장하는 칼럼
    --표준 SQL에서는 INT, FLOAT, LONG, DOUBLE 등의 KEYWORD가 있다.
    --오라클에서도 표준 SQL 숫자 type을 사용할 수 있지만
    --오라클 코드에서는 NUMBER라는 칼럼을 사용한다.
    st_grade NUMBER(1), --INT라는 keyword를 사용하면 NUMBER(38)으로 변환되어 생성된다.
    st_dept nVARCHAR2(10),
    st_age NUMBER(3)
);

DROP TABLE tlb_student;

INSERT INTO tlb_student(st_num, st_name, staddr)
VALUES('0001', '성춘향', '익산시');

DROP TABLE tbl_student;
CREATE TABLE tbl_student(
    st_num      CHAR(5) UNIQUE NOT NULL,
    st_name     nVARCHAR2(20) NOT NULL,
    st_addr     nVARCHAR2(125),
    st_tel      VARCHAR2(20)NOT NULL,
    st_dept     nVARCHAR2(20),
    st_grade    NUMBER(1),
    st_age      NUMBER(3)
);

INSERT INTO tbl_student(st_num, st_name, st_tel)
VALUES('00001','성춘향','남원시');

INSERT INTO tbl_student(st_num, st_name, st_tel)
VALUES('00001', '이몽룡', '서울시');

-- tbl_student 테이블은 학생정보를 보관하는 매우 중요한 table이다.
-- tbl_student에서 어떤 학생의 데이터를 조회하고자 할때는
-- 학생이름, 전화번호 등으로 조회를 할 수 있다.
-- 하지만 학생이름이나 전화번호로 조회를 하면
-- 조회(추출)되는 데이터가 2개 이상 보일 수 있다.
-- 2개 이상의 데이터가 보이면 어떤 데이터가 내가 필요한 데이터인지
-- 다른 항목을 통해서 살펴봐야하는 불편함이있다.
-- 이때 어떤 칼럼에 값을 조회했을때 
-- 유일하게 1개의 데이터만 추출되도록 설정을 할 수 있는데
-- 이런 설정을 한 칼럼을 primary key 라고 한다.


DROP TABLE tbl_student;

-- tbl_student 테이블에 저장된 수 많은 데이터중에서
-- st_num 값으로 조회를 실행하면
-- 추출되는 데이터는 1개만 나타 날 것이다.
-- 이유는 현재 st_num 칼럼이 UNIQUE로 설정되어 있고, NOT NULL이기 떄문에 있거나 무조건 1개만 나타난다.
-- st_num 칼럼은 UNIQUE와 NOT NULL 제약조건을 설정해 둔다.

CREATE TABLE tbl_student(
    st_num      CHAR(5) PRIMARY KEY,
    st_name     nVARCHAR2(20) NOT NULL,
    st_addr     nVARCHAR2(125),
    st_tel      VARCHAR2(20)NOT NULL,
    st_dept     nVARCHAR2(20),
    st_grade    NUMBER(1),
    st_age      NUMBER(3)
);

-- table의 구조를 확인하는 명령문
DESCRIBE tbl_student;

-- user1 사용자가 생성한 테이블이 어떤 것들이 있는가?
SELECT * FROM dba_tables WHERE OWNER ='USER1';


-- tbl_student에 데이터 추가하기
-- INSERT INTO 테이블 이름 ( colum, ..... ) 
-- VALUES ( value, .......);
INSERT INTO tbl_student (st_num, st_name, st_addr, st_tel, st_dept,st_grade,st_age)
VALUES('00001','홍길동','서울시','010-111-1111','컴공과',1,33);

INSERT INTO tbl_student (st_num, st_name, st_addr, st_tel, st_dept,st_grade,st_age)
VALUES('00002','성춘향','서울시','010-222-1111','컴공과',1,33);

INSERT INTO tbl_student (st_num, st_name, st_addr, st_tel, st_dept,st_grade,st_age)
VALUES('00003','이몽룡','서울시','010-333-1111','컴공과',1,33);

INSERT INTO tbl_student (st_num, st_name, st_addr, st_tel, st_dept,st_grade,st_age)
VALUES('00004','장보고','서울시','010-444-1111','컴공과',1,33);

INSERT INTO tbl_student (st_num, st_name, st_addr, st_tel, st_dept,st_grade,st_age)
VALUES('00005','임꺽정','서울시','010-555-1111','컴공과',1,33);


SELECT * FROM tbl_student;
