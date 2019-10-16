-- 여기는 USER3 화면입니다.

-- 현재 USER3 사용자가 사용할 수 있는 Table목록
SELECT * FROM TAB;


                        -- TABLE과 VIEW의 차이
/*
    TABLE                       VIEW
----------------------------------------------------------------------------
    실제 저장된 데이터          가상의 데이터
                                테이블로부터 SELECT 실행 한 후 보여주는 형태
    CRUD 모두 가능              READ 조회(SELECT)만 가능
    원본데이터                  TABLE로부터 새로 생성된 보기 전용 데이터
----------------------------------------------------------------------------
*/

-- 단순한 성적 테이블 조회
SELECT * FROM tbl_score;

/*    
                            --JOIN--
                            
    단순한 성적 테이블 조회로는 구체적으로 학생의 이름이라던가 다른 정보를 찾기가 어렵다.
    학번과 연계된 학생테이블로 부터 학생이름을 연결하고
    학번과 연계된 학과테이블로 부터 학과이름을 연결하여
    마치 한개의 데이터 처럼 보기 위한 SQL문이다.

*/

-- 학생테이블
DESC tbl_student;

-- 현재 학생테이블에 학과 코드 칼럼이 있음에도 SQL의 편의성을 고려하여 성적테이블에 학과 코드를 추가하여 관리를 했다. : tbl_score2;
-- 그러나 두개의 테이블에 동시에 학과 코드가 존재하고, 코드가 다르다면 데이터의 무결성에 문제가 생긴다.

-- tbl_score에는 학과 칼럼이 존재하지 않기 때문에 tbl_score 테이블과 tbl_student를 JOIN 하고
-- 그 결과에서 학과코드를 기준으로 다시 tbl_dept와 JOIN을 수행하는 SQL문을 작성하려고 한다.

-- tbl score와 tbl_student를 JOIN

SELECT * FROM tbl_score sc LEFT JOIN tbl_student st ON sc.s_num=st.st_num;

-- 데이터를 다시 import 하기 위해 tbl_student의 전체 데이터를 삭제한다.
DELETE FROM tbl_student;

-- 엑셀의 학생정보를 tbl_student에 import했다.
SELECT * FROM tbl_student;

-- 학생 테이블과 학과 테이블을 JOIN
-- 보고자 하는 칼럼만 LIST로 나열하고 결과를 학번순으로 ORDER BY 하였다.
SELECT st_num, st_name, st_dept, d_name, d_pro FROM tbl_student st LEFT JOIN tbl_dept dp ON st.st_dept=dp.d_num ORDER BY st_num;

-- 위의 SQL문을 VIEW 로 CREATE 해보자.
-- 먼저 ORDER BY를 삭제하자 (VIEW 를 만들떈 사용하지 못한다)
-- 그리고 각 칼럼에 별도의 AS를 설정하고, SQL문을 ()로 묶어주자.
-- 그리고 CREATE VIEW AS 키워드를 추가하자.
CREATE VIEW view_st_dept AS(
    SELECT  st_num 학번, 
            st_name 이름, 
            st_dept 학과코드, 
            d_name 학과, 
            d_pro 담임교수 
    FROM tbl_student st 
    LEFT JOIN tbl_dept dp ON st.st_dept=dp.d_num
);

SELECT * FROM view_st_dept;

SELECT * FROM view_st_dept
         WHERE 학과 LIKE '컴퓨터%';   

SELECT * FROM view_st_dept LEFT JOIN tbl_score sc ON 학번 = sc.s_num; 

-- view_st_dept를 사용해서 학과별로 학생수를 확인하고 학생 수를 기준으로 내림차순 정렬

SELECT 학과, COUNT(학과) FROM view_st_dept GROUP BY 학과;

/*
        1.전체 데이터에서 학과코드 별로 묶어서, 학과 코드가 무엇인지 List
        2.List 내에 포함된 학생수를 계산하여 보기
        => 학과코드별 부분 합(개수)를 계산하기.
*/

-- 학과별로 학생수를 계산을 하고 학생수가 20명 이상인 학과만 조회
-- 집계를 계산한 후 결과에 대한 조건 설정
SELECT 학과, COUNT(학과) FROM view_st_dept GROUP BY 학과 HAVING COUNT(학과)>20;

-- 학과별로 학생수를 계산하고
-- 컴퓨터공학 학과만 보여라

/*
        아래 코드는 둘다 결과값은 같지만 효율을 따지면 무조건 2번째의 SQL문을 사용한다.
*/
SELECT 학과, COUNT(*) FROM view_st_dept GROUP BY 학과 HAVING 학과 = '컴퓨터공학과';

SELECT 학과, COUNT(*) FROM view_st_dept WHERE 학과 = '컴퓨터공학과' GROUP BY 학과;


-- 성적테이블과 학생테이블 JOIN

SELECT * FROM tbl_score sc LEFT JOIN tbl_student st ON sc.s_num=st.st_num;

SELECT s_num, st_name, st_dept, s_kor, s_eng, s_math FROM tbl_score sc LEFT JOIN tbl_student st ON sc.s_num=st.st_num;

CREATE VIEW view_sc_st AS(
    SELECT s_num AS 학번, st_name AS 이름, st_dept AS 학과코드, s_kor AS 국어, s_eng AS 영어, s_math AS 수학 
    FROM tbl_score sc 
    LEFT JOIN tbl_student st ON sc.s_num=st.st_num
);

SELECT * from view_sc_st;

-- 생성된 2개의 view를 JOIN (원하는 결과가 안나옴)
SELECT sc.학번, sc.이름, sc.학과코드, dp.학과, sc.국어, sc.영어, sc.수학 FROM view_sc_st sc LEFT JOIN view_st_dept dp on sc.학과코드 = dp."학과코드";


SELECT * FROM tbl_score sc 
    LEFT JOIN tbl_student st ON sc.s_num=st.st_num 
    LEFT JOIN tbl_dept dp ON st.st_dept=dp.d_num;

SELECT st.st_num, st.st_name, dp.d_name, dp.d_pro, sc.s_kor, sc.s_eng, sc.s_math 
    FROM tbl_score sc 
    LEFT JOIN tbl_student st ON sc.s_num=st.st_num 
    LEFT JOIN tbl_dept dp ON st.st_dept=dp.d_num;
    

CREATE VIEW view_성적일람표 AS(

SELECT  st.st_num AS 학번,
        st.st_name AS 이름,
        dp.d_num AS 학과코드,
        dp.d_name AS 학과이름,
        dp.d_pro AS 담임교수,
        sc.s_kor AS 국어,
        sc.s_eng AS 영어,
        sc.s_math AS 수학,
        sc.s_kor+sc.s_eng+sc.s_math AS 총점,
        ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균,
        RANK() 
        OVER ( ORDER BY (sc.s_kor+sc.s_eng+sc.s_math) DESC) AS 석차
    FROM tbl_score sc 
    LEFT JOIN tbl_student st ON sc.s_num=st.st_num 
    LEFT JOIN tbl_dept dp ON st.st_dept=dp.d_num

);

SELECT * FROM view_성적일람표;

DROP VIEW view_성적일람표;

-- 전체 학생의 과목별 총점

SELECT SUM(국어), SUM(영어), SUM(수학) FROM view_성적일람표;

-- 학과 별로 과목별 총점

SELECT 학과코드, 학과이름, SUM(국어) AS 국어총점, SUM(영어) AS 영어총점, SUM(수학) AS 수학총점 
FROM view_성적일람표 group by 학과코드, 학과이름;

SELECT 학과코드, 학과이름,
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM view_성적일람표
GROUP BY 학과코드, 학과이름;

-- 군사학과와 영어영문학과 학생들의 성적일람표의 집계를 계산

SELECT 학과코드, 학과이름,
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM view_성적일람표
WHERE 학과코드 IN ('002', '005')
GROUP BY 학과코드, 학과이름;

-- WHERE, HAVING으로 어떤 조건을 부여할때는 길이가 가변적인 값으로 조회 하는 것보단
-- 고정된 길이의 값으로 조회하는 것이 결과를 더 확실하게 할 수 있다.


SELECT * FROM view_성적일람표;


-- 학과별 평균 74점 이상인 학과만 표시
-- GROUP으로 묶고 집계를 수행한 결과를 조건으로 설정한 조회
SELECT 학과코드, 학과이름,
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM view_성적일람표
GROUP BY 학과코드, 학과이름
HAVING ROUND(AVG(평균),1)>74;


-- 학과코드가 002부터 004까지 
-- 문자열이지만 데이터의 길이가 모두 같은 경우 관계 연산자를 사용한 범위 조회가 가능하다.
SELECT 학과코드, 학과이름,
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM view_성적일람표
WHERE 학과코드 BETWEEN '002' AND '005' -- WHERE 학과코드 >= '002' AND 학과코드 <= '005'
GROUP BY 학과코드, 학과이름;

SELECT 학과코드, 학과이름
FROM view_성적일람표
GROUP BY 학과코드, 학과이름;






