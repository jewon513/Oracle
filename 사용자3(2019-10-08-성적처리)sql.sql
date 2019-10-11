-- 여기는 USER3 화면입니다.

CREATE TABLE tbl_score(
    s_num	VARCHAR2(3)		PRIMARY KEY,
    s_kor	NUMBER(3),
    s_eng	NUMBER(3),		
    s_math	NUMBER(3)		
);

DESC tbl_score;

INSERT INTO tbl_score VALUES ('001',90,80,70);
INSERT INTO tbl_score VALUES ('002',90,80,70);
INSERT INTO tbl_score VALUES ('003',90,80,70);
INSERT INTO tbl_score VALUES ('004',90,80,70);
INSERT INTO tbl_score VALUES ('005',90,80,70);
INSERT INTO tbl_score VALUES ('006',90,80,70);
INSERT INTO tbl_score VALUES ('007',90,80,70);

SELECT * FROM tbl_score;

SELECT s_kor, s_eng, s_math, s_kor+s_eng+s_math AS 총점, (s_kor+s_eng+s_math)/3 AS 평균 FROM tbl_score;


-- 50부터 100까지의 임의의 정수를 생성
-- ROUND( DBMS_RANDOM.VALUES(50,100),0);
UPDATE tbl_score SET s_kor = ROUND( DBMS_RANDOM.VALUE(50,100),0),
                        s_eng = ROUND( DBMS_RANDOM.VALUE(50,100),0),
                        s_math = ROUND( DBMS_RANDOM.VALUE(50,100),0);
                        

SELECT s_num, s_kor, s_eng, s_math, s_kor+s_eng+s_math AS 총점, ROUND((s_kor+s_eng+s_math)/3,0) AS 평균 FROM tbl_score;

SELECT s_num, s_kor, s_eng, s_math, s_kor+s_eng+s_math AS 총점, ROUND((s_kor+s_eng+s_math)/3,0) AS 평균 FROM tbl_score WHERE (s_kor+s_eng+s_math)/3 >= 80;

SELECT s_num, s_kor, s_eng, s_math, s_kor+s_eng+s_math AS 총점, ROUND((s_kor+s_eng+s_math)/3,0) AS 평균 FROM tbl_score WHERE (s_kor+s_eng+s_math)/3 BETWEEN 70 AND 80;

-- 통계, 집계함수
-- sum(), avg, max(), min(), count()

SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_matH) as 수학총점 FROM tbl_score;

SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_matH) as 수학총점, SUM(s_kor+s_eng+s_math) AS 전체총점 FROM tbl_score;

SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_matH) as 수학총점, SUM(s_kor+s_eng+s_math) AS 전체총점, ROUND(AVG((s_kor+s_eng+s_math)/3),0) AS 전체평균 FROM tbl_score;

SELECT MAX(s_kor+s_eng+s_math) from tbl_score;

SELECT MIN(s_kor+s_eng+s_math) from tbl_score;

SELECT s_kor, s_eng, s_math, (s_kor + s_eng + s_math) AS 총점 FROM tbl_score;

-- 개인 총점이 200점 이상인 값들의 집계
SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_matH) as 수학총점, SUM(s_kor+s_eng+s_math) AS 전체총점, ROUND(AVG((s_kor+s_eng+s_math)/3),0) AS 전체평균 FROM tbl_score WHERE s_kor+s_eng+s_math >200;

-- 개인 평균이 70점 이상인 값들의 집계
SELECT SUM(s_kor) AS 국어총점, SUM(s_eng) AS 영어총점, SUM(s_matH) as 수학총점, SUM(s_kor+s_eng+s_math) AS 전체총점, ROUND(AVG((s_kor+s_eng+s_math)/3),0) AS 전체평균 FROM tbl_score WHERE (s_kor+s_eng+s_math)/3 >70;

-- (s_kor + s_eng + s_math)를 먼저 계산하고
-- 계산결과를 내림차순으로 정렬
-- 그리고 순위를 매기고
-- 다시 num 오름차순으로 정렬.
SELECT s_num, (s_kor + s_eng + s_math) AS 총점,
RANK() OVER ( ORDER BY (s_kor+s_eng+s_math) DESC) AS 석차 FROM tbl_score ORDER BY s_num;


SELECT s_num, (s_kor + s_eng + s_math) AS 총점,
RANK() OVER ( ORDER BY (s_kor+s_eng+s_math) DESC) AS 석차 FROM tbl_score ORDER BY s_num;


CREATE TABLE tbl_score2(
s_num	VARCHAR2(3)		PRIMARY KEY,
s_dept	VARCHAR2(3),		
s_kor	NUMBER(3),		
s_eng	NUMBER(3),		
s_math	NUMBER(3)
);

DESC tbl_score2;

CREATE TABLE tbl_dpet(
d_num	VARCHAR2(3)		PRIMARY KEY,
d_name	nVARCHAR2(20)	NOT NULL,	
d_pro	VARCHAR2(3)		
);

DESC tbl_dpet;


