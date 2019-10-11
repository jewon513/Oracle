-- 여기는 USER3 화면입니다.

CREATE TABLE tbl_student(
st_num	VARCHAR2(3)		PRIMARY KEY,
st_name	nVARCHAR2(50)	NOT NULL,
st_tel	VARCHAR2(3),	
st_addr	nVARCHAR2(125),		
st_grade	NUMBER(1),		
st_dept	VARCHAR2(3)		
);

DESC tbl_student;

SELECT * FROM tbl_student;

SELECT * FROM tbl_score;

-- score 테이블의 성적리스트를 확인 했더니 학번은 테이블에 저장이 되어있는데 학번에 해당하는 학생이 누구인지를 모르겠다.

-- student 테이블과 JOIN을 실행해서 성적정보를 확인하고자 한다.

-- 현재 score 테이블의 s_num 칼럼의 모든 데이터가 student 테이블의 st_num 칼럼에 모두 있기 때문에 EQ JOIN을 하여 데이터를 확인 할 수 있다.
SELECT * FROM tbl_score, tbl_student WHERE tbl_score.s_num = tbl_student.st_num;

SELECT * FROM tbl_score sc , tbl_student st WHERE sc.s_num = st.st_num;

--SELECT * 는 데이터가 많을 경우 조회하는데 다소 시간이 많이 걸린다.

SELECT sc.s_num, st.st_name, sc.s_kor, sc.s_eng, sc.s_math FROM tbl_score sc , tbl_student st WHERE sc.s_num = st.st_num;

-- 성적데이터에 임의 데이터를 추가

INSERT INTO tbl_score (s_num, s_kor, s_eng, s_math)
VALUES ('101', 90,88,77);

-- 아래 SELECT 문을 사용하면 101번은 조회되지 않는다.
SELECT sc.s_num, st.st_name, sc.s_kor, sc.s_eng, sc.s_math FROM tbl_score sc , tbl_student st WHERE sc.s_num = st.st_num;

-- score 테이블과 student 테이블간에 참조무결성이 유지 되지 않고 있는 상황이기 때문에 EQ JOIN으로 데이터를 조회하면 101번이 누락되어 조회되지 않는다.
-- 이런 경우 LEFT JOIN을 사용해서 조회를 한다.
SELECT  sc.s_num, st.st_name, sc.s_kor, sc.s_eng, sc.s_math 
        FROM tbl_score sc -- 조회하고자 하는 주 데이터 
            LEFT JOIN tbl_student st --연결해서 보고자 하는 보조 데이터
                ON  sc.s_num = st.st_num; --연계할 조건(칼럼) 설정
                

SELECT  sc.s_num, st.st_name, sc.s_kor, sc.s_eng, sc.s_math,
        sc.s_kor+sc.s_eng+sc.s_math AS 총점,
        ROUND((sc.s_kor + sc.s_eng + sc.s_math)/3,0) AS 평균
        FROM tbl_score sc
            LEFT JOIN tbl_student st 
                ON  sc.s_num = st.st_num;
                
-- score2에 데이터를 추가하기
DESC tbl_score2;

SELECT * FROM tbl_score2;

SELECT sc.s_num, st.st_name, sc.s_dept, sc.s_kor, sc.s_eng, sc.s_math,
            sc.s_kor+sc.s_eng+sc.s_math AS 총점,
            ROUND((sc.s_kor + sc.s_eng + sc.s_math)/3,0) AS 평균 
                FROM tbl_score2 sc 
                LEFT JOIN tbl_student st 
                ON sc.s_num=st.st_num;
                
-- 학과데이터 추가
INSERT INTO tbl_dept (d_num, d_name, d_pro)
VALUES ('001' , '컴퓨터공학과', '홍길동');

INSERT INTO tbl_dept (d_num, d_name, d_pro)
VALUES ('002' , '영어영문학과', '성춘향');

INSERT INTO tbl_dept (d_num, d_name, d_pro)
VALUES ('003' , '경영학과', '임꺽정');

INSERT INTO tbl_dept (d_num, d_name, d_pro)
VALUES ('004' , '정치경제학과', '장보고');

INSERT INTO tbl_dept (d_num, d_name, d_pro)
VALUES ('005' , '군사학과', '이순신');

-- 데이터를 추가하려고 했더니 column 길이가 짧아 추가가 되지 않는다. 테이블을 수정해야한다.
ALTER TABLE tbl_dept MODIFY (d_pro nVARCHAR2(3));

-- 수정한뒤 스코어 테이블과 학과 테이블을 left join 하였다.
SELECT sc.s_num, dp.d_name, dp.d_pro, sc.s_kor FROM tbl_score2 sc LEFT JOIN tbl_dept dp ON sc.s_dept=dp.d_num ;

-- 성적테이블과 학생테이블, 학과테이블을 연계하여 학생이름, 학과이름을 같이 조회하고 싶다.
-- 성적테이블(주), 학생테이블과 학과테이블(보조)
SELECT sc.s_num AS 학번, st.st_name AS 이름, dp.d_name AS 학과, dp.d_pro AS 담당교수, sc.s_kor, sc.s_eng, sc.s_math,
            sc.s_kor+sc.s_eng+sc.s_math AS 총점,
            ROUND((sc.s_kor + sc.s_eng + sc.s_math)/3,0) AS 평균 
            FROM tbl_score2 sc LEFT JOIN tbl_student st ON sc.s_num=st.st_num
                                LEFT JOIN tbl_dept dp on  sc.s_dept=dp.d_num;
                                
-- 위 SQL을 활용하여 컴퓨터 공학 학생들 성적만 확인하고 싶다.

SELECT sc.s_num AS 학번, st.st_name AS 이름, dp.d_name AS 학과, dp.d_pro AS 담당교수, sc.s_kor, sc.s_eng, sc.s_math,
            sc.s_kor+sc.s_eng+sc.s_math AS 총점,
            ROUND((sc.s_kor + sc.s_eng + sc.s_math)/3,0) AS 평균 
            FROM tbl_score2 sc LEFT JOIN tbl_student st ON sc.s_num=st.st_num
                                LEFT JOIN tbl_dept dp on  sc.s_dept=dp.d_num
                                WHERE dp.d_name = '컴퓨터공학과';
CREATE VIEW view_score
AS 
(
SELECT sc.s_num AS 학번, st.st_name AS 이름, dp.d_name AS 학과, dp.d_pro AS 담당교수, sc.s_kor, sc.s_eng, sc.s_math,
            sc.s_kor+sc.s_eng+sc.s_math AS 총점,
            ROUND((sc.s_kor + sc.s_eng + sc.s_math)/3,0) AS 평균 
            FROM tbl_score2 sc LEFT JOIN tbl_student st ON sc.s_num=st.st_num
                                LEFT JOIN tbl_dept dp on  sc.s_dept=dp.d_num
);

-- SELECT SQL을 수행해서 결과를 얻고자 할 때, 매우 복잡한 SQL문을 매번 실행하는 것은 비효율적(코딩적인 관점에서)이다.
-- DBMS에서는 SELECT SQL문을 마치 물리적 table 인 것 처럼 취급할 수 있도록 VIEW OBJECT를 제공한다.
-- VIEW OBJECT를 SELECT 실행하면 DMBS는 실제 table에서 VIEW OBJECT에 설정된 SQL문을 실행하여 결과를 보여준다.
-- 실제 데이터를 가지고 있지 않고, 물리적 table로부터 데이터를 가져와서 보여주는 역할만 수행하는 가상의 table이다.
-- 단, VIEW를 만들기 위한 SQL 문에는 ORDER BY를 사용할 수 없다.

SELECT * FROM view_score;

SELECT * FROM view_score WHERE "학과" = '컴퓨터공학과';

SELECT * FROM view_score ORDER BY "평균" DESC ;

DESC view_score;

-- 한번 VIEW로 생성을 해 두면 마치 물리적 TABLE이 있는 것과 같이 작동을 하며
-- SELECT 문의 다양한 옵션들을 사용하여 데이터를 조회할 수 있다.

SELECT * FROM view_score WHERE 평균 > 80;
SELECT * FROM view_score WHERE 평균 BETWEEN 70 AND 90;
SELECT * FROM view_score WHERE 평균 >= 70 AND 평균 <=90;

SELECT * FROM view_score
WHERE 학과 LIKE '컴퓨터%';

SELECT * FROM view_score WHERE 학과 LIKE '%공학과';
                
-- LIKE에서 %가 앞에 나오는 조회 명령문은 가급적 사용을 자제하자

SELECT 학번 || ' : ' || 이름 FROM view_score; -- 오라클 전용
/*
SELECT 학번 & ' : ' & 이름 FROM view_score; 
SELECT 학번 + ' : ' + 이름 FROM view_score; 
*/

-- Java 등 프로그래밍 코딩으로 SQL을 작성할때는 LIKE 키워드의 문자열 등은 연결문자열로 작성 해야 한다.
SELECT * FROM view_score WHERE 학과 LIKE '컴퓨터' || '%';


-- 해당 칼럼의 데이터가 다수 존재할때, 중복되지 않는 데이터만 출력하는 키워드

-- 같은 칼럼에 있는 동일한 값은 한번만 출력하라
-- 다수의 칼럼을 DISTINCT 로 묶으면 원하는 결과가 나오지 않을 수 있다.
SELECT DISTINCT 학과 FROM view_score;

SELECT 학과 FROM view_score GROUP BY 학과;

-- GROUP BY
-- 특정 칼럼을 기준으로 하여 집계를 할 때 사용하는 명령절

-- 1. 학과별로 국어 점수의 총점을 계산하고 싶다.
--      각 학과별로 그룹을 묶고 국어점수의 총점을 계산 한 후 학과 번호 순으로 보여준다.
--      GROUP BY로 묶어서 부분합을 보고자 할 때 기준으로 하는 칼럼 이외에 SELECT문에 나열된 칼럼들 중
--      집계함수로 감싸지 않은 칼럼들은 GROUP BY 절 다음에 나열해주어야 한다.
SELECT 학과, 담당교수, SUM(s_kor) FROM view_score GROUP BY 학과, 담당교수;

--      학번과 학과 코드로 묶어주는 데이터는 의미가 없다. 왜냐하면 학번은 PRIMARY KEY이기 때문이다.
--      GROUP으로 묶어서 집계를 낼때에는 어떤 칼럼들을 묶을 것인지에 대한 많은 고민들을 해야한다.
SELECT 학번, 학과, 담당교수, SUM(s_kor) FROM view_score GROUP BY 학번, 학과, 담당교수;

SELECT 학과, 담당교수, SUM(s_kor), SUM(s_eng), SUM(s_math) FROM view_score WHERE 학과 IN('컴퓨터공학과','영어영문학과') GROUP BY 학과, 담당교수;

-- GROUP BY를 실행할때
-- 조건을 부여하는 방법
-- WHERE 조건을 부여하는 방법
-- HAVING 조건을 부여하는 방법