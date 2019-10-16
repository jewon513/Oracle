-- GRADE 화면입니다. -- 

DESC tbl_score;

/*
이름        널?       유형            
--------- -------- ------------- 
S_ID      NOT NULL NUMBER        
S_STD     NOT NULL NVARCHAR2(50) 
S_SCORE   NOT NULL NUMBER(3)     
S_REMARK           NVARCHAR2(50) 
S_SUBJECT          VARCHAR2(4)  

--학생정보 칼럼을 제 2정규화
score 테이블에는 학생이름이 일반저인 문자열로 저장이 되었다
일반적인 문자열로 저장된 경우 학생 이름을 변경해야 할 경우가 발생하면
UPDATE tbl_score SET  s_std = '' WHERE s_std ='' 라고 입력할 것이다.
하지만 DMBS UPDATE 권장 패턴에서는 여러개의 레코드를 수정/변경 하는 것을 지양한다.

또한, 만약 학생정보에 다른 정보를 포함하고 싶을때는 tbl_score 테이블에 칼럼을 추가하는 등의 방식으로 처리를 해야하는데
이 방식 또한 좋은 방식이 아니다.

그래서 학생정보 테이블을 생성하고 학생코드를 만들어준 다음 score 테이블의 s_std 칼럼의 값을 학생코드로 변경하여 제 2정규화를 수행하고자 한다.

단, tbl_score에 저장된 학생이름이 동명이인이 없다라고 가정한다.

*/

--1. tbl_score 테이블로부터 학생이름을 추출하여 table로 생성
SELECT s_std FROM tbl_score GROUP BY s_std;

--2. 질의결과를 모두 선택하여 엑셀 파일로 복사

--3. 학생정보를 입력
--4. 학생정보 테이블 생성
CREATE TABLE tbl_student(
        st_num	    VARCHAR2(5)		PRIMARY KEY,
        st_name	    nVARCHAR2(50)	NOT NULL,	
        st_tel	    VARCHAR2(20),		
        st_addr	    nVARCHAR2(125),		
        st_grade	NUMBER(1)	    NOT NULL,	
        st_dept	    VARCHAR2(5)	    NOT NULL	
);

SELECT * FROM tbl_student;

--5. 데이터 IMPORT 완료

--6. tbl_score 테이블의 s_std 칼럼의 값을 학생 이름을 -> 학번으로 변경
        --가. 임시 칼럼을 생성
        ALTER TABLE tbl_score ADD s_stcode VARCHAR2(5);
        
        --나. tbl_student와 tbl_score를 연결해서 tbl_student의 학번정보를 tbl_score에 등록
        SELECT * FROM tbl_score, tbl_student WHERE s_std = st_name;
        
        UPDATE tbl_score SET s_stcode = (SELECT st_num FROM tbl_student WHERE st_name = s_std);

SELECT s_stcode, st_num, s_std, st_name FROM tbl_score, tbl_student WHERE s_stcode =st_num;

--7. tbl_score의 s_std 칼럼을 삭제하고, s_stdcode 칼럼을 s_std 칼럼으로 이름 변경
        --가. s_std 칼럼 삭제
        ALTER TABLE tbl_score DROP COLUMN s_std;
        
        --나 s_stdcode 칼럼의 이름 변경
        ALTER TABLE tbl_score RENAME COLUMN s_stcode TO s_std;
        
SELECT * FROM tbl_score;

SELECT s_id, s_score, tbl_subject.s_subject
FROM tbl_score
LEFT JOIN tbl_subject ON tbl_score.s_subject=tbl_subject.s_code
LEFT JOIN tbl_student ON tbl_score.s_std=tbl_student.st_num;


CREATE TABLE tbl_dept(
    d_num	VARCHAR2(5)		PRIMARY KEY,
    d_name	nVARCHAR2(30)	NOT NULL,	
    d_pro	nVARCHAR2(20),		
    d_tel	nVARCHAR2(20)
);

DROP VIEW view_score;
--아래 쿼리를 뷰로 만들자
CREATE VIEW view_score AS(
SELECT SC.s_id,
        SC.s_std, ST.st_name, St.st_grade,
        st.st_dept, dp.d_name, dp.d_tel,
        sc.s_subject, sb.s_subject AS sb_name,
        sc.s_score
    FROM tbl_score sc
        LEFT JOIN tbl_student st ON sc.s_std = st.st_num
        LEFT JOIN tbl_subject sb ON sc.s_subject = sb.s_code
        LEFT JOIN tbl_dept dp ON st.st_dept = dp.d_num
);

SELECT * FROM view_score;

SELECT * FROM tbl_subject;


-- 피벗은 이 코드가 좋다.
SELECT s_std, st_name, d_name, st_grade,
        SUM(DECODE(s_subject, 'S001', s_score)) AS 과학,
        SUM(DECODE(s_subject, 'S002', s_score)) AS 수학,
        SUM(DECODE(s_subject, 'S003', s_score)) AS 국어,
        SUM(DECODE(s_subject, 'S004', s_score)) AS 미술,
        SUM(DECODE(s_subject, 'S005', s_score)) AS 국사,
        SUM(DECODE(s_subject, 'S006', s_score)) AS 영어,
        SUM(s_score) AS 총점,
        ROUND(AVG(s_score),1) AS 평균,
        RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차
FROM view_score
GROUP BY s_std, st_name, d_name, st_grade;
/*
    DECODE(칼럼, 값, T결과, F결과)
    if(칼럼 == 값) 
        print(T결과)
    else
        print(F결과)
        
    DECODE(칼럼, 값, T결과)
    if(칼럼 == 값)
        print(T결과)
    else
        print((null))
*/

-- 아직은 문제가 좀 있는데 깔끔함
SELECT *
FROM
(
    SELECT s_std, st_name, d_name, st_grade, s_subject, s_score FROM view_score
)
PIVOT 
(
    SUM(s_score)
    FOR s_subject
    IN(
        'S001' AS	과학,
        'S002' AS	수학,
        'S003' AS	국어,
        'S004' AS	미술,
        'S005' AS	국사,
        'S006' AS	영어
    )
);


-- 위의 피벗 쿼리를 뷰로 만들어보자
CREATE VIEW view_score_pv AS(
    SELECT s_std, st_name, d_name, st_grade,
            SUM(DECODE(s_subject, 'S001', s_score)) AS 과학,
            SUM(DECODE(s_subject, 'S002', s_score)) AS 수학,
            SUM(DECODE(s_subject, 'S003', s_score)) AS 국어,
            SUM(DECODE(s_subject, 'S004', s_score)) AS 미술,
            SUM(DECODE(s_subject, 'S005', s_score)) AS 국사,
            SUM(DECODE(s_subject, 'S006', s_score)) AS 영어,
            SUM(s_score) AS 총점,
            ROUND(AVG(s_score),1) AS 평균,
            RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차
    FROM view_score
    GROUP BY s_std, st_name, d_name, st_grade
);

SELECT * FROM view_score_pv;

    -- 제 2정규화가 완료된 4개의 table을 서로 REALTION 설정
    -- 참조 무결성 제약 조건 설정
    
ALTER TABLE tbl_score ADD CONSTRAINT FK_SCORE_SUBJECT FOREIGN KEY(s_subject) REFERENCES tbl_subject(s_code);

ALTER TABLE tbl_score ADD CONSTRAINT FK_SCORE_STUDENT FOREIGN KEY(s_std) REFERENCES tbl_student(st_num);

ALTER TABLE tbl_student ADD CONSTRAINT FK_STUDENT_DEPT FOREIGN KEY(st_dept) REFERENCES tbl_dept(d_num);
