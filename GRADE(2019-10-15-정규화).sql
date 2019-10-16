-- GRADE 화면

/*
                DB 이론상 정규화 과정
                
    1.실무에서 사용하던 엑셀 데이터
    ================================================
    학생이름    학년    학과           취미
    ------------------------------------------------
    홍길동       3     컴공과      낚시,등산,독서

    2.엑셀 데이터를 단순히 DBMS의 테이블로 구현
        -만약 취미가 4개인 학생은 4개중에 3개만 선택해야 하는 상황
        -취미가 3개 미만인 학생은 사용하지 않는 칼럼이 있어 낭비되는 상황
    ==============================================================
    학생이름    학년    학과           취미1,     취미2,    취미3
    --------------------------------------------------------------
    홍길동       3     컴공과          낚시       등산      독서
    
    3.제1정규화가 수행된 TABLE 스키마
    ================================================
    학생이름    학년    학과           취미
    ------------------------------------------------
    홍길동       3     컴공과          낚시       
    홍길동       3     컴공과          등산      
    홍길동       3     컴공과          독서
    
    4.제 2정규화
    테이블의 고정값을 다른 테이블로 분리하고
    테이블간의 JOIN을 통해서 VIEW를 생성하도록
    구조적 변경을 하는 작업
    tbl_student
    ================================================
    학생이름    학년    학과           취미
    ------------------------------------------------
    홍길동       3     001             001       
    홍길동       3     001             002      
    홍길동       3     001             003
    
    tbl_hobby
    ================================================
    CODE    취미
    ------------------------------------------------
    001     낚시
    002     등산
    003     독서
    ================================================
    
    tbl_dept
    ================================================
    CODE   학과명  담임교수
    ------------------------------------------------
    001     컴공과
    002     정보통신과
    
*/

/*
DESC tbl_score;
    S_ID      NOT NULL NUMBER        
    S_STD     NOT NULL NVARCHAR2(50) 
    S_SUBJECT NOT NULL NVARCHAR2(50) 
    S_SCORE   NOT NULL NUMBER(3)     
    S_REMARK           NVARCHAR2(50) 
    성적일람표 TABLE의 데이터중에서 과목항목을
    제 2정규화 작업 수행
*/
SELECT s_subject FROM tbl_score GROUP BY s_subject;

-- tbl_score에서 추출된 과목명을 저장할 TABLE 생성
CREATE TABLE tbl_subject(
    s_code	    VARCHAR2(4)		PRIMARY KEY,
    s_subject	nVARCHAR2(20)	NOT NULL,
    s_pro	    nVARCHAR2(20)
);

SELECT * FROM tbl_subject;

-- tbl_score의 s_subject 칼럼에 있는 과목명을 코드로 변경하는 작업을 수행
-- 1. 임시로 칼럼을 하나 tbl_score에 추가
--      tbl_subject에 sb_code 칼럼구조 형식이 같은 칼럼을 추가
ALTER TABLE tbl_score ADD s_sbcode VARCHAR2(4);

SELECT * FROM tbl_score;

UPDATE tbl_score sc 
SET s_sbcode = (SELECT s_code FROM tbl_subject sb WHERE sc.s_subject = sb.s_subject);

SELECT SC.s_sbcode, SB.s_code, sc.s_subject, sb.s_subject 
FROM tbl_score SC, tbl_subject SB WHERE SC.s_sbcode = sb.s_code;


-- tbl_score의 s_subject 칼럼을 삭제
ALTER TABLE tbl_score DROP COLUMN s_subject;

-- tbl_score의 s_sbcode 칼럼을 s_subject로 이름 변경
ALTER TABLE tbl_score RENAME COLUMN s_sbcode TO s_subject;

DESC tbl_score;

-- 제2정규화 완료

SELECT * FROM tbl_score LEFT JOIN tbl_subject ON tbl_subject.s_code = tbl_score.s_subject;

SELECT * FROM tbl_score WHERE s_id=601;

DELETE FROM tbl_score WHERE s_id>600;

COMMIT;





