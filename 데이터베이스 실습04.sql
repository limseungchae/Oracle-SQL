-- 데이터 저장/삽입 - insert
-- 생성한 테이블에 레코드를 삽입하는 명령

-- insert into 테이블명 [(컬럼명,...)]
-- valuer (삽입할값들,...)

-- 회원테이블 생성
-- 회원번호,아이디,비번,이름,이메일
CREATE TABLE members (
	mbrid	NUMBER,
	userid	varchar(18),
	passwd	varchar(18),
	name 	varchar(15),
	email	varchar(50)
);

-- 회원테이블에 회원정보(레코드) 입력
-- 날짜, 문자입력시 ''를 사용

-- 각 데이터를 테이블 컬럼순서대로 입력
INSERT INTO members
VALUES (1,'abc123' ,'987xyz', 'abcxyz', 'abc123@987xyz.com');

-- 각 데이터를 테이블 컬럼순서대로와 상관없이  입력
INSERT INTO members (name, email, mbrid, userid, passwd)
VALUES ('xyz987', 'xyz987@abc123.com', 2, 'xyz987', 'abc123');

-- 입력된 테이터 확인
SELECT * FROM members;

-- 일부 데이터를 테이블 입력
-- 입력대상 : 회원번호,아이디,비번,이름
INSERT INTO members
(mbrid, userid, passwd, name)
VALUES (3, 'abc456', '456xyz', 'abc456');

SELECT * FROM members;


-- 마당서점
CREATE TABLE book (
	bookid		NUMBER,
	bookname	varchar(30),
	publisher	varchar(20),
	price		NUMBER	
);

INSERT	INTO book values ('1', '축구의 역사', '굿스포츠', '7000');
INSERT	INTO book values ('2', '축구의 아는 여자', '나무수', '13000');
INSERT	INTO book values ('3', '축구의 이해', '대한미디어', '22000');
INSERT	INTO book values ('4', '골프 바이블 ', '대한미디어', '35000');
INSERT	INTO book values ('5', '피겨 교본', '굿스포츠', '8000');
INSERT	INTO book values ('6', '역도 단게별 기술', '대한미디어', '6000');
INSERT	INTO book values ('7', '야구의 추억', '이상미디어	', '20000');
INSERT	INTO book values ('8', '야구를 부탁해', '이상미디어', '13000');
INSERT	INTO book values ('9', '올림픽 이야기', '삼성당', '7500');
INSERT	INTO book values ('10', 'Olymepic Champions', 'Pearson', '13000');

SELECT * FROM book;

CREATE TABLE "ORDER" (
	orderid		NUMBER,
	custid		NUMBER,
	bookid		NUMBER,
	saleprice	NUMBER,
	orderdate	date
);

INSERT INTO "ORDER" VALUES (1, 1, 1, 6000, '2020-07-01');
INSERT INTO "ORDER" VALUES (2, 1, 3, 21000, '2020-07-03');
INSERT INTO "ORDER" VALUES (3, 2, 5, 8000, '2020-07-03');
INSERT INTO "ORDER" VALUES (4, 3, 6, 6000, '2020-07-04');
INSERT INTO "ORDER" VALUES (5, 4, 7, 20000, '2020-07-05');
INSERT INTO "ORDER" VALUES (6, 1, 2, 12000, '2020-07-07');
INSERT INTO "ORDER" VALUES (7, 4, 8, 13000, '2020-07-07');
INSERT INTO "ORDER" VALUES (8, 3, 10, 12000, '2020-07-08');
INSERT INTO "ORDER" VALUES (9, 2, 10, 7000, '2020-07-09');
INSERT INTO "ORDER" VALUES (10, 3, 8, 13000, '2020-07-10');

SELECT * FROM "ORDER";

CREATE TABLE customer (
	custid	NUMBER,
	name	varchar(20),
	address	varchar(30),
	phone	char(13)
);

INSERT INTO customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO customer VALUES (5, '박세리', '대한민국 대전', NULL);

SELECT * FROM customer;

-- 마당 상점

/* customers, products, orders 데이터 생성 */


CREATE TABLE customers(
	userid		varchar2(18),
	name		varchar2(15),
	age			NUMBER,
	grade		varchar2(10) ,
	job			varchar2(10) ,
	mileage		NUMBER
);

INSERT INTO customers VALUES ('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO customers VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO customers VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500);
INSERT INTO customers VALUES ('orange', '김용욱', 22, 'silver', '학생', 0);
INSERT INTO customers VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO customers VALUES ('peach', '오형준', NULL, 'silver', '의사', 300);
INSERT INTO customers VALUES ('pear', '채광주', 31, 'silver', '회사원', 500);


CREATE TABLE products(
	prodid		char(3),
	prodname	varchar2(20),
	stock		NUMBER,
	price		NUMBER,
	maker	 	varchar2(20),
);

INSERT INTO products VALUES ('p01', '그냥만두', 5000, 4500, '대한식품');
INSERT INTO products VALUES ('p02', '매운쫄면', 2500, 5500, '민국푸드');
INSERT INTO products VALUES ('p03', '쿵떡파이', 3600, 2600, '한빛제과');
INSERT INTO products VALUES ('p04', '맛난초콜릿', 1250, 2500, '한빛제과');
INSERT INTO products VALUES ('p05', '얼큰라면', 2200, 1200, '대한식품');
INSERT INTO products VALUES ('p06', '통통우동', 1000, 1550, '민국푸드');
INSERT INTO products VALUES ('p07', '달콤비스킷', 1650, 1500, '한빛제과');


CREATE TABLE orders (
	orderid		NUMBER,	
	custid		NUMBER,
	bookid		NUMBER,
	saleprice	NUMBER,
	orderdate	DATE  
);

INSERT INTO orders VALUES ('o01', 'apple', 'p03', 10, '서울시 마포구', '2022-01-01');
INSERT INTO orders VALUES ('o02', 'melon', 'p01', 5, '인천시 계양구', '2022-01-10');
INSERT INTO orders VALUES ('o03', 'banana', 'p06', 45, '경기도 부천시', '2022-01-11');
INSERT INTO orders VALUES ('o04', 'carrot', 'p02', 8, '부산시 금정구', '2022-02-01');
INSERT INTO orders VALUES ('o05', 'melon', 'p06', 36, '경기도 용인시', '2022-02-20');
INSERT INTO orders VALUES ('o06', 'banana', 'p01', 19, '충청북도 보은군', '2022-03-02');
INSERT INTO orders VALUES ('o07', 'apple', 'p03', 22, '서울시 영등포구', '2022-03-15');
INSERT INTO orders VALUES ('o08', 'pear', 'p02', 50, '강원도 춘천시', '2022-04-10');
INSERT INTO orders VALUES ('o09', 'banana', 'p04', 15, '전라남도 목포시', '2022-04-11');
INSERT INTO orders VALUES ('o10', 'carrot', 'p03', 20, '경기도 안양시', '2022-05-22');

-- scott/tiger 계정에 대한
-- 오라클 접속 profile 생성후
-- scott 계정이 소유한 테이블들도 백업









