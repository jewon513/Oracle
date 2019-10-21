--IOLIST  사용자 화면

SELECT * FROM tbl_product;

--tbl_iolist에서 판매가격의 원단위를 제거하고 0으로 세팅
--판매가격 = ROUND(판매가격/10,0) * 10 
            --1개 이상의 데이터를 대상으로 UPDATE, DELETE를 수행할때는 항상 신중하게 코드를 검토해서 실행하자.
UPDATE tbl_product SET p_oprice = ROUND(p_oprice/10) * 10;

-- 매입매출장과 상품정보를 테이블 JOIN을 하기 위해
-- 매입매출장의 상품코드 칼럼을 추가하고 상품이름과 연결된 상품코드로 업데이트 하고 상품이름 칼럼을 제거

-- 1. 매입매출장에 상품코드 칼럼을 추가한다.
ALTER TABLE tbl_iolist ADD io_pcode VARCHAR2(6);

-- 2. 매입매출장에 상품코드 칼럼을 업데이트 한다.
SELECT p_code FROM tbl_product, tbl_ioList WHERE p_name = io_pname; -- TEST

        --서브쿼리를 사용해서 UPDATE 실행에서 유의사항
        --UPDATE를 수행하는 SUBQ SELECT Projection에는 칼럼을 1개만 사용해야한다
        --SUBQ에서 나타나는 레코드 수도 반드시 1개만 나타나야한다.

UPDATE tbl_iolist SET io_pcode = 
(SELECT p_code FROM tbl_product WHERE p_name = io_pname GROUP BY p_code);

-- 3. 업데이트 후에 검증
-- iolist와 product를 EQ JOIM을 수행해서 누락된 데이터가 없는지 확인

SELECT * FROM tbl_iolist, tbl_product WHERE io_pcode = p_code;

-- 매입매출테이블에서 상품이름 칼럼을 제거
ALTER TABLE tbl_iolist DROP COLUMN io_pname;

/*
        오라클에서 INSERT, UPDATE, DELETE를 수행한 직후에는 아직 데이터가 COMMIT되지 않아서
        실제 물리적 테이블에 저장이 되지 않은 상태이다
        이때는 ROLLBACK을 수행해서 CUD를 취소할 수 있다.
        
        단 DDL 명령(CREAT, ALTER, DROP)을 수행하면 자동 COMMIT이 된다.
        
        대량의 INSERT, UPDATE , DELETE를 수행한 후에는 데이터 검증이 완료되면 가급적 COMMIT을 수행하고
        다음으로 진행하자.
        
        COMMIT과 ROLLBACK도 시점을 지정해서 어디까지 ROLLBACK을 할 것인지 지정할 수도 있다.
*/

SELECT * FROM tbl_iolist, tbl_product WHERE io_pcode = p_code;

