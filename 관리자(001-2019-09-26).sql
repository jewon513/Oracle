-- SQL 명령문들을 사용해서 DBMS 학습을 진행
-- 오라클 11g의 명령세트를 학습할 예정
-- 현재 최신 오라클은 19c 18c인데 현업에서 사용하는 오라클은 하위버전이기 때문에 11g 위주의 명령세트를 학습하게 된다.

-- 마이그레이션 : 하위버전에서 사용하던 데이터베이스(물리적 Storage에 저장된 데이터)를 상위버전 또는 다른회사의 DMBS에서 사용할 수 있도록 변환, 변경, 이전 하는 것들

-- 오라클 DMBS SW(오라클DB, 오라클)를 이용해서 DB관리를 명령어를 연습하기 위해서
-- 연습용 데이터저장공간을 생성한다.
-- 오라클에서는 storage에 생성한 물리적 저장공간을 TableSpace라고 한다.
-- 기타 MySQL,이나 MSSQL 등등의 DBMS SW들은 물리적 저장공간을 DATABASE라고 한다.

-- DDL명령어를 사용해서 TableSpace를 생성한다.
-- DDL명령어를 사용하는 사용자는 DBA이다.


-- DDL 명령에서 "생성한다" ==>> CREATE
-- 물리schema를 생선한다라는 의미가 된다.
--CREATE TABLESPACE; --TABLESPACE를 생성하기
--CREATE USER; --새로운 접속사용자를 생성하기
--CREATE TABLE; --구체적인 데이터를 저장할 공간을 생성하기


-- DDL 명령에서 "삭제,제거한다" ==>> DROP
-- DDL 명령에서 "변경" ==>> ALTER


-- C:\bizwork\Oracle\data
-- C:/bizwork/Oracle/data


-- 'C:/bizwork/Oracle/data/USER1.dbf' 파일 이름으로 물리적 저장소를 생성한다.
-- 그 저장소의 이름은 앞으로 user1_DB라고 사용하겠다
-- 초기 사이즈를 100M(byte)로 설정하라
CREATE TABLESPACE user1_DB
DATAFILE 'C:/bizwork/Oracle/data/USER1.dbf'
SIZE 100M;

DROP TABLESPACE user1_DB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

CREATE TABLESPACE user1_DB
DATAFILE 'C:/bizwork/Oracle/data/USER1.dbf'
SIZE 100M AUTOEXTEND ON NEXT 100K;

-- 현재 이 화면에서 명령을 수행하는 사용자는 SYSDBA 권한을 가진 사람이다.
-- SYSDBA 권한은 System DB등을 삭제하거나 변경할 수 있기 때문에 
-- 실습환경에는 가급적 꼭 필요한 명령 외에는 사용하지 않는 것이 좋다.

-- 실습을 위해서 새로운 사용자를 생성하자.


