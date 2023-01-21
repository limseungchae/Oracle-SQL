-- 제품번호가 p03인 제품의 이름을
-- 통큰파이로 변경
SELECT PRODNAME FROM PRODUCTS
WHERE PRODID = 'p03';

UPDATE PRODUCTS 
SET PRODNAME = '통큰파이'
WHERE PRODID  = 'p03';

-- 2 제품테이블에 있는 모든 제품의 단가를 10% 인상해보자
SELECT PRODNAME 제품명 , PRICE 인상전, 
		PRICE * 1.1 인상후 FROM PRODUCTS;

UPDATE PRODUCTS 
SET PRICE = PRICE * 1.1;

SELECT * FROM ORDERS;

SELECT PRODNAME 제품명 ,PRICE 인상후 FROM PRODUCTS;

-- 3 정소화 고객이 주문한 제품의 수량을 5개로 변경
SELECT  USERID FROM CUSTOMERS
WHERE NAME = '정소화';

SELECT AMOUNT FROM ORDERS
WHERE USERID = 'apple';

UPDATE ORDERS 
SET AMOUNT = 5
WHERE userid = (SELECT  USERID FROM CUSTOMERS
WHERE NAME = '정소화');

SELECT * FROM ORDERS;

-- 1 주문일자 2022-05-2 주문 내역을 삭제해보자
SELECT * FROM ORDERS
ORDER BY ORDERDATE;

DELETE FROM ORDERS
WHERE ORDERDATE = '2022-05-22';

-- 2 정소화 고객이 주문한 내역 삭제해보자
SELECT * FROM ORDERS
WHERE USERID = (SELECT USERID FROM CUSTOMERS c
WHERE name = '정소화')

DELETE FROM ORDERS o
WHERE USERID = (SELECT USERID FROM CUSTOMERS c
WHERE name = '정소화')

SELECT * FROM ORDERS; 

-- 3 주문테이블에 존재하는 모든 내용을 삭제해보자
DELETE  FROM ORDERS;

SELECT * FROM ORDERS; 
































