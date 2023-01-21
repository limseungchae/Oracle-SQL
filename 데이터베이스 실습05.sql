-- 데이터 조회 : SELECT
-- 테이블에 존재하는 데이터를 조회할때 사용하는 명령

-- select 조회하고픈컬럼들
-- from 테이블
-- where 조건
-- order by 정령조건

-- 1. 모든 도서의 이름, 가격 조회
SELECT BOOKNAME, PRICE 
FROM book;

-- 1b. 모든 도서의 가격, 이름 조회
SELECT price, bookname
FROM book;

-- 2. 모든 도서의 도서번호, 이름, 출판사, 가격 조회
SELECT bookid,bookname,publisher,price
FROM book;
=
SELECT *
FROM book;

-- 3. 모든 출판사를 조회
SELECT punlisher
FROM book;		--특정 출판사가 여러번 출려됨

SELECT DISTINCT publisher
FROM book;		--DISRINCT  키워드 사용

-- 4. 가격이 20000 미만인 도서 조회
-- 조건검색 : where 조건식
SELECT book
FROM BOOK b WHERE price < 20000;

--정렬 : order by 정렬대상컬럼들 정렬순서
SELECT *
FROM BOOK
WHERE price < 20000
ORDER BY price;

SELECT *
FROM BOOK
WHERE  price < 20000
ORDER BY price DESC; -- 내림차순

-- 5. 가격이 10000원 이상 20000원 이하인 도서 조회
SELECT *
FROM BOOK
WHERE (price >= 10000) AND (price <= 20000)
ORDER BY price;

SELECT *
FROM BOOK
WHERE price BETWEEN 10000 AND 20000
ORDER BY price;

-- 6. 출판사가 '굿스포츠' 이거나 '대한미디어'인 도서 조회
SELECT *
FROM BOOK
WHERE (PUBLISHER = '굿스포츠') OR (PUBLISHER ='대한미디어')
ORDER BY PUBLISHER;

SELECT *
FROM BOOK
WHERE PUBLISHER IN ('굿스포츠','대한미디어')
ORDER BY PUBLISHER;

-- 6b. 출판사가 '굿스포츠' 이거나 '대한미디어'가 아닌 도서 조회
SELECT *
FROM BOOK
WHERE PUBLISHER NOT in ('굿스포츠','대한미디어')
ORDER BY PUBLISHER;

-- 7. '축구의 역사'를 출간한 출판사 조회
SELECT BOOKNAME, PUBLISHER
FROM BOOK
WHERE BOOKNAME = '축구의 역사';

-- 8. '축구'라는 단어가 포함된 도서 조회
-- 입력한 문자열의 일부를 검색에 이용해서
-- 조건을 일치하는 결과를 찾는 것을 패턴 검색이라 함
-- 패턴검색에 사용하는 기호
-- %(와일드카드) : 0개 임의의 문자을을 의미 기호
-- ex1) x라는 문자열로 시작하는 대상 검색 : x%
-- ex2) x라는 문자열로 끝나는 대상 검색 : %x
-- ex3) x라는 문자열로 포함하는 대상 검색 : %x%
-- http://naver.me/5DHSICpC
 
-- 구로동으로 주소 조회

SELECT * FROM ZIPCODE 
WHERE dong = '구로동';

SELECT * FROM ZIPCODE
WHERE dong = '구로1동';

SELECT * FROM ZIPCODE
WHERE dong like '구로%';

SELECT * FROM ZIPCODE
WHERE dong like '%구로';

SELECT * FROM ZIPCODE
WHERE dong like '%구로%';

-- _ : 1개의 단일 문자를 의미하는 기호
-- ex1) x라는 시작하는 3자 길이의 문자 검색 : x__
-- ex2) x라는 끝나는 3자 길이의 문자 검색 : __x
-- ex3) x라는 포함하는 3자 길이의 문자 검색 : _x_

SELECT BOOKNAME, PUBLISHER 
FROM BOOK
WHERE bookname LIKE '%축구%';

-- 8b. 도서 이름이 총 6자이고
-- '축구'라는 단어로 시작하는 출판사 조회

SELECT BOOKNAME, PUBLISHER 
FROM BOOK
WHERE BOOKNAME LIKE '축구____';

-- 9. 도서명 중 앞에서 2번째 위치에
-- '구'라는 문자를 포함하는 도서 조회

SELECT *
FROM book
WHERE BOOKNAME LIKE '_구%';

-- 10. 축구에 관한 도서 중
-- 가격이 2000이상인 도서 조회

SELECT *
FROM BOOK
WHERE (BOOKNAME LIKE '%축구%') AND
	(price >= 20000);

-- 12. 도서명으로 정렬 후 조회

SELECT *
FROM BOOK
ORDER BY bookname;

-- 13. 도서를 가격순으로 정렬 후
-- 가격이 같으면 이름순으로 

SELECT * FROM BOOK
ORDER BY price,bookname;

-- 14. 도서를 가격순으로 내림차순 정렬 후
-- 가격이 같으면 출판순으로 정렬후 조회

-- 정렬기준 : 오름차순 ascending -> asc
--			  내림차순 descending -> desc

SELECT * FROM BOOK
ORDER BY price DESC, PUBLISHER ASC; 

-- 산술식 이용한 조회
-- 도서가격과 가격를 10% 할인한 할인가와
-- 10% 인상한 특가 조회
SELECT bookname, price, price * 0.9, price * 1.1
FROM book;

-- 벌칭 사용하기
-- 조회 결과 컬럼명을 다른이름으로 출력하려면
-- '컬럼명 as 새컬럼명' 또는 '컬럼명 새컬럼명' 로 사용

SELECT BOOKNAME 도서명, price 정가,
		price * 0.9 AS 할인가, price * 1.1 인상가
FROM book;






















