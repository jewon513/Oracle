-- 여기는 USER3 화면입니다.
SELECT * FROM v$database; -- 오라클 전용 System 쿼리, 현재 사용중인 DBMS 엔진의 전역적(전체적인) 명칭, 정보를 확인하는 SQL문

SELECT * FROM TAB; -- 현재 사용자가 접근(CRUD) 할 수 있는 TABLE 목록을 확인

SELECT * FROM ALL_TABLES; -- DBA급 이상의 사용자가 전체 테이블 리스트를 확인

SELECT * FROM tbl_books;

DESC tbl_books; --tbl_books의 테이블 구조(CREATE TABLE을 했을 때의 모양)

SELECT * FROM user_tables; -- SELECT * FROM TAB과 거의 유사한 형태, 사용자의 권한에 따라 from tab과 다른 리스트가 출력되기도 한다.