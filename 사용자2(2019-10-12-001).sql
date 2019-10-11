-- 여기는 USER2 화면입니다.

SELECT * FROM tbl_address;

UPDATE tbl_address SET age =33
WHERE id = 5;

UPDATE tbl_address SET age = 0
WHERe id = 4;

SELECT * FROM tbl_address WHERE age IS NULL;

SELECT * FROM tbl_address
WHERE age IS NOT NULL;

-- 오라클에서는 ''(중간에 빈칸 등 아무런 값이 없는 형태)는 NULL과 같은 의미로 본다.
UPDATE tbl_address SET chain=''
WHERE id = 3;

UPDATE tbl_address SET chain=' '
WHERE id = 3;

SELECT * FROM tbl_address;

SELECT * FROM tbl_address WHERE addr IS NULL;
SELECT * FROM tbl_address WHERE addr IS NOT NULL;
SELECT * FROM tbl_address;

UPDATE tbl_address SET chain='001' WHERE id = 1;
UPDATE tbl_address SET chain='001' WHERE id = 2;
UPDATE tbl_address SET chain='002' WHERE id = 3;
UPDATE tbl_address SET chain='003' WHERE id = 4;
UPDATE tbl_address SET chain='003' WHERE id = 5;

SELECT * FROM tbl_address;

SELECT id, name, addr, chain,
    DECODE (chain, '001','가족',DECODE(chain, '002','친구',DECODE(chain,'003','이웃'))) AS 관계
    FROM tbl_address
    WHERE DECODE (chain, '001','가족',DECODE(chain, '002','친구',DECODE(chain,'003','이웃'))) IS NULL;
    
-- 이 SQL에서 만일 '관계' 항목에 (null)값이 존재한다는 것은
-- chain 칼럼에 값이 잘못 입력되었거나, 조건식이 잘못되었다는 의미이다.

-- 테스트를 위해서 아래 SQL문을 수행하면서
-- chain 칼럼의 값을 101로 설정을 했다.
-- 그리고 위의 SELECT SQL을 수행했더니
-- 1개의 레코드가 보였다.
INSERT INTO tbl_address (id, name, tel)
VALUES (10, '조덕배', '010-222-2222');

INSERT INTO tbl_address (id, name, tel)
VALUES (9, '조용필', '010-333-3333');

INSERT INTO tbl_address (id, name, tel)
VALUES (8, '양희은', '010-123-1234');

SELECT * FROM tbl_address ORDER BY name;

SELECT * FROM tbl_address
ORDER BY name, addr;

SELECT * FROM tbl_address
ORDER BY name DESC, addr;

SELECT * FROM tbl_address ORDER BY id, name, addr, chain, rem, birth, age;

COMMIT;

