-- 달콤비스킷을 생산한 제조업체가 만든
-- 제품들의 제품명과 단가 조회
SELECT PRODNAME 제품명,PRICE 단가 FROM PRODUCTS
WHERE PRODNAME = '달콤비스킷'

-- 적립금이 가장 많은 고객의 이름과 적립금 조회
SELECT PRODNAME, PRICE FROM PRODUCTS
WHERE MAKER = '한빛제과';

SELECT PRODNAME, PRICE FROM PRODUCTS
WHERE MAKER = (SELECT MAKER 단가 FROM PRODUCTS
WHERE PRODNAME = '달콤비스킷');

SELECT MAX(MILEAGE) FROM CUSTOMERS;

SELECT NAME,MILEAGE FROM CUSTOMERS
WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM CUSTOMER);

-- banana 고객이 주문한 제품의 제품명과 제조업체 조회
SELECT USERID FROM CUSTOMERS
WHERE USERID = 'banana';

SELECT PRODNAME, maker FROM PRODUCTS
WHERE PRODID IN ('06','p01','p04');

SELECT PRODNAME, maker FROM PRODUCTS
WHERE PRODID IN (SELECT PRODID FROM CUSTOMERS
WHERE USERID = 'banana');

-- banana 고객이 주문하지 않은 제품의 제품명과 제조업체 조회
SELECT PRODID, USERID FROM ORDERS
WHERE USERID NOT IN ('banana');

SELECT PRODID,PRODNAME 제품명, MAKER 제조업체 FROM PRODUCTS;

SELECT PRODID,PRODNAME 제품명, MAKER 제조업체 FROM PRODUCTS
WHERE PRODID in (SELECT PRODID FROM ORDERS
WHERE USERID NOT in ('banana'));

-- 대한식품이 제조한 모든 제품의 단가보다
-- 비싼 제품의 제품명과 단가, 제조업체 조회
SELECT PRODNAME 제품명, PRICE 단가, MAKER 제조업체 FROM PRODUCTS

SELECT PRODNAME 제품명, PRICE 단가, MAKER 제조업체 FROM PRODUCTS
WHERE MAKER = '대한식품';

SELECT PRODNAME 제품명, PRICE 단가, MAKER 제조업체 FROM PRODUCTS
WHERE PRICE  = (SELECT MAX(PRICE) FROM PRODUCTS);

SELECT PRODNAME 제품명, PRICE 단가, MAKER 제조업체 FROM PRODUCTS
WHERE PRICE > 4500 AND PRICE > 1200;

SELECT PRODNAME 제품명, PRICE 단가, MAKER 제조업체 FROM PRODUCTS
WHERE PRICE  > ALL (SELECT PRICE FROM PRODUCTS WHERE maker = '대한식품');

-- silver 등급인 회원들의 마일리지보다 많은 회원의 이름 조회
SELECT name,grade,MILEAGE FROM CUSTOMERS
WHERE GRADE = 'silver'; -- 0, 300,500  

SELECT PRODNAME 제품명, PRICE 단가, MAKER 제조업체 FROM PRODUCTS
WHERE MILEAGE > 0 AND MILEAGE > 300 AND MILEAGE > 500;;

SELECT name,grade,MILEAGE FROM CUSTOMERS
WHERE MILEAGE > ALL (SELECT MILEAGE FROM CUSTOMERS WHERE grade = 'silver'); 

-- 2022년 3월 15일에 주문한 고객 이름 조회
SELECT USERID ,ORDERDATE FROM ORDERS
WHERE ORDERDATE in ('2022-03-15');

SELECT USERID ,ORDERDATE FROM ORDERS
WHERE ORDERDATE ='2022-03-15'

SELECT USERID ,ORDERDATE FROM ORDERS
WHERE USERID = 'apple';

SELECT USERID ,ORDERDATE FROM ORDERS
WHERE USERID in (SELECT USERID FROM ORDERS
WHERE ORDERDATE ='2022-03-15');

-- 2022년 3월 15일에 주문하지 않은 고객 이름 조회
SELECT USERID ,ORDERDATE FROM ORDERS
WHERE ORDERDATE NOT in ('2022-03-15');

--2022년 3월 15일에 주문한 고객 이름 조회
-- 단, 상관질의문(exists)으로 풀어봄
SELECT NAME FROM CUSTOMERS
WHERE EXISTS (SELECT FROM * ORDERS o
	WHERE c.USERID = o.USERID AND
		o.ORDRDATE = '2022-03-15');

SELECT USERID,ORDERDATE  FROM ORDERS o
	WHERE EXISTS (SELECT ORDERDATE FROM CUSTOMER c 
	WHERE ORDERDATE IN ('2022-03-15'));

























