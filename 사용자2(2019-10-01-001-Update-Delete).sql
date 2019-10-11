-- 여기는 USER2 화면입니다.
-- UPDATE, DELETE 명령

-- 새로운 사용자가 사용할 TABLE을 생성
-- 주소록 테이블을 생성

CREATE TABLE tbl_address (
    st_name nVARCHAR2(20) NOT NULL,     --이름은 반드시 있어야한다.
    st_tel VARCHAR2(20) NOT NULL,       --전화번호도 반드시 있어야한다.
    st_addr nVARCHAR2(125),
    st_chain nVARCHAR2(10),
    st_rem nVARCHAR2(125),
    st_birth VARCHAR2(10),
    st_age NUMBER(3)
);

DROP TABLE tbl_addres;

INSERT INTO tbl_address (st_name, st_tel)
VALUES ('홍길동', '서울특별시');

INSERT INTO tbl_address (st_name, st_tel)
VALUES ('이몽룡', '익산시');

INSERT INTO tbl_address (st_name, st_tel)
VALUES ('성춘향', '남원시');

INSERT INTO tbl_address (st_name, st_tel)
VALUES ('장길산', '부산광역시');

INSERT INTO tbl_address (st_name, st_tel)
VALUES ('임꺽정', '함경남도');

COMMIT;

SELECT * FROM tbl_address;

--UPDATE
UPDATE tbl_address 
set st_addr = '서울특별시';

SELECT * FROM tbl_address;

-- 데이터의 추가, 수정, 삭제를 취소하는 명령
-- DCL 명령
ROLLBACK;

SELECT * FROM tbl_address;

-- UPDATE 명령을 기본형으로 수행을 하게 되면 모든 Record 값이 변경되어 버리는 사태가 발생
UPDATE tbl_address
SET st_addr = '서울특별시'
WHERE st_name = '홍길동';

UPDATE tbl_address
SET st_addr = '익산시'
WHERE st_name = '성춘향';

UPDATE tbl_address
SET st_addr = '남원시'
WHERE st_name = '이몽룡';

COMMIT;

SELECT * FROM tbl_address;

UPDATE tbl_address
SET st_addr = '익산시'
WHERE st_addr = '이몽룡';

UPDATE tbl_address
SET st_addr= '남원시'
WHERE st_name = '성춘향';

INSERT INTO tbl_address (st_name, st_tel)
VALUES ('홍길동', '서울특별시');

SELECT * FROM tbl_address;

DROP TABLE tbl_address;

CREATE TABLE tbl_address (
    id NUMBER PRIMARY KEY,
    name nVARCHAR2(20) NOT NULL,     --이름은 반드시 있어야한다.
    tel VARCHAR2(20) NOT NULL,       --전화번호도 반드시 있어야한다.
    addr nVARCHAR2(125),
    chain nVARCHAR2(10),
    rem nVARCHAR2(125),
    birth VARCHAR2(10),
    age NUMBER(3)
);

INSERT INTO tbl_address(id ,name, tel)
VALUES (1, '홍길동', '서울특별시');

INSERT INTO tbl_address(id ,name, tel)
VALUES (2, '홍길동', '서울특별시');

INSERT INTO tbl_address(id ,name, tel)
VALUES (3, '홍길동', '서울특별시');

INSERT INTO tbl_address(id ,name, tel)
VALUES (4, '이몽룡', '남원시');

INSERT INTO tbl_address(id ,name, tel)
VALUES (5, '성춘향', '익산시');

SELECT * FROM tbl_address;

UPDATE tbl_address
SET addr = '서울특별시'
WHERE id =1;

UPDATE tbl_address 
SET addr = '광주광역시'
WHERE id =2;

UPDATE tbl_address
SET addr = '부산광역시'
WHERE id =3;

COMMIT;

-- DBMS를 운영하는 과정에서
-- 만에 하나 재난이 발생했을때
-- 데이터를 복구할 수 있는 준비를 해야한다.
-- 1. 백업 : 업무가 종료된 후 데이터를 다른 저장소, 저장매체에 복사하여 보관하는 것
--    복구 : 백업해둔 데이터를 사용중인 시스템에 다시 설치하여 사용할 수 있도록 하는 것

-- 2. 로그 기록 : INSERT, UPDATE, DELETE 명령이 수행 될때
--                수행되는 모든 명령들을 별도의 파일로 기록해 두고
--                문제가 발생했을 때 로그를 다시 역으로 추적하여 복구하는 방법 (저널링 복구)

