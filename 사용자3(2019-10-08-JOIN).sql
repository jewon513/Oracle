-- 여기는 USER3 화면입니다

-- JOIN은 보통 2개 이상의 테이블에 나뉘어서 보관중인 데이터를 서로 연계해서 하나의 리스트처럼 출력하는 SQL 명령 형태

-- EQ, 완전, 내부조인
-- 두 테이블에 연계된 칼럼이 모두 존재할 경우
-- 두 테이블간에 완전 참조 무결성이 보장되는 경우
-- 이 조인이 표시하는 리스트를 카티션곱이라고 표현한다.

SELECT * FROM tbl_books B, tbl_genre G 
WHERE b.b_genre=g.g_code;

-- EQ 조인의 경우
-- 두 테이블이 완전 참조 무결성 조건에 위배되는 경우 신뢰성을 잃는다.

/*
                    참조 무결성

|---------------------------------------------------|
|    원본Table           =             참조Table    |
|---------------------------------------------------|
| 값이 있다              >        반드시 값이 있다. |
| 있을 수도 있다.        <        값이 있다.        |
| 절대 있을 수 없다      <        값이 없다.        |
|---------------------------------------------------|
참조 무결성 조건은 테이블간에 EQ JOIN을 실행했을 때 결과의 신뢰성을 보장하는 조건이다.

*/

-- 두 테이블 간에 참조 무결성을 무시하고 JOIN 실행하기
-- 새로운 도서가 입고가 되었는데, 그 동안에 사용하던 장르와 완전 다른 분야이다
-- 그래서 새로운 장르코드를 생성해서 010 이라고 사용하기로 했다.
INSERT INTO tbl_books(b_isbn, b_title, b_comp, b_writer, b_genre)
VALUES ('979-008','아침형인간','하늘소식','이몽룡','010');

SELECT * FROM tbl_books B, tbl_genre G 
WHERE b.b_genre=g.g_code;

-- 만약 tbl-books 테이블하고, tbl_genre 테이블간에 참조무결성 조건을 설정해 두었더라면
-- tbl_books 테이블에는 INSERT를 수행하지 못한다.
-- 하지만, 아직 참조무결성 조건을 설정하지 않았기 때문에 INSERT가 가능하다.

-- 그 결과 EQ JOIN으로 확인해보니 새로 등록한 도서리스트가 누락되어 출력이 되었다.
-- 이제 출력 출력결과는 신뢰성을 잏게 되었다.
-- 이런 상황이 발생했을 경우
-- 참조무결성을 무시하고 (일부) 신뢰성이 있는 리스트를 보기 위해서 다른 JOIN을 수행한다.

-- LEFT JOIN
-- LEFT에 있는 table의 리스트는 모두 보여주고 ON 조건에 일치하는 값이 오른쪽의 table에 있으면 값을 보이고,
-- 그렇지 않으면 (null)로 표현하라.
SELECT * FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code ORDER BY b_isbn;

-- tbl__books 테이블의 b_title 칼럼의 값이 '아침형인간' 리스트를 보여주는데 만약 b_genre 칼럼값과 일치하는 값이 tbl_genre의 g_code 칼럼에 있으면
-- 리스트를 보여주고 그렇지 않으면 (null)이라고 표현한다.
SELECT * FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code WHERE B.b_title = '아침형인간';

SELECT b_isbn, b_title AS 제목, b_comp AS 출판사, b_writer AS 저자, g_code AS 장르코드, g_name AS 장르 FROM tbl_books LEFT JOIN tbl_genre ON b_genre = g_code;

SELECT * FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code WHERE g_name = '장편소설';

SELECT * FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code ;

UPDATE tbl_genre SET g_name = '장르소설' WHERE g_code='003';

SELECT * FROM tbl_genre;

SELECT * FROM tbl_books B LEFT JOIN tbl_genre G ON B.b_genre = G.g_code ;

--DB에서는 2개 이상의 레코드가 변경되는 실행문은 지양해야 하고, 그래야만 데이터의 무결성을 유지 할 수 있다.
--다라서 테이블을 분리하여 관리하고, JOIN을 이용하여 TABLE을 출력한다.

