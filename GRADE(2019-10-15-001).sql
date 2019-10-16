-- 여기는 GRADE 화면 입니다.

/*
        PK 지정방법을 칼럼에 PRIMARY KEY를 지정하지 않고
        별도로 CONSTRAINT 추가 방식으로 지정을 했다
        표준 SQL에서는 PK 지정방식을 칼럼에 PRIMARY KEY 직접 지정하는데
        간혹 표준 SQL의 PK 지정방식이 안되는 DBMS가 있다.
        이때는 별도의 CONSTRAINT 추가 방식으로 지정해야한다.
        이 방식은 다수의 칼럼으로 PK를 지정할때도 사용한다.
*/

CREATE TABLE tbl_score(
    s_id	        NUMBER,
    s_std	        nVARCHAR2(50)	NOT NULL,	
    s_subject	    nVARCHAR2(50)	NOT NULL,	
    s_score	        NUMBER(3)	    NOT NULL,	
    s_remark	    nVARCHAR2(50),	
    CONSTRAINT pk_socre PRIMARY KEY(s_id)
);

DESC tbl_score;

/*
        엑셀데이터를 IMPORT 했다  
*/

SELECT COUNT(*) FROM tbl_score;

SELECT * FROM tbl_score ORDER BY s_id;

/*
        학생별로 총점, 평균을 계산
    1. 학생(s_std) 데이터가 같은 레코드들끼리 묶기 (GROUP BY s_std)
    2. 묶어진 그룹 내에서 s_score의 총점을 구하고 s_score의 평균을 구한다.
*/
SELECT s_std, sum(s_score) AS 총점, ROUND(avg(s_score),0) AS 평균 FROM tbl_score GROUP BY s_std ORDER BY s_std;

/*
    학생이름        과목      점수      형식으로 저장된 데이터를
    학생이름        국어  영어  수학  과학  형식으로 펼처서 보고자 한다.
*/
-- 1. 먼저 어떤 과목들이 있는지 확인한다.
SELECT s_subject FROM tbl_score GROUP BY s_subject;

/*
        과학, 수학, 국어, 미술, 국사, 영어 가 있음을 확인 했다.
*/

/*
        성적테이블을 생성 할때 각 과목이름으로 칼럼을 만들어서 생성을 하면 데이터를 추가하거나, 단순 조회를 할 때는 상당히
        편리하게 사용할 수 있다. 하지만, 사용중에 과목이 추가되거나 과목명이 변경되는 경우 테이블의 칼럼을 변경해야 하는 상황이 발생된다.
        테이블의 칼럼을 변경하는 것은 DBMS 입장에서나 사용자 입장에서 많은 비용(사용중지 시간, 노력, 위험성 등)을 지불해야 한다.
        테이블의 칼럼을 변경하는 일은 매우 신중해야 한다.
        
        그래서 실제 데이터는 고정된 칼럼으로 생성된 테이블에 저장을 하고 View로 확인을 할 때 PIVOT 방식으로 펼쳐 보면 마치 실제 테이블의
        칼럼이 존재하는 것처럼 사용을 할 수 있는 장점이 있다.
*/
SELECT s_std AS 학생,     SUM(DECODE(s_subject,'과학',s_score)) 과학,
                        SUM(DECODE(s_subject,'국사',s_score)) 국사,
                        SUM(DECODE(s_subject,'국어',s_score)) 국어,
                        SUM(DECODE(s_subject,'미술',s_score)) 미술,
                        SUM(DECODE(s_subject,'수학',s_score)) 수학,
                        SUM(DECODE(s_subject,'영어',s_score)) 영어
            FROM tbl_score
            GROUP BY s_std
            ORDER BY s_std;

/*
        오라클 11g 이후에 사용하는 PIVOT 문법
        SQL Develover에서 명령수행에 제한이 있다.
        MAIN FROM 절에 서브쿼리를 사용해서 테이블을 지정해야 한다.
*/
SELECT * FROM
    (SELECT s_std, s_subject, s_score FROM tbl_score)
PIVOT (
    SUM(s_score) -- 칼럼이름별로 분리하여 표시할 데이터
    FOR s_subject -- 묶어서 펼칠 칼럼 이름
    IN( '과학' AS 과학, -- 펼쳤을때 보여질 칼럼 이름 목록
        '수학' AS 수학, 
        '국어' AS 국어, 
        '미술' AS 미술, 
        '국사' AS 국사, 
        '영어' AS 영어   )
    );

CREATE VIEW view_score AS(

SELECT s_std AS 학생,     SUM(DECODE(s_subject,'과학',s_score)) 과학,
                        SUM(DECODE(s_subject,'국사',s_score)) 국사,
                        SUM(DECODE(s_subject,'국어',s_score)) 국어,
                        SUM(DECODE(s_subject,'미술',s_score)) 미술,
                        SUM(DECODE(s_subject,'수학',s_score)) 수학,
                        SUM(DECODE(s_subject,'영어',s_score)) 영어,
                        SUM(s_score) AS 총점,
                        ROUND(AVG(s_score),0) AS 평균,
                        RANK() OVER (ORDER BY SUM(s_score) DESC) AS 석차
            FROM tbl_score
            GROUP BY s_std
);

SELECT * FROM view_score ORDER BY '학생';
            
            
