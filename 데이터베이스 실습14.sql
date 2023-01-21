-- 하위질의 subquery
-- 하나의 SQL 문안에 포함된 또 다른 SQL문
-- 일반적으로 2개 이상의 select문으로 구성된 질의문

-- 상위 질의문과 하위 질의문으로 구성
-- 단, 실행 순서는 하위 질의문 부터 먼저 실행

-- 일반 하위질의
-- 단일행	- 질의의 결과가 1행만 출력
-- 다중행 	- 질의의 결과가 2행이상 출력
-- 다중컬럼	- 질의의 결과가 여러 컬럼으로 출력

-- 가장 비싼 도서의 이름을 조회
SELECT max(PRICE) 가장비싼도서가격 FROM book;
-- 35000

SELECT BOOKNAME FROM BOOK 
WHERE price = 35000;

SELECT BOOKNAME FROM BOOK 
WHERE price = (SELECT max(PRICE) FROM book);

-- 도서를 구매한 적 있는 고객이름 조회
SELECT DISTINCT CUSTID FROM "ORDER";
-- 1 2 4 3
SELECT NAME FROM CUSTOMER 
WHERE CUSTID =1 OR CUSTID = 2 
	OR CUSTID = 4 OR CUSTID =3;

SELECT NAME FROM CUSTOMER 
WHERE CUSTID IN (1, 2, 4, 3);

SELECT NAME FROM CUSTOMER 
WHERE CUSTID IN (SELECT DISTINCT CUSTID FROM "ORDER");

-- 대한미디어에서 출판한 도서를 구매한 고객이름 조회
SELECT BOOKID  FROM BOOK 
WHERE PUBLISHER = '대한미디어'
-- 3 4

SELECT CUSTID FROM "ORDER"
WHERE BOOKID IN (3,4);

SELECT NAME FROM CUSTOMER
WHERE CUSTID = 1;

SELECT NAME FROM CUSTOMER
WHERE CUSTID = (SELECT CUSTID FROM "ORDER"
WHERE BOOKID IN (3,4));

SELECT NAME FROM CUSTOMER
WHERE CUSTID = (SELECT CUSTID FROM "ORDER"
WHERE BOOKID IN (SELECT BOOKID FROM BOOK 
WHERE PUBLISHER = '대한미디어'));

-- 비상관/상관 하위질의문
-- 비상관 : 하위질의는 메인질의에 값을 제공하는 역할 담당
-- 			하위질의는 메인질의는 서로 관련없음
-- 상관	  : 하위질의는 메인질의에 값을 확인하는 역할 담당
-- 			하위질의는 메인질의는 서로 관련있음

-- 비상관 질의
-- 출판사 평균 도서 가격을 알아내서 이것보단 비싼 도서를 알아냄
SELECT BOOKNAME, PUBLISHER, PRICE 가격 FROM BOOK;

SELECT avg(PRICE) 평균가격 FROM BOOK;

SELECT BOOKNAME, PUBLISHER, PRICE 가격 FROM BOOK
WHERE PRICE > (SELECT avg(PRICE) FROM BOOK);

-- 상관 질의
-- 도서 테이블에 있는 도서들의 가격이
-- 출판사 평균 도서 가격보다 비싼지 여부 확인
SELECT PUBLISHER, avg(PRICE) 평균가격 FROM BOOK
GROUP BY PUBLISHER;

-- b1 테이블에서 각 행별로
-- 출판사와 도서가격을 하위질의에 넘겨줌
-- 하위질의에서는 이것을 잉ㅇ해서 조건 만족 여부 확인
SELECT BOOKNAME, PUBLISHER, PRICE 가격  FROM BOOK b1
WHERE b1.price > (SELECT avg(PRICE) FROM BOOK b2
	WHERE b1.PUBLISHER = b2.PUBLISHER);

-- 주문이 있는 고객의 이름과 주소 조회
SELECT NAME, ADDRESS
FROM CUSTOMER c JOIN "ORDER" o
USING (CUSTID);

SELECT NAME, ADDRESS FROM CUSTOMER c
WHERE CUSTID IN (SELECT DISTINCT CUSTID FROM "ORDER");

-- 고객 개개인의 custid 가 주문테이블에 존재하는지 여부 확인
SELECT NAME, ADDRESS FROM CUSTOMER c
	WHERE exists (SELECT * FROM "ORDER" o
		WHERE c.CUSTID = o.CUSTID);
	





















