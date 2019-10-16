-- 여기는 관리자 화면 입니다.
/*
        TABLESPACE 생성
        이름 : grade_db
        데이터 파일 : C:/bizwork/Oracle/data/grade.dbf
        초기 사이즈 : 10M
        자동증가 옵션 : 10KB
*/

CREATE TABLESPACE grade_db
DATAFILE 'C:/bizwork/Oracle/data/grade.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;

/*
        사용자 생성 : 스키마생성(TABLE을 관리하는 주체)
        ID : grade
        PW : grade
        권한 : DBA
        DEFALUT TABLESPCAE : grade_db
*/

CREATE USER grade IDENTIFIED BY grade
DEFAULT TABLESPACE grade_db; 

GRANT DBA to grade;

-- 사용자의 비밀번호를 변경
ALTER USER grade IDENTIFIED BY grade;

SELECT * FROM ALL_USERS;
