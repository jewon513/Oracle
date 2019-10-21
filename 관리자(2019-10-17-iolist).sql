-- 여기는 관리자 화면 입니다.

-- 매입매출 관리를 수행할 TABLESPACE, USER 생성

/*
    TABLESPACE를 생성
    이름 : iolist_db
    파일 : 'C:/bizwork/Oracle/data/iolist.dbf'
    초기사이즈 : 50MB
    자동확장 : AUTO 10KB
*/

CREATE TABLESPACE iolist_db
DATAFILE 'C:/bizwork/Oracle/data/iolist.dbf'
SIZE 50M AUTOEXTEND ON NEXT 10K;

/*
    사용자 생성
    ID : iolist
    PW : iolist
    권한 : DBA
    DEFAULT TABLESAPCE : iolist_db

*/

CREATE USER iolist IDENTIFIED BY iolist
DEFAULT TABLESPACE iolist_db;

GRANT DBA TO iolist;

