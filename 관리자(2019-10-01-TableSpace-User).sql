-- 여기는 관리자 화면입니다.

-- TableSpace를 생성하고, 새로운 사용자를 생성

-- 관리자 계정으로 접속된 상태에서 TableSpace, User 등 생성을 한다

-- 이때 사용하는 언어를 DDL이라고 한다.

-- USER2_DB라는 이름으로 tableSpace를 생성하고
-- 실제 데이터가 저장되는 곳은 C:/bizwork/Oracle/data 폴더에
-- user2.dbfr 라는 파일로 생성을 하고 초기 크기는 10MB이고 용량이 부족하면 10KB 증가한다.
CREATE TABLESPACE USER2_DB 
DATAFILE 'C:/bizwork/Oracle/data/USER2.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;

-- 생성한 USER2-DB 테이블 스페이스에 데이터를 관리할 사용자 계정을 생성
-- USER2라는 ID로 새로운 사용자를 생성하고 임시 비밀번호를 1234로 설정 하겠다.
-- USER2가 table을 생성하고 데이터를 저장할때 USer2_DB tablespace를 사용하도록 지정

-- 만약 defalut tablespace를 지정하지 않으면 user2 사용자가 table를 생성하고 데이터를 저장할 때
-- 그 데이터들은 오라클 DBMS의 SYSTEM 영역에 저정을 한다.
-- 작은 규모의 프로젝트에서는 큰 문제가 없으나 실무에서는 매우 좋지 않은 방법이다.
CREATE USER USER2 IDENTIFIED BY 1234
DEFAULT TABLESPACE USER2_DB;

-- 오라클에서는 새로운 사용자 계정을 등록했을때
-- 아무런 활동(명령실행등..)을 할 수 없는 상태이다.
-- DCL 명령을 통해서 사용자에게 권한을 부여 해야 하는데
-- 11gEX 환경에서는 외부접속으로 인한 보안 문제가 크지 않으므로
-- 일단 DBA권한을 사용자에게 부여한다.
-- 실습에 편의성을 위함이다.

-- USER2에게 DBA권한을 부여한다
-- DBA 권한
-- SYSTEM에 관련된 정보를 조회할 수 있는 권한이 있다.
-- DDL 명령을 활용하여 자신의 영역에 TABLE을 생성, 삭제, 변경 할 수 있는 권한이 있다.
-- DML 명령을 활용하여 데이터 관리(조작)이 가능하다.
GRANT DBA TO USER2;