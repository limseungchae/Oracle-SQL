-- 집합연산
-- 여러개의 SELECT 문을 결합해서 
-- 하나의 결과를 출력하는 연산
-- union(합집합), INTERSECT(교집합), minus(차집합)
-- 의외로 조인 못지않게 자주 사용됨
-- 단, select 문들의 컬럼수와 자료형은 서로 일치해야 함

-- 직업이 학생 또는 마일리지가 2500이상인
-- 회원의 회원번호, 이름, 직업, 마일리지 조회
SELECT USERID, name, job, MILEAGE 
FROM CUSTOMERS
WHERE JOB = '학생' OR MILEAGE  >= 2500;

SELECT USERID, name, job, MILEAGE 
FROM CUSTOMERS
WHERE JOB = '학생'
union
SELECT USERID, name, job, MILEAGE 
FROM CUSTOMERS
WHERE MILEAGE  >= 2500;

-- 도서를 주문하지 않은 고객이름 조회
-- outer join으로 풀수 있음
-- 고객테이블 - 주문테이블의 고객
SELECT CUSTID FROM CUSTOMER
minus
SELECT DISTINCT CUSTID FROM "ORDER" 

SELECT name FROM CUSTOMER -- 모든 고객 이름

SELECT name FROM CUSTOMER
WHERE CUSTID in (SELECT DISTINCT CUSTID FROM "ORDER");
-- 주문한 고객 이름

SELECT name FROM CUSTOMER
minus
SELECT name FROM CUSTOMER
WHERE CUSTID in (
	SELECT DISTINCT CUSTID FROM "ORDER");

-- insert문에 부속질의문을 사용하기
-- insert into 테이블명 [컬럼들]
-- select 부속질의문

-- 한빛제과에서 제조한 제품의 이름, 재고량, 단가를 조회해서
-- 한빛제품 테이블에 저장
SELECT PRODNAME, STOCK, PRICE FROM PRODUCTS
WHERE MAKER = '한빛제과';

CREATE TABLE hanbit (
	prodnme varchar(20),
	stock number,
	price number
);

INSERT INTO hanbit
SELECT PRODNAME, STOCK, PRICE FROM PRODUCTS
WHERE MAKER = '한빛제과';

SELECT * FROM hanbit;




