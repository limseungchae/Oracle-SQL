--마당상점 조회


-- 고객테이블에서 아이디, 이름, 등급, 조회
SELECT userid 고객아이디, name 고객이름, grade 등급
FROM customers;

-- 고개테이블에서 모든컬럼 조회
SELECT userid 고객아이디, name 고객름, age 나이, grade 등급,
		job 직업, mileage 적립금
FROM customers;

SELECT * FROM customers;

--제품테이블에서 제조업체 조회
SELECT maker 제조업체
FROM products;

--제품테이블에서 제조업체 조회 (단,중복없이)
SELECT DISTINCT maker 제조업체
FROM products;

-- 제품테이블에서 제품명과 단가를 조회
-- 단, 단가는 가격으로 바꿔서 출력
SELECT prodname 제품명, price 가격
FROM products;

SELECT prodname AS 제품명, price AS 가격
FROM products;

-- 제품테이블에서 제품명과 단가를 조회
-- 단, 단가에 500워을 더해 조정 단가라는
-- 이름으로 바꿔 출력
SELECT prodname 제품명, price + 500 조정단가
FROM products;

SELECT prodname 제품명, PRICE 가격, price + 500 "조정단가"
FROM products;

-- 제품테이블에서 한빛제과가 제조한
-- 제품의 이름,재고량,단가 조회

SELECT prodname, stock , price 
FROM products
WHERE MAKER = '한빛제과'

SELECT prodname 제품명,stock 재고량, price 단가
FROM products
WHERE prodname IN ('쿵떡파이','맛난초콜릿','달콤비스킷');


-- 제품테이블에서
--APPLE 고객이 15개 이상 주문한 제품의
--이름, 수량, 주문일자 조회
SELECT prodid 주문제품,amount 수량 , orderdate 주문일자
FROM orders
WHERE (userid ='apple') AND (amount >= 15);

-- 주문테이블에서
-- apple 고객이 주문했거나
-- 15개 이상 주문한 제품의 이름이, 수량, 주문일자 조회
-- 이름,수량, 주문일자, 주문고객 조회
SELECT prodid 주문제품,amount 수량 , orderdate 주문일자
FROM orders
WHERE (amount >= 15) OR (userid ='apple');


SELECT prodname 제품명, price  단가, maker 제조업체
FROM products
WHERE prodname IN ('쿵떡파이','맛난초콜릿');

-- 제품테이블에서 단가가 2000원 이상이면서
-- 3000원 이하인 제품의 제품명,단가,제조업체 조회


SELECT prodename, pricem make
FROM PRODUCTS
WHERE price >= 2000 AND price<= 3000:

SELECT prodname 제품명, price  단가, maker 제조업체
FROM products
WHERE price BETWEEN 2000 AND 3000
ORDER BY price

-- 고객테이블에서 성이 김씨인 고객 이름, 나이, 등급, 적립금 조회
SELECT name, age, grade, MILEAGE 
FROM CUSTOMERS
WHERE name LIKE '김%'

-- 고객 테이블에서 고객 아이디가 5자인
-- 고객의 아이디,이름,등급 조회

SELECT userid, name, grade
FROM CUSTOMERS
WHERE userid lik '_____';


-- 고객 테이블에서 나이가 입력되지 않은 고객의 이름 조회

SELECT name, age
FROM customers
WHERE age = NULL;  -- (x)


SELECT name, age
FROM SUBJECTS
where age IS NULL;

-- 고객이름 조회
SELECT name, age
FROM customers
WHERE age <> NULL;  -- (x)

SELECT name, age
FROM customers
WHERE age IS NOT NULL;

-- 고객테이블에서 고객이름,등급,나이를 조회
-- 단, 나이를 기준으로 내림차순으로 정렬함
SELECT name,grade,age
FROM CUSTOMERS
ORDER BY age DESC;

-- 주문테이블에서 수량이 10개인 
-- 고객의 이름, 주문 제품, 수량,주문일자 조회
-- 단, 주문 제품 순으로, 정렬하되 동일 
-- 주문제품은 수량을 기준으로 내림차순 정렬함
SELECT name, prodid, amount, ordrdate
FROM orders 
where  amoun >= 10
ORDER BY prodid, amount DESC;






































