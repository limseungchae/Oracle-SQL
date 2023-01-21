-- banana 고객이 주문한 제품명 조회
SELECT PRODNAME 
FROM PRODUCTS p JOIN ORDERS o 
USING (prodid)
WHERE userid = 'banana';

SELECT PRODNAME
FROM PRODUCTS p, ORDERS o 
WHERE p.prodid = o.prodid(+)
	AND userid = 'banana';

-- 나이가 30세인 고객이 주문한 제품번호와 주문일자 조회
SELECT PRODID 주문번호, ORDERDATE 주문일자
FROM CUSTOMERS c JOIN ORDERS o 
USING (USERID)
WHERE age >= 30;

SELECT PRODID 주문번호, ORDERDATE 주문일자
FROM CUSTOMERS c, ORDERS o
WHERE c.USERID = o.USERID(+)
	AND age >=30;


-- 고명석 고객이 주문한 제품의 이름 조회
SELECT name 이름, PRODNAME 제품명
FROM CUSTOMERS c JOIN ORDERS o 
USING (USERID) JOIN PRODUCTS p
USING(PRODID)
WHERE name = '고명석';

SELECT name 이름, PRODNAME 제품명
FROM CUSTOMERS c, ORDERS o, PRODUCTS p
WHERE c.USERID = o.USERID 
	AND c.PRODID = o.PRODID = p.PRODID(+)
	AND name = '고명석';
































