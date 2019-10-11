-- 여기는 관리자 화면입니다.

-- 새로운 tablespace를 생성

-- 이름 : user3_db

-- datafile : /bizwork/oracle/data/user3.dbf

-- 초기크기 : 10MB

-- 자동학장 : 1KB

CREATE TABLESPACE user3_db DATAFILE '/bizwork/oracle/data/user3.dbf' SIZE 10M AUTOEXTEND ON NEXT 1K;

-- 개념 Schema => DBMS 차원에서 바라본 Schema, 논리적인 개념으로 TAble 등과 같은 저장소 Object를 모아놓은 그룹

-- Oracle 에서는 User가 개념 Schema 역할을 수행한다.


-- 새로운 user를 생성

-- ID : user3
-- PW : 1234
-- default tablespace user3_db

CREATE USER user3 IDENTIFIED BY 1234 DEFAULT TABLESPACE user3_db;

-- 생성된 user3에게 DB 접근 권한을 부여한다.
-- 학습의 편의성을 위해 DBA 권한을 부여한다

GRANT DBA TO user3;