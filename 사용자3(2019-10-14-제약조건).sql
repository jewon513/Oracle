-- USER3 화면입니다.

-- 테이블 구조를 조회
DESC tbl_student;

-- tbl_student 테이블을 테스트 하기 위해 원본 테이블을 손상시키지 않고 복제하겠다.

CREATE TABLE tbl_test_std
AS 
SELECT * FROM tbl_student;

SELECT * FROM tbl_test_std;

DESC tbl_student;
/*
ST_NUM   NOT NULL VARCHAR2(3)    PRIMARY KEY
ST_NAME  NOT NULL NVARCHAR2(50)  
ST_TEL            VARCHAR2(3)    
ST_ADDR           NVARCHAR2(125) 
ST_GRADE          NUMBER(1)      
ST_DEPT           VARCHAR2(3)    
*/

DESC tbl_test_std;
/*
ST_NUM            VARCHAR2(3)    
ST_NAME  NOT NULL NVARCHAR2(50)  
ST_TEL            VARCHAR2(3)    
ST_ADDR           NVARCHAR2(125) 
ST_GRADE          NUMBER(1)      
ST_DEPT           VARCHAR2(3)    

*/

/*
    테스트를 위해서
    tbl_student 테이블을 tbl_test_std 테이블로 똥짜 복제를 했는데
    테이블을 복제하면, 데이터 형식, 데이터들 그리고 NOT NULL 등 일부는 그대로 복제가 되는데
    PK 등 중요한 제약조건들은 무시되고 복제가 되지 않는다.
    따라서 복제된 테이블에 제약조건을 추가해야 한다. 
    
    또는
    테이블을 생성할 당시에는 제약조건들이 필요하지 않아서
    작성하지 않았는데 나중에 사용하다 보니 제약조건들이 필요한 경우가 생겨서
    테이블을 새로 작성하지 않고 제약조건들만 추가하는 방법
    
    1. NOT NULL 제약조건
        칼럼에 값이 없으면 INSERT가 실행되지 않도록 하는 제약조건
        
    2. UNIQUE 제약조건
        칼럼에 중복값이 추가되지 않도록 하는 제약조건
        
    3. PRIMARY KEY 제약조건
        데이터가 없거나, 중복된 값을 추가하지 못하며, 해당 칼럼은 PK로 설정된다.
        PK로 설정된 칼럼은 내부적으로 자동으로 INDEX 라는 OBJECT가 생성된다.
        DMBS에 따라 이름을 지정하지 않으면 실행이 안되는 경우도 있다.
        
        경우에 따라 PK를 다중칼럼으로 설정하는 경우도 있다.
        
    4. UNIQUE 제약조건을 삭제
    
    5. CHECK 제약조건
        데이터를 추가할때 어떤칼럼에 저장되는 데이터를 제한하고자 할때
*/
DROP TABLE tbl_test_std;
--1
ALTER TABLE tbl_test_std MODIFY(st_name NOT NULL);

--2
ALTER TABLE tbl_test_std MODIFY(st_name UNIQUE);

--3
ALTER TABLE tbl_test_std MODIFY(st_num PRIMARY KEY);
ALTER TABLE tbl_test_std ADD CONSTRAINT KEY_ST_NUM PRIMARY KEY(ST_NUM);

--4
ALTER TABLE tbl_test_std DROP UNIQUE(st_num);

DESC tbl_test_std;

--5
--st_grade 칼럼에 값을 1부터 4까지 범위의 숫자만 저장하라
--그리고 그 제약조건 이름을 st_GRADE_CHECK라고 등록하라.
ALTER TABLE tbl_test_std ADD CONSTRAINT ST_GRADE_CHECK CHECK (st_grade BETWEEN 1 AND 4);

-- CONSTRAINT 이름을 지정하는 이유
-- 이름이 지정되지 않으면 나중에 조건이 필요 없어서 삭제를 하고자 할때 삭제가 어려워진다.

--6 CHECK 제약조건 삭제
--  st_grade_check 이름으로 등록된 제약조건 삭제
--  cascade는 연관된 모든 조건들을 같이 삭제하라.
ALTER TABLE tbl_test_std DROP CONSTRAINT st_grade_check CASCADE;

--7 참조 무결성 설정
--  tbl_score2에 데이터를 추가하거나 학번을 변경할 때
-- tbl_test_Std 테이블을 참조하져
-- 학번(s_num,st_num)과의 관계를 명확히 하여
-- EQ JOIN을 실행 했을때 결과의 신뢰성을 보장하는 조건 설정
ALTER TABLE tbl_score2
ADD CONSTRAINT fk_std_score2 FOREIGN KEY (s_num) REFERENCES tbl_test_std(st_num);


