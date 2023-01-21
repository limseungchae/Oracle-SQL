-- 집계함수
-- 여러개의 값들을 계산해서 하나의 결과롤 반환
-- sum, avg, count, max min 등이 지원

-- 고객이 주문한 도서의 총 판매액 조회
SELECT SUM(SALEPRICE) 
FROM "ORDER";

SELECT SUM(SALEPRICE)  "총 판매액"
FROM "ORDER";

--김연아 고객(2번)이 주문한 도서의 총 판매액 조회

SELECT SUM(SALEPRICE)  "총 판매액"
from  "ORDER"
WHERE CUSTID = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가,최고가 조회

SELECT SUM(SALEPRICE) "총 판매액",
		avg(SALEPRICE) "평균 판매액",
		MIN(SALEPRICE) "최저 판매액",
		MAX(SALEPRICE) "최고 판매액"
FROM "ORDER";

-- 도서 판매건수 조회 
-- COUNT 함수 사용시 * 보다는
-- 특정컬러을 지정하는 것이 좋음! 
SELECT  COUNT(*) "판매건수" FROM "ORDER";

SELECT  COUNT(ORDERID) "판매건수" FROM "ORDER";

-- 회원수 조회
SELECT COUNT(*) "회원수" FROM CUSTOMER;

SELECT COUNT(CUSTID) "회원수" FROM CUSTOMER; -- 추천!

SELECT COUNT(phone) "회원수" FROM CUSTOMER;  -- NULL은 COUNT에서 제외, 비추!

-- 특정 컬럼을 기준으로 집계함수 적용
-- select 집계함수, 기준컬럼 form 테이블명 group by 기준컬럼 

-- 고객별 주문한 주문 건수과 총 주문액 조회
SELECT CPUSTID, SUM(SALEPRICE) "총 판매액" 
		COUNT (ORDERID) "주문건수"
FROM "ORDER"
GROUP BY CUSTID;

-- group by 절에 조건식을 사용하려면
-- having절을 이용한

--selct 집계함수, 기준컬럼 FROM 테이블명
-- group by 기준컬럼
-- having 조건식

-- 고객별 주문 건수가 2건 이상인 고객 조회
SELECT CUSTID, COUNT(ORDERID) 주문건수
FROM "ORDER"
GROUP BY CUSTID
HAVING COUNT(ORDERID) >= 3;

-- 주문금액이 8000이상인 고객에 대해 고갹별 주문
-- 고객별 주문 건가 3건 이상인 고객 조회
-- 단, 고객번호 순으러 출력

SELECT CUSTID, COUNT (ORDERID), SUM (SALEPRICE)
FALSE "ORDER"
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT (saleprice) >= 2
ORDER BY CUSRID;

-- 제품 텡블에서 모든 제품의 평균 단가 조회

SELECT avg(PRICE) "평균단가"
FROM PRODUCTS;

--제품 테이블에서 한빛제과가 제고한
-- 제품들의 재고량 합계를 조회
SELECT SUM(STOCK) "재고량 합계"
FROM PRODUCTS
WHERE MAKER = '한빛제과';

-- 고객테이블에서 고객이 몇명인지 조회
SELECT COUNT(*)
FROM CUSTOMERS;

SELECT COUNT(USERID) 고객수
FROM CUSTOMERS;

SELECT COUNT(age) 고객수
FROM CUSTOMERS;

-- 제품테이블에서 제조업체수 조회
SELECT COUNT(maker) 제조업체수 
FROM products;

SELECT COUNT(DISTINCT maker) 제조업체수 
FROM products;

-- 주문테이블에서 주문제품별 수량합계 조회
SELECT PRODID,SUM(AMOUNT) 수량합계
FROM ORDERS 
GROUP BY PRODID

-- 제품테이블에서 제조업체별로 제품의 갯수와 제품중 가장 비싼 단가를 조회
-- 단, 컬럼명은 제품수와 최고가라는 이름 사용
SELECT MAKER 제조업체,
		COUNT(PRODID) 제품수,
		MAX(PRICE) 최고가
FROM PRODUCTS
GROUP BY MAKER;
-- 제품테이블에서 3개의 제품을 제조한 제조업체별로
-- 제품수와 제품 중 가장 비싼 단가를 조회
SELECT MAKER 제조업체,
		COUNT(PRODID) 제품수,
		MAX(PRICE) 최고가
FROM PRODUCTS
GROUP BY MAKER
HAVING COUNT(PRODID) >= 3;


--고객테이블에서 등급별 평균적립금
-- 1000원 이상인 등급에 대해 
-- 등급별 고객수와 평균적립금을 조회
SELECT grad, avg(MILEAGE) 평균적립금,
		count(USERID) "등급별 고객수"
FROM CUSTOMERS
GROUP BY grade
HAVING avg(MILEAGE) >= 1000;

-- 주문테이블에서 각 주문고객이 주문한 제품의 총 주문수량 조회
SELECT PRODID, SUM(AMOUNT) "총 주문수량"
FROM ORDERS
GROUP BY PRODID
ORDER BY PRODID; -- 주문제품별 총 주문 수량

SELECT PRODID 주문제품, USERID 주문고객, SUM(AMOUNT)" 총 주문수량"
FROM ORDERS
GROUP BY PRODID, USERID
ORDER BY PRODID; -- 주문제품별 주문고객별 총 주문 수량









-- 마당서점
-- 1. 도서번호가 1인 도서의 이름

SELECT  bookname count(bookid) 도서이름
FROM books
GROUP BY bookid
HAVING COUNT (bookid) = 1;

-- 2. 가격이 20,000원 이상인 도서의 이름

SELECT  bookid count(saleprice) 도서이름
FROM "ORDER"
GROUP BY bookid
HAVING COUNT (saleprice) >= 20000;

-- 3. 박지성의 총 구매액 (박지성의 고객번호는 1번으로 놓고 작상.)

SELECT  saleprice count(custid) 고객번호
FROM "ORDER"
GROUP BY bookid
HAVING COUNT (custid) = 1;

-- 4. 박지성이 구매한 도서의수()

SELECT  SUM(*) "박지성" FROM orders;

-- 1. 마당서점 도서의 총 개수

SELECT  SUM(amount) FROM orders;

-- 2. 마당성점에 도서를 출고하는 출판사의 총 개수

SELECT  SUM(amount) FROM orders;

-- 3. 모든 고객 이름,주소

SELECT sum(customers) FROM name;

-- 4. 2017년 7 월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
































