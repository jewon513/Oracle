-- 여기는 USER2 입니다.

-- 학생정보를 저장할 table 생성

CREATE TABLE tbl_student (
    st_num	VARCHAR2(5)	        PRIMARY KEY,
    st_name	nVARCHAR2(30)       NOT NULL,
    st_addr	nVARCHAR2(125),
    st_grade	NUMBER(1),
    st_height	NUMBER(3),
    st_weight	NUMBER(3),
    st_nick	nVARCHAR2(20),
    st_nick_rem	nVARCHAR2(50),	
    st_dep_no	VARCHAR2(3)	    NOT NULL	
);

INSERT INTO tbl_student (st_num, st_name, st_dep_no, st_grade)
VALUES ('A0001','홍길동','001',3);

INSERT INTO tbl_student (st_num, st_name, st_dep_no, st_grade)
VALUES ('A0002','이몽룡','001',2);

INSERT INTO tbl_student (st_num, st_name, st_dep_no, st_grade)
VALUES ('A0003','성춘향','001',1);

INSERT INTO tbl_student (st_num, st_name, st_dep_no, st_grade)
VALUES ('A0004','임꺽정','002',4);

INSERT INTO tbl_student (st_num, st_name, st_dep_no, st_grade)
VALUES ('A0005','장보고','003',2);

SELECT * FROM tbl_student;

SELECT * FROM tbl_student ORDER BY st_de;

--학번이 2번부터 4번까지인 학생의 리스트만 보고 싶다
SELECT * FROM tbl_student WHERE st_num >='A0002' AND st_num <='A0004'; 

SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004';

SELECT * FROM tbl_student WHERE st_grade = 2;

--학번이 2번부터 4번까지인 학생의 리스트를 이름순으로 보고싶다.
SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0002' AND 'A0004' ORDER BY st_name;

--학번이 2번부터 4번까지인 학생의 리스트를 학년 순으로 보고 싶다.
SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0002' ANd 'A0004' ORDER BY st_grade DESC;

--tbl_student의 테이블에 저장된 데이터의 레코드가 모두 몇개인가?
SELECT COUNT(*) FROM tbl_student;

--학생테이블에서 2학년 학생들의 데이터 레코드가 모두 몇개인가?
SELECT COUNT(*) FROM tbl_student WHERE st_grade=2;

--학생테이블에서 학년이 가장 높은 값은 어떤 값있는가?

SELECT MAX(st_grade) FROM tbl_student;

SELECT MIN(st_grade) FROM tbl_student;

-- 학생테이블에 저장된 데이터의 학년칼럼의 모든 데이터를 더하면 얼마?

SELECT SUM(st_grade) FROm tbl_student;

SELECT AVG(st_grade) FROM tbl_student;

SELECT * FROM tbl_student;

--학생들의 주소칼럼의 데이터가 비어있는 상태이다.
--성춘향 학생의 주소를 광주광역시로
--이몽룡 학생의 주소를 익산시로
--홍길동 학생의 주소를 서울특별시로

UPDATE tbl_student SET st_addr ='광주광역시' WHERE st_num='A0003';
UPDATE tbl_student SET st_addr ='익산시' WHERE st_num='A0002';
UPDATE tbl_student SEt st_addr ='서울특별시' WHERE st_num='A0001';

SELECT * FROM tbl_student;

INSERT INTO tbl_student (st_num,st_name,st_grade,st_dep_no)
VALUES ('A0006', '성춘향', 2, '001');

SELECT * FROM tbl_student;





