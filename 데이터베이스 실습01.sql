-- 노트북 테이블 생성
-- 노트북명, 가격, 출시일, 특징
CREATE TABLE NOTEBOOKS(
	nbno		NUMBER,			
	nbname		varchar2(100) NOT NULL, -- 가변문자열
	price		NUMBER DEFAULT 0,			-- 숫자형
	rlsdate		DATE NOT NULL,			-- 날짜형
	descrpt		clob,			-- 대량텍스트
	PRIMARY KEY (nbno)			-- 기본키 제약조건
);

-- 도서 테이블 생성
-- 도서명, 저자, 출판사, 가격, 할인율, 출판일, 소개
CREATE TABLE books(
	bkno		NUMBER,
	bkname		varchar2(100) NOT null,
	author		varchar2(100) NOT null,
	publisher	varchar2(100) NOT null,
	price		NUMBER DEFAULT 0,
	dsrate		NUMBER(5,1) NOT null,
	pubdate		DATE NOT null,
	intro		clob,
	PRIMARY KEY (bkno)
);

-- 게시판 테이블 생성
-- 글번호, 제목, 작성자, 작성일, 조회수, 본문
CREATE TABLE boards (
	bno			NUMBER,
	title		varchar2(100) NOT null,
	userid		char(18) NOT null,
	regdate		DATE DEFAULT sysdate,
	views		NUMBER DEFAULT 0,
	contents	clob,
	PRIMARY KEY (bno)
);

-- 도서 테이블 생성
-- 도서번호, 도서이름, 출판사, 정가
CREATE TABLE book(
	bookid		NUMBER,
	bookname	varchar2(50) NOT null,	
	publisher	varchar2(15) NOT null,
	price		NUMBER DEFAULT 0,
	PRIMARY KEY (bookid)
);

-- 고객 테이블 생성
-- 고객번호 순서, 이름, 주소, 전화번호
CREATE TABLE customer(
	custid		NUMBER,
	name		varchar2(20) NOT null,
	address		varchar2(30) NOT null,
	phone		char(13),
	PRIMARY KEY (custid)
);

-- 주문 테이블생성
-- 주문번호, 고객번호, 도서번호, 판매가격, 주문날짜
CREATE TABLE "ORDER"(
	orderid		NUMBER,	
	custid		NUMBER NOT null,
	bookid		NUMBER NOT null,
	saleprice	NUMBER DEFAULT 0,
	orderdate	DATE DEFAULT sysdate,
	PRIMARY KEY (orderid),
	FOREIGN KEY (custid) REFERENCES customer (custid),
	FOREIGN KEY (bookid) REFERENCES book (bookid)
);

--현재 날짜 시간 조회
-- dual : 가상(더미dummy) 테이블
SELECT sysdate FROM dual;

-- 고객 customers --https://vo.la/hDyYs 03 예제 1
-- 고객아이디, 고객이름, 나이, 등급, 직업, 적립금
CREATE TABLE customers(
	userid		varchar2(18),
	name		varchar2(15) NOT null,
	age			NUMBER DEFAULT 0,
	grade		varchar2(10) DEFAULT 'silver',
	job			varchar2(10) NOT null,
	mileage		NUMBER DEFAULT 0,
	PRIMARY KEY (userid)	
);

-- 제품 products --https://vo.la/hDyYs 03 예제 2
-- 제품번호, 제품명, 재고량, 단가, 재조업체
CREATE TABLE products(
	prodid		char(3),
	prodname	varchar2(20) NOT null,
	stock		NUMBER DEFAULT 0,
	price		NUMBER DEFAULT 0,
	maker	 	varchar2(20) NOT null,
	PRIMARY KEY (prodid)
);

-- 주문 orders --https://vo.la/hDyYs 03 예제 3
-- 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자
CREATE TABLE orders(
	ordrid		char(3),
	userid		varchar2(20) NOT null,
	prodid		char(3) NOT null,
	amount		NUMBER DEFAULT 0,
	addr		varchar2(25) NOT null,
	orderdate	DATE DEFAULT sysdate,
	PRIMARY KEY (ordrid),
	FOREIGN KEY (userid) REFERENCES customers (userid),
	FOREIGN KEY (prodid) REFERENCES products (prodid)
	);



