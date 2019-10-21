-- 여기는 IOLIST 화면입니다
-- 거래처정보 제 2정규화 수행

-- 매입매출정보에 거래처정보가 거래처명과 대포명 두개의 칼럼이 있다.
-- 거래처명이 같은데 대표가 다른 거래처가 있을 수 있기 때문에

-- 매입매출에서 거래처 정보 추출
SELECT io_dname, io_dceo FROM tbl_iolist GROUP BY io_dname, io_dceo ORDER BY io_dname;

-- 거래처 테이블 생성
-- 거래처 테이블일 경우 
-- 거래처명이 같고, 대표자 명이 다른 데이터를 UNIQUE로 설정
-- 입력할때 거래명과 대표자명이 동시에 같은 경우는 INSERT되지 않도록 설정
CREATE TABLE tbl_dept(
        d_code	VARCHAR2(5)		PRIMARY KEY,
        d_name	nVARCHAR2(50)	NOT NULL,	
        d_ceo	nVARCHAR2(50)	NOT NULL,	
        d_tel	VARCHAR2(50),		
        d_addr	nVARCHAR2(125),		
        d_man	nVARCHAR2(50),
        CONSTRAINT UQ_name_ceo UNIQUE (d_name,d_ceo)
);

SELECT d_name, COUNT(d_name) FROM tbl_dept GROUP BY d_name HAVING COUNT(*) > 1;
-- 위의 결과에서 COUNT가 2 이상인 데이터는 거래처명은 같으나 대표자명이 다르다는 소리

-- iolist와 dept 테이블을 EQ JOIN해서 dept 데이터가 잘 만들어졌는지 검증
SELECT COUNT(*) FROM tbl_iolist, tbl_dept WHERE io_dname = d_name;

-- iolist에 거래처 코드칼럼을 생성
ALTER TABLE tbl_iolist ADD io_dcode VARCHAR2(5);

UPDATE tbl_iolist SET io_dcode = (SELECT d_code FROM tbl_dept WHERE io_dname = d_name AND io_dceo = d_ceo);

SELECT COUNT(*) FROM tbl_iolist, tbl_dept WHERE io_dcode = d_code;

-- iolist에서 io_dname, io_dceo 칼럼 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_dname;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo;

SELECT * FROM tbl_iolist;

/*
    iolist를 제 2정규화를 수행해서 상품정보와 거래처정보를 TABLE 분리하였다
    iolist의 단가(io_price) 칼럼을 삭제하지 않고 유지하고 있는 이유
        iolist의 매입, 매출단가는 실제로 상품이 매입 매출되는 시점에서 변동될 수 있다.
        기존수량 입출 할때와 권장수량 입출 할때 밀어내기 입출 할때는 단가가 달리 적용된다.
        
        iolist에는 실질적인 입출단가가 기록되어서
        결산수행의 기준값으로 삼는다 : 실질적인 결산내용
        회계상 재고, 이익금을 계산할때는 매입매출이 변동된 단가로 계산되면 상당히 어려운 연산들이 필요하다.
        그래서 회계상 계산을 할때 사용할 표준단가를 product에 저장해두고 계산한다.
        
*/

SELECT * FROM tbl_iolist
    LEFT JOIN tbl_product ON io_pcode = p_code
    LEFT JOIN tbl_dept On io_dcode = d_code
    ORDER BY io_date, io_pcode;

DROP VIEW view_iolist;
CREATE VIEW view_iolist AS(

SELECT 
        IO_SEQ      AS SEQ,
        IO_DATE     AS IODATE,
        IO_INOUT    AS INOUT,
        IO_DCODE    AS DCODE,
        d_name      AS DNAME,
        d_ceo       AS DCEO,
        d_tel       AS D_TEL,
        IO_PCODE    AS PCODE,
        p_name      AS PNAME,
        IO_QTY      AS QTY,
        P_IPRICE    AS IPRICE,
        P_OPRICE    AS OPRICE,
        IO_PRICE    AS PRICE,
        IO_AMT      AS AMT
FROM tbl_iolist
    LEFT JOIN tbl_product ON io_pcode = p_code
    LEFT JOIN tbl_dept On io_dcode = d_code

);

SELECT * FROM view_iolist;

-- 매입과 매출을 구분해서 출력
SELECT DECODE(INOUT, 1, '매입', 2, '매출'),
       DCODE, DNAME, DCEO,
       PCODE, PNAME,
       QTY, PRICE, AMT
FROM view_iolist;

-- 거래처별로 매입, 매출의 합계
-- 보고자하는 view
-- 거래처별로 흩어져 있는 거래내역을 모아서
-- 매입합계, 매출합계로 보고싶다.
-- 1. DECODE를 사용해서 INOUT 칼럼값을 기준으로 매입, 매출구분을 실행
-- 2. 매입과 매출 구분된 항목을 SUM()으로 묶어주기
-- 3. SUM() 묶이지 않은 DCODE, DNAME칼럼을 GROUP BY 절에 나열
SELECT DCODE, DNAME,
        SUM(DECODE(INOUT, 1, AMT,0)) AS 매입합계,
        SUM(DECODE(INOUT, 2, AMT,0)) AS 매출합계
FROM view_iolist
GROUP BY DCODE, DNAME
ORDER BY DCODE;

--월별로 매입 매출 합계
--1. 거래일자 칼럼에서 년 월만 추출
--          SUBSTR(칼럼, 시작, 개수)
--2. DECODE를 사용해서 INOUT에 따라서 매입매출을 구분
--3. SUM()으로 묶기
--4. 3자리마다, 찍어 보이기
--          999,999 : 출력포맷 형식
--TO_CHAR() SQLD에서 일반적으로 화면보기용으로는 사용을 하지만 다른 언어와 연동되는 부분에서는 사용을 지양할것
SELECT SUBSTR(IODATE,0,7) AS 월,
        TO_CHAR(SUM(DECODE(INOUT,1,AMT)),'999,999,999,999') AS 매입합계,
        TO_CHAR(SUM(DECODE(INOUT,2,AMT)),'999,999,999,999') AS 매출합계
FROM view_iolist
GROUP BY SUBSTR(IODATE,0,7)
ORDER BY 월;

-- 전체리스트를 모두 Pivot
SELECT SEQ, IODATE, DNAME, PNAME,
    DECODE(INOUT,1,AMT) AS 매입,
    DECODE(INOUT,2,AMT) AS 매출
FROM view_iolist;

-- 2018년 총 매입합계와 총 매출합계를 계산하고 싶다
-- 저장된 실제 데이터의 길이가 모두 같은 경우 BETWEEN 키워드를 사용하여 범위 검색이 가능하다.
SELECT SUM(DECODE(INOUT,1,AMT,0)) AS 총매입합계,
        SUM(DECODE(INOUT,2,AMT,0)) AS 총매출합계
FROM view_iolist
WHERE IODATE BETWEEN '2018-01-01' AND '2018-12-31';

SELECT SUM(DECODE(INOUT,1,AMT,0)) AS 총매입합계,
        SUM(DECODE(INOUT,2,AMT,0)) AS 총매출합계
FROM view_iolist
WHERE IODATE LIKE '2018%';

--상품정보에 저장된 매입매출 단가와 iolist에 저장된 매입매출 단가의 차이를 계산
SELECT IPRICE, OPRICE, DECODE(INOUT,1,PRICE,0) AS 매입,
                        DECODE(INOUT,2,PRICE,0) AS 매출 FROM view_iolist;
                        
SELECT IPRICE, 
       DECODE(INOUT,1,PRICE,0) AS 매입,
       
       DECODE(INOUT,1,IPRICE,0)
       - DECODE(INOUT,1,PRICE,0) AS 매입차액,
       
       OPRICE, 
       DECODE(INOUT,2,PRICE,0) AS 매출,
       
       DECODE(INOUT,2,OPRICE,0)
       - DECODE(INOUT,2,PRICE,0) AS 매출차액
FROM view_iolist;



