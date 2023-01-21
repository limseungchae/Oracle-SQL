-- 뷰
-- 기존에 존재하는 테이블을 토대로 만들어진 가상 테이블
-- 사용자에게 접근이 허용된 자료만을 제한적으로 보여주기위해 사용
-- 또한, 복잡한 질문을 단순화 시켜 구문의 이해도를 높임

-- create view 뷰이름 [컬럼들]
-- as select 질의문

-- bigdata 계정에 view 생성권한 부여
-- 관리자sys 계정으로 실행해야함
-- GRANT CREATE VIEW TO bigdata;


-- 고객테이블에서 고객번호와 이름만 추출해서
-- customer2 라는 뷰 생성
CREATE VIEW CUSTOMER2
AS	
SELECT CUSTID, name FROM CUSTOMER;

-- 생성된 뷰 확인
SELECT * FROM CUSTOMER2;

-- 고객테이블과 주문테이블을 조인한 뒤
-- cusordr 이라는 뷰를 생성


CREATE VIEW cusordr
AS	
SELECT * FROM CUSTOMER c JOIN "ORDER" o 
using (custid);

SELECT * FROM cusordr;

-- 도서테이블과 주문테이블을 조인한 뒤
-- bookordr 이라는 뷰를 생성

CREATE VIEW bookordr
AS	
SELECT * FROM BOOK b JOIN "ORDER" o 
using (bookid);

SELECT * FROM bookordr;

-- 고객테이블과 주문테이블, 도서테이블을 조인한 뒤
-- custbookordr 이라는 뷰를 생성 

CREATE VIEW custbookordr
AS	
SELECT * FROM CUSTOMER c JOIN "ORDER" o 
using (custid) JOIN BOOK b using (bookid);

SELECT * FROM custbookordr;

-- 1 제품테이블에서 제조업체별 제품수로 구성된 뷰를
-- 업체별제품수라는 이름으로 생성해보자. 다음 업체별제품수 뷰 검색
SELECT * FROM PRODUCTS;
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMERS;

CREATE VIEW 우수고객
AS
SELECT USERID 고객아이디 ,NAME 고객이름 ,AGE 나이,GRADE 등급 
FROM CUSTOMERS c
WHERE GRADE  = 'vip';

SELECT * FROM 우수고객;

-- 2 제품 테이블에서 제조업체별 제품수로 
-- 구성된 뷰를 업체별 제품수라는 이름으로 생성

CREATE VIEW 업체별제품수
AS
SELECT MAKER 제조업체,COUNT(PRODID) 제품수 FROM PRODUCTS p
GROUP BY maker;

SELECT * FROM 업체별제품수;


-- 3 우수고객 뷰에서 나이가 20세 이상인 고객에 대한 모든 내용 검색
SELECT * FROM 우수고객
WHERE 나이 >= 20;

-- 제품번호,재고량,제조업체를 추출해서 제품1 뷰를 생성
SELECT * FROM PRODUCTS;

CREATE VIEW 제품1
AS 
SELECT PRODID 제품번호, stock 제품량, MAKER 제조업체
FROM PRODUCTS p;

SELECT * FROM 제품1;

-- 제품명, 재고량, 제조업체를 추출해서 제품2 뷰를 생성
CREATE VIEW 제품2
AS
SELECT PRODNAME 제품명, stock 제품량, MAKER 제조업체
FROM PRODUCTS p;

SELECT * FROM 제품2; 

-- 제품번호가 p08, 재고량이 1000 제조업체가 신석식품인
-- 새로운 제품정보를 제품 1뷰에 삽입해보자

INSERT INTO 제품1
VALUES ('p08', 1000, '신선식품');
-- noy null 제약조건이 설정된
-- prodname 컬럼에 값이 삽입되지 않아서 오류발생!
-- not null 제약조건을 해제하면 값을 삽입할 수 있음

-- 제품이름은 시원냉면, 재고량이 1000,
-- 제조업체가 신선식품이라는 새로운 제품정보를
-- 제품2 뷰를 통해 저장함

INSERT INTO 제품2
VALUES ('시원냉명',1000, '신석식품');
-- 기본키 제약조건이 설정된
-- prodid 컬럼에 값이 삽입되지 않아서 오류발생!

-- 뷰 삭제
-- drop view 뷰이름

-- 제품1, 제품2 삭제

DROP VIEW 제품1;

DROP VIEW 제품2;
 
-- 우수고객, 업체별제품수 삭제
DROP VIEW 우수고객;

DROP VIEW 업체별제품수;
























