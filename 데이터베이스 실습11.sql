-- 두 테이블 결합 연산하기
SELECT *
FROM BOOK, "ORDER";

-- 고객과 고객 주문을 결합한 결과 조회
SELECT *
FROM CUSTOMER, "ORDER";

-- 고객과 고객의 주문을
-- 고객번호순으로 정렬후 모두 조회 (결합해서 출력)
-- 결합시 동일한 컬럼명이 있을경우
-- '테이블명.컬럼명으로' 지정할 수 있음
SELECT *
FROM CUSTOMER, "ORDER"
ORDER BY CUSTOMER.CUSTID; 

SELECT *
FROM CUSTOMER, "ORDER"
ORDER BY "ORDER".CUSTID; 

-- 또한, 결합시 동일한 컬럼명이 있을 경우
-- '테이블멸칭.컬러명'으로 지정할 수 있음
SELECT *
FROM CUSTOMER c, "ORDER" o
ORDER BY c.CUSTID; 

-- 조인
-- 데이터 조회시 여러 테이블의 데이터를 조합해야 할 경우 발생
-- 이럴 경우, 각 테이블의 동일 컬럼을 기준으로
-- 테이블들을 결합한 뒤 원하는 데이터를 조회할 수 있다.
-- 보통 where 절에 테이블 결합조건을 나타냄

-- SELECT 컬럼들
-- from 테이블, 테이블, ...
-- where 결합조건

-- 조인의 종류
-- 내부 : 테이블간 공통 컬럼을 기준으로 결합
-- 외부 : 내부조인 + 미 조인 데이터
-- 셀프 : 단일 테이블을 대상으로 내부조인

-- 고객과 주문테이블을 결합
SELECT *
FROM CUSTOMER c, "ORDER" o
WHERE c.CUSTID = o.CUSTID;

-- 고객 이름과 고객이 주문한 도서가격 조회
SELECT name 이름, saleprice 
FROM CUSTOMER c, "ORDER" o
WHERE c.CUSTID = o.CUSTID;

-- 고객이름별 주문한 도서의 총 판매액 조회
SELECT name 이름, sum(saleprice) 총판매액
FROM CUSTOMER c, "ORDER" o
WHERE c.CUSTID = o.CUSTID
GROUP BY name;

-- 주문 테이블에서 고객이름과 도서명
SELECT NAME 이름, BOOKNAME 도서명
FROM CUSTOMER c ,"ORDER" o, BOOK b
WHERE c.CUSTID = o.CUSTID AND b.BOOKID = o.BOOKID
ORDER BY orderid;

-- 주문금액이 20000원인 도서를 주문한
-- 고객이름과 주문도서명 조회
SELECT NAME 이름, BOOKNAME 도서명,saleprice 주문금액
FROM CUSTOMER c ,"ORDER" o, BOOK b
WHERE c.CUSTID = o.CUSTID AND b.BOOKID = o.BOOKID
 AND saleprice = 20000
ORDER BY orderid;
-- 조인조건과 검색조건이 같이 존재 - 가독성 저하


-- ANSI 표준 조인 구문
-- SELECT 컬럼들
-- from 테이블 inner join 테이블
-- on 결합조건
-- where 검색조건

-- 고객이름과 주문도서가격 조회
SELECT name 이름, saleprice 
FROM CUSTOMER c INNER JOIN "ORDER" o
on c.CUSTID = o.CUSTID;

-- 주문금액이 20000원인 도서를 주문한
-- 고객이름과 주문도서명 조회
SELECT NAME 이름, BOOKNAME 도서명,saleprice 주문금액
FROM CUSTOMER c INNER JOIN "ORDER" o
on c.CUSTID = o.CUSTID INNER JOIN BOOK b
on b.BOOKID = o.BOOKID
WHERE saleprice = 20000;

-- ANSI 표준 조인 구문 2
-- SELECT 컬럼들
-- from 테이블 inner join 테이블
-- using (결합대상컬럼)
-- where 검색조건
SELECT name 이름, saleprice 
FROM CUSTOMER c JOIN "ORDER" o USING (custid);

SELECT NAME 이름, BOOKNAME 도서명,saleprice 주문금액
FROM CUSTOMER c JOIN "ORDER" o
USING (CUSTID) JOIN BOOK b USING (BOOKID)
WHERE saleprice = 20000;

-- 외부조인
-- 각 테이블 중 공동으로 존재하는 값 이외의
-- 다른 대상에 관심을 주기 위해 사용

-- 고객 이름과 고객이 주문한 도서가격 조회
-- 단, 주문하지 않은 고객도 포함
SELECT name 이름, saleprice 
FROM CUSTOMER c INNER JOIN "ORDER" o
on c.CUSTID = o.CUSTID;

--(주문한) 고객이름과 주문도서가격 조회
-- 단, 주문하지 않은 고객도 같이 출력함
SELECT name 이름, saleprice 도서가격
FROM CUSTOMER c LEFT OUTER JOIN "ORDER" o
on c.CUSTID = o.CUSTID;

-- (주문한) 주문도서이름과 주문도서 가격 조회
SELECT BOOKNAME 도서이름, saleprice 도서가격
FROM BOOK b INNER JOIN "ORDER" o
on b.BOOKID = o.BOOKID;

SELECT BOOKNAME 도서이름, saleprice 도서가격
FROM BOOK b JOIN "ORDER" o
USING (bookid);

-- (주문한) 주문도서이름과 주문도서 가격 조회
-- 단, 주문하지 않은 고객도 같이 출력함
SELECT BOOKNAME 도서이름, saleprice 도서가격
FROM BOOK b LEFT OUTER JOIN "ORDER" o
USING (bookid);

-- 한번도 주문하지 않은 고객 조회
SELECT name 이름, orderid 주문
FROM CUSTOMER c  LEFT OUTER JOIN "ORDER" o 
USING (CUSTID)
WHERE orderid IS null;

SELECT name 이름, orderid 주문
FROM CUSTOMER c, "ORDER" o
WHERE c.CUSTID = o.CUSTID(+)
	AND orderid IS NULL;

-- 한권도 팔리지 않은 도서 조회
SELECT BOOKNAME 도서, orderid 주문
FROM BOOK b LEFT OUTER JOIN "ORDER" o
USING (bookid)
WHERE orderid IS NULL;

SELECT BOOKNAME 도서, orderid 주문
FROM BOOK b, "ORDER" o
WHERE b.bookid = o.bookid(+)
	AND orderid IS NULL;




























