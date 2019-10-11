-- github에 프로젝트를 업로드 할 때
-- 불필요한 파일이나 비밀번호가 입력된 파일 등
-- 업로드를 하지 않아야될 파일들은
-- git 폴더에 .gitignore 파일을 만들고
-- 파일의 이름, 폴더 이름들을 기록해 주면 된다.
-- test.java 라고 기록을 하면 test.java 파일은 github에 업로드가 되지 않는다.
-- data/라고 기록하면 git 폴더 아래에 data 폴더의 모든 파일을 업로드 하지 않는다.
-- 단, 최초에 프로젝트를 올릴 때, gitignore를 먼저 설정해두어야 한다.
-- 이미 업로드가 된 파일이나 폴더는 삭제하기가 매우 까다롭다.

-- tabl_student 테이블에 데이터를 추가하고, 조회

SELECT * FROM tbl_student;

-- 기존데이터를 삭제하고 추가

DELETE FROM tbl_student;

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel)
VALUES ('A0001', '홍길동', '서울특별시', '010-111-1234');

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel)
VALUES ('A0002', '이몽룡', '익산시', '010-222-1234');

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel)
VALUES ('A0003', '성춘향', '남원시', '010-333-1234');

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel)
VALUES ('A0004', '장길산', '충청남도', '010-444-1234');

INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel)
VALUES ('A0005', '장보고', '해남군', '010-555-1234');

-- 데이터를 추가할때
-- INSERT INTO [table](칼럼리스트)VALUES(값리스트);
-- 칼럼리스트와 값 리스트는 개수와 순서가 일치해야함.
-- 개수가 일치하지 않으면 오류 발생
-- 순서가 일치하지 않으면 다른 칼럼에 값이 들어간다.
INSERT INTO tbl_student(st_num, st_name, st_addr, st_tel)
VALUES ('A0006', '임꺽정', '010-555-1234', '함경도');

-- 1. 모든 데이터를 조건없이 보여라
SELECT * FROM tbl_student;

-- 2. tbl_student에서 학번, 이름, 주소, 전하번호 칼럼만 리스트에 보이면 좋겠다
SELECT st_num, st_name, st_addr, st_tel FROM tbl_student;

-- 3. tbl_student에서 이름,학번,전화번호,주소 순서로 칼럼을 보여주면 좋겠다.
SELECT st_name, st_num, st_tel, st_addr FROM tbl_student;

-- 4. 리스트를 볼때 원래의 칼럼이름 대신에 별명을 사용하자
-- 표준 SQL은 AS 별명 형식으로 사용해야 하지만, 오라클에서는 AS를 생략해도 된다.
-- 다만 표준 SQL을 사용하는 연습을 하는 것이 좋다.
SELECT st_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_addr AS 주소 FROM tbl_student;

-- 4. 리스트를 볼때 원래의 칼럼이름 대신에 별명을 사용하자
SELECT st_num 학번, st_name 이름, st_tel 전화번호, st_addr 주소 FROM tbl_student;

-- 데이터 리스트(row, recored) 중에서 필요한 부분만 보고 싶을 경우
-- 1. tbl_student에 보관중인 데이터중에서 이름이 '홍길동'인 리스트만 보고 싶다.
SELECT * FROM tbl_student WHERE st_name = '홍길동';

SELECT st_num 학번, st_name 이름, st_tel 전화번호 FROM tbl_student WHERE st_name ='홍길동';

-- SELECT 명령문을 사용할때
-- 칼럼리스트를 *로 사용하지 않고 필요한 칼럼만 나열해 주는 것이
-- 많은 양의 데이터를 조회할때 속도면에서 다소 유리하다.
-- 조회를 한 후 특정 칼럼의 값을 응용프로그램에서 사용하려고 할때
-- 위치(index)로 칼럼 값을 추출했을때 정확히 원하는 값이 나오지 않을 수 있다.

-- 학생테이블에서 이름이 홍길동이고 주소가 서울특별시인 데이터만 보고싶다.
SELECT * FROM tbl_student WHERE st_name='홍길동' AND st_addr='서울특별시';

-- OR 조건 : 여러조건중 한가지라도 true인 리스트를 보여라
SELECT * FROM tbl_student WHERE st_name='홍길동' OR st_name='이몽룡';

-- 학생테이블에서 이름이 홍길동 이거나 주소가 서울특별시 인 데이터들을 보고 싶다.
SELECT * FROM tbl_student WHERE st_name='이몽룡' OR st_addr='남원시';

-- 칼럼값들을 서로 연결해서 한개의 문자열처럼 리스트를 보는 방법
SELECT st_num || ' + ' || st_name || ' + ' || st_tel AS 칼럼 FROM tbl_student;

-- 문자열 칼럼에 저장된 값의 일부분만 조건으로 설정하는 방법
-- 데이터를 추가하면서 주소를 어떤 데이터는 '서울특별시' 라고 하고
-- 어떤 데이터는 서울시라고 추가를 했다.
-- 이럴경우 서울특별시라고 조회를 하면 서울시인 데이터는 조회가 되지않는다.
-- 서울시라고 조회를 하면 서울특별시 데이터는 보이지 않게 된다.
-- 이럴때 '서울' 이라는 문자열이 포함된 데이터만 보고 싶을때
-- 부분문자열 조건 조회 라는 방법을 사용한다
-- 이때 사용하는 키워드는 LIKE 이다

SELECT * FROM tbl_student WHERE st_addr LIKE '서울%';
SELECT * FROM tbL_student WHERE st_addr LIKE '%시';
SELECT * FROM tbl_student WHERE st_name LIKE '홍%';
SELECT * FROM tbl_student WHERE st_name LIKE '%길%';

-- SQL에서는 문자열로 설정된 칼럼에 저장된 데이터가
-- 일정한 길이를 가지고 있을때 비교 연산자를 사용하여 값을 조회 할 수 있다.
SELECT * FROM tbl_student WHERE st_tel >= '010-111-0000' AND st_tel <= '010-333-9999';

-- 학생데이터를 조회하고 싶은데
-- 이름은 알지 못하고, 학번이 학번이 3번부터 6번 사이에 있었던 것 같다.
-- 이럴때 학번 데이터는 문자열이지만 저장된 구조가 5자리로 일정하다.
-- 따라서 비교연산자를 사용하여 데이터를 조회해 볼 수 있다.
SELECT * FROM tbl_student WHERE st_num >='A0003' AND st_num <='A0006';

-- 어떤 범위내에 있는 데이터 리스트를 보고자 할 때
-- 학번이 A0003 부터 A0006까지의 범위의 데이터를 보고자 할 때
SELECT * FROM tbl_student WHERE st_num BETWEEN 'A0003' AND 'A0006';

SELECT * FROM tbl_student WHERE st_addr = '익산시' OR st_addr = '남원시' OR st_addr='해남군';

SELECT * FROM tbl_student WHERE st_addr IN('익산시', '남원시', '해남군');

-- 만약 찾고자 하는 데이터의 학번을 알고 있다면
-- 학번으로 조회를 하면 필요한 데이터 1개만 보여주기 때문에
-- 훨씬 업무 처리에 도움이 된다.
SELECT * FROM tbl_student WHERE st_num = 'A0007';

-- DMBS의 임시 저장소에 임시로 저장된 데이터를 storage에 저장하는 명령
-- DCL 명령어이다.
COMMIT;

