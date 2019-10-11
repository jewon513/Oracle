-- 여기는 USER3 화면입니다.

CREATE TABLE tbl_books (
    b_isbn	VARCHAR2(13)		PRIMARY KEY,
    b_title	nVARCHAR2(50)	NOT NULL,
    b_comp	nVARCHAR2(50)	NOT NULL,	
    b_writer	nVARCHAR2(50)	NOT NULL,	
    b_price	NUMBER(5),		
    b_year	VARCHAR2(10),		
    b_genre	VARCHAR2(3)
);

INSERT INTO tbl_books (b_isbn,b_title,b_comp,b_writer,b_price)
VALUES ('979-001','오라클 프로그래밍', '생능출판사', '서진수', 30000);

INSERT INTO tbl_books (b_isbn,b_title,b_comp,b_writer,b_price)
VALUES ('979-002','Do it 자바','이지스퍼블리싱', '박은종', 25000);

INSERT INTO tbl_books (b_isbn,b_title,b_comp,b_writer,b_price)
VALUES ('979-003','SQL 활용', '한국교육부', '교육부', 10000);

INSERT INTO tbl_books (b_isbn,b_title,b_comp,b_writer,b_price)
VALUES ('979-004','무궁화꽃이 피었습니다.', '새움', '김진명', 15000);

INSERT INTO tbl_books (b_isbn,b_title,b_comp,b_writer,b_price)
VALUES ('979-005','직지', '쌤앤파커스', '김진명', 12600);

SELECT * FROM tbl_books;

-- tbl_books 테이블을 생성하고 데이터를 추가하다보니 가격 칼럼의 자릿수가 부족하여 10만원 이상의 데이터를 추가할 수 없다.
-- 데이터를 추가하기 전이라면 table을 삭제하고 생성하면 되겠지만 이미 데이터가 추가되어 있는 상황에서 칼럼의 자릿수를 변경하고 싶다.

--DDL의 3대 키워드
-- 생성 :CREATE
-- 삭제 :DROP
-- 변경 :ALTER

ALTER TABLE tbl_books MODIFY (b_price NUMBER(7));

INSERT INTO tbl_books (b_isbn,b_title,b_comp,b_writer,b_price)
VALUES ('978-802', 'effective java', 'Addison', 'Joshua Bloch', 159000);

SELECT * FROM tbl_books;

-- 테이블을 처음 생성할 당시에 미처 생각지 못한 칼럼이 필요한 경우 이미 생성된 테이블에 새로운 칼럼을 추가하기

ALTER TABLE tbl_books ADD (b_remark nVARCHAR2(125));

DESC tbl_books;
SELECT * FROM tbl_books;

-- 기존의 칼럼을 삭제
ALTER TABLE tbl_books DROP COLUMN b_remark;

-- 칼럼의 이름을 변경
ALTER TABLe tbl_books RENAME COLUMN b_remark to b_rem;

-- ALTER TABLE 명령을 수행할 때 매우 주의해야 할 사항

-- DROP COLUMN
-- 기존에 사용하던 table에서 칼럼을 삭제해버리면 저장된 데이터가 변형되어 문제가 발생할 수 있다.

-- MODIFY 
-- 칼럼의 타입을 변경하는 것으로 저장된 데이터가 변형될 수 있다.
-- 자릿수를 줄이면 보통 실행 오류가 발생한다.
-- 타입을 변경하면 기존 데이터의 형식이 변경되면서 데이터가 손실되거나 소실될 수 있다.
-- 특히 CHAR 형과 VARCHAR2 형 사이에서 데이터 타입을 변경하면 기존의 SQL(SELECT) 명령 결과가 전혀 다르게 나타나거나
-- 데이터를 못 찾을 수 있다.

-- RENAME COLUMN
-- 칼럼의 이름을 변경하는 것은 데이터의 변형이 잘 일어나지는 않지만
-- 다른 SQL 명령문이나, 내장 프로시져, Java 프로그래밍에서 table에 접근하여 데이터를 CRUD 할때 문제가 발생 할 수 있다.

-- 보통 테이블을 생성하거나 칼럼을 추가한 후로는 필요 없더라도 다른 문제가 없으면 DROP, MODIFY 등을 수행하지 말자.


-- 사용자의 비밀번호를 변경하기
-- 사용자 비밀번호는 보통 자신의 비밀번호를 변경하고, 
-- (SYS)DBA 역할에서는 다른 user의 비밀번호를 변경하기도 한다.

ALTER USER user3 IDENTIFIED BY 1234;

CREATE TABLE tbl_genre (
    g_code	VARCHAR2(3)		PRIMARY KEY,
    g_name	nVARCHAR2(15)	NOT NULL,
    g_remark	nVARCHAR2(125)		
);

INSERT INTO tbl_genre(g_code, g_name)
VALUES('001','프로그래밍');

INSERT INTO tbl_genre(g_code, g_name)
VALUES('002','데이터베이스');

INSERT INTO tbl_genre(g_code, g_name)
VALUES('003','장편소설');

SELECT * FROM tbl_genre;

DESC tbl_books;
ALTER TABLE tbl_books MODIFY (b_genre nVARCHAR2(10));

-- 현재 book 테이블에 추가된 데이터들의 장르칼럼이 비어있는 상태
-- 장르칼럼의 데이터를 채워 넣기

SELECT * FROM tbl_books;

-- UPDATE는 PK로 WHERE절에 설정하여 사용.

UPDATE tbl_books SET b_genre = '데이터베이스' WHERE b_isbn = '979-001';
UPDATE tbl_books SET b_genre = '데이터베이스' WHERE b_isbn = '979-003';
UPDATE tbl_books SET b_genre = '장편소설' WHERE b_isbn = '979-004';
UPDATE tbl_books SET b_genre = '프로그래밍' WHERE b_isbn ='979-002';
UPDATE tbl_books SET b_genre = '장편소설' WHERE b_isbn = '979-005';
UPDATE tbl_books SET b_genre = '프로그래밍' WHERE b_isbn ='978-802';

SELECT * FROM tbl_books;

SELECT * FROM tbl_books WHERE b_genre = '데이터베이스';

SELECT * FROM tbl_books WHERE b_genre = '장르소설';

SELECT * FROM tbl_books WHERE b_genre = '프로그래밍';

-- books 테이블의 테이터 중에 장르가 장편소설인 데이터를 '장르소설'로 바꾸고 싶다.
UPDATE tbl_books SET b_genre = '장르소설' WHERE b_genre = '장편소설';

INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_price, b_genre)
VALUES ('979-006','황태자비 납치사건', '새움','김진명', 25000, '장르소설');

SELECT * FROM tbl_books;

-- 1. tbl_books 테이블의 장르 칼럼에 저장된 문자열을 tbl_genre 테이블에 있는 코드 값으로 변경
SELECT * FROM tbl_books WHERE b_genre = '데이터베이스';
UPDATE tbl_books SET b_genre = '002' WHERE b_genre ='데이터베이스';

SELECT * FROM tbl_books;

UPDATE tbl_books SET b_genre = '001' WHERE b_genre = '프로그래밍';

UPDATE tbl_books SEt b_genre = '003' WHERE b_genre = '장르소설';

-- 도서정보를 확인하면서 장르칼럼의 코드값 대신에 장르 이름으로 보고싶다.

-- 테이블의 JOIN
-- 2개 이상의 테이블을 서로 연계해서 하나의 리스트로 보여주는 것
-- Relation Ship
SELECT * FROM tbl_books, tbl_genre WHERE tbl_books.b_genre = tbl_genre.g_code;

SELECT tbl_books.b_isbn, tbl_books.b_title, tbl_books.b_comp, tbl_books.b_writer, tbl_books.b_genre, tbl_genre.g_name
FROM tbl_books, tbl_genre WHERE tbl_books.b_genre = tbl_genre.g_code;


-- TABLE 명에 Alias 를 설정하는 방법
SELECT B.b_isbn, B.b_title, B.b_comp, B.b_writer, B.b_genre, G.g_name
FROM tbl_books B, tbl_genre G 
WHERE B.b_genre = G.g_code;

INSERT INTO tbl_books (b_isbn, b_title, b_comp, b_writer, b_genre)
VALUES ('979-007', '자바의 정석', '도울출판','남궁성','004');

SELECT *
FROM [table1], [table2]
WHERE table.col = table.2col;

-- 완전 JOIN, EQ JOIN 이라고 하며 결과를 카티션 곱이라고 표현한다.
-- TALBE1과 TABLE2를 Relation 할때 서로 연결하는 칼럼의 값이 두 테이블에 모두 존재할때 정상적으로 결과가 나온다.

