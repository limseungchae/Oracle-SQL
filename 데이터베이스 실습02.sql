-- alter table 문
-- 컬럼 추가 : add
-- 데이터 타입, 길이 수정시 : modify
-- 컬럼명 수정시 : rename column
-- 컬럼 삭제시 : drop

-- 먼저, 학생 테이블 생성
-- 학번
CREATE	TABLE STUDENTS (
	hakbun	NUMBER
);

-- 여기에 이름, 주소, 나이 컬럼추가
-- alter table 테이블명 add 컬럼명 자료형 제약조건

ALTER	TABLE	STUDENTS
	ADD	name varchar2(10) NOT NULL;
	
-- 테이블 구조 확인 1
-- desc 테이블명

SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';
	


-- 테이블 구조 확인 2
-- select * from cls where table_name = 테이블명

-- 주소, 나이 컬럼추가
ALTER	TABLE	STUDENTS
	ADD addr	varchar2(50) NOT NULL;	

ALTER	TABLE	STUDENTS
	ADD	age		NUMBER	DEFAULT 0;

SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';
	
-- 컬럼명 변경
-- ALTER TABLE 테이블명
-- reaname column  컬럼명 to 새컬럼명
	

-- 주소컬럼명 변경 : addr -> address
ALTER	TABLE	STUDENTS	
	RENAME COLUMN addr TO address;
	
SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';
	
-- 컬럼 자료형 변경
-- alter table 테이블명 modify 컬럼명 새로운자료형

-- 생년월일 컬럼 추가 (문자형)
ALTER	TABLE STUDENTS	
	ADD bitrh char(10);

SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';

-- 생년월일 컬럼 변경 (날짜형)
ALTER	TABLE STUDENTS MODIFY birth DATE;	

SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';

-- 컬럼 삭제
-- alter table 테이블명 drop column 삭제할 컬럼명

-- 주소 컬럼 삭제
ALTER	TABLE STUDENTS	
	DROP COLUMN address;

SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';

-- 다중 추가/수정/삭제

ALTER	TABLE STUDENTS	ADD a char(1);
ALTER	TABLE STUDENTS	ADD b NUMBER;

ALTER	TABLE STUDENTS	
	ADD a char(1) ADD b NUMBER;

ALTER	TABLE STUDENTS	
	ADD (c char(1), d NUMBER , e DATE);

SELECT column_name, data_type FROM cols
	WHERE table_name = 'STUDENTS';

ALTER TABLE STUDENTS
	MODIFY a NUMBER MODIFY b char(1);

ALTER TABLE STUDENTS
	MODIFY (a NUMBER, b char(1));

--
ALTER TABLE STUDENTS
	DROP COLUMN a DROP COLUMN b; --(x)
	
ALTER TABLE STUDENTS DROP (a,b);

ALTER TABLE STUDENTS DROP (c,d,e);

--제약조건 정의
-- 컬럼단위 정의 : 컬럼 정의시 제약조건도 정의
-- 테이블 단위 정의 : 테이블 정리후 독립적으로 정의

-- 제약조건 조회
-- 제약조건 이름이 SYS로 시작함 :식별 어려움
SELECT constraint_name FROM ALL_CONSTRAINTS
	WHERE table_name = 'STUDENTS';

-- 제약조건 추가
-- alter table 테이블명
-- add constraint 제약조건명 제약조건

-- 제약조건명 작성규칙 1 : 테이블명약자_조약조건약자
-- 제약조건명 작성 규칙 2 : 테이블명약자_컬럼명약자_조약조건약자

-- 학생테이블에 기본키 추가
ALTER TABLE STUDENTS 
	ADD CONSTRAINT stud_pk PRIMARY KEY (hakbun);

SELECT constraint_name FROM ALL_CONSTRAINTS
	WHERE table_name = 'STUDENTS';

-- 과목테이블 생성
CREATE TABLE subjects (
	subjid		char(4),
	sudname 	varchar2(20),
	subdesc		varchar2(75),
	profid		char(3)
);

ALTER TABLE subjects	
	ADD CONSTRAINT subj_pk PRIMARY KEY (subjid);


-- 등록테이블에 기본키, 외래키 추가
CREATE TABLE registers (
	hakbun	NUMBER,
	subjid	char(4)
);

ALTER TABLE registers	
	ADD CONSTRAINT reg_pk PRIMARY KEY (hakbun, subjid);

ALTER TABLE registers
	ADD CONSTRAINT reg_hakbun_fk
	FOREIGN KEY (hakbun) REFERENCES SUBJECTS (hakbun)
	
ALTER TABLE registers
	ADD CONSTRAINT reg_subjid_fk
	FOREIGN KEY (subjid) REFERENCES SUBJECTS (subjid)
	

SELECT constraint_name FROM ALL_CONSTRAINTS
	WHERE table_name = 'REGISTERS';

-- 제약조건 제거
-- alter table 테이블명
-- drop constraint 제약조건명

-- 학생테이블에 생성된 제약조건 제거

-- 먼저 외래키부터 제거
ALTER TABLE STUDENTS 
	DROP CONSTRAINT reg_hakbun_fk;

ALTER TABLE STUDENTS 
	DROP CONSTRAINT stud_pk;

--제약조건 수정
--제약조건 수정명령은 제공되지 않음
-- 삭제후 재생서 추천



--madang 서점
CREATE TABLE book(
	bookid		NUMBER,
	bookname	varchar2(50) CONSTRAINT bknm_nn NOT null,	
	publisher	varchar(15)   CONSTRAINT pub_nn NOT null,
	price		NUMBER DEFAULT 0
);

--고객
CREATE TABLE customer(
	custid		NUMBER,
	name		varchar2(20) CONSTRAINT custnm_nn NOT null,
	address		varchar2(30) CONSTRAINT custaddr_nn NOT null,
	phone		char(13)     CONSTRAINT phone_nn NOT null
);

--주문
CREATE TABLE "ORDER"(
	orderid		NUMBER,	
	custid		NUMBER,
	bookid		NUMBER,
	saleprice	NUMBER		DEFAULT 0,
	orderdate	DATE		DEFAULT sysdate
);

--제약조건
ALTER TABLE registers
	ADD CONSTRAINT book_pk PRIMARY KEY (bookid);

--ALTER TABLE registers
--	ADD CONSTRAINT book_bknm_nn NOT NULL; (x)

ALTER TABLE book
	MODIFY bookname varchar2(50) NOT NULL;

ALTER TABLE book
	MODIFY bookname varchar2(15) NOT NULL;

--ALTER TABLE book
--	Madd constraint BOOK_PRC_df DEFAULT 0; (x)


ALTER TABLE customer
	ADD CONSTRAINT cust_pk PRIMARY KEY (custid);
	
ALTER TABLE "ORDER"
	ADD CONSTRAINT order_pk PRIMARY KEY (orderid);
	
ALTER TABLE "ORDER"
	ADD CONSTRAINT order_cust_fk
	FOREIGN KEY (cystid) REFERENCES customer (cystid);

ALTER TABLE "ORDER"
	ADD CONSTRAINT order_book_fk
	FOREIGN KEY (bookid) REFERENCES book (bookid);
	


--madang 판매점
CREATE TABLE customers(
	userid		varchar2(18),
	name		varchar2(15) 	CONSTRAINT usernm_nn NOT NULL,
	age			NUMBER 			DEFAULT 0,
	grade		varchar2(10) 	DEFAULT 'silver',
	job			varchar2(10)	CONSTRAINT userjb_nn NOT null
	mileage		NUMBER 			DEFAULT 0
);

-- 제품 products
CREATE TABLE products(
	prodid		char(3),
	prodname	varchar2(20)   CONSTRAINT prdum_nn NOT NULL,
	stock		NUMBER 			DEFAULT 0,
	price		NUMBER 			DEFAULT 0,
	maker	 	varchar2(20)   CONSTRAINT mkrnm_nn NOT NULL
);

-- 주문 orders
CREATE TABLE orders(
	ordrid		char(3),
	userid		varchar2(20),
	prodid		char(3),
	amount		NUMBER 			DEFAULT 0,
	addr		varchar2(25) 	CONSTRAINT oraddr_nn NOT NULL,
	orderdate	DATE 			DEFAULT sysdate
	);

ALTER TABLE customers
	ADD CONSTRAINT custs_pk PRIMARY KEY (userid);

-- check 제약조건
-- check 컬럼명 조건
ALTER TABLE customers
	ADD CONSTRAINT grd_chk
	CHECK  (grade='bronze'OR grade='silver'
		    OR grade='gold'OR grade='vip');

ALTER TABLE customers
	ADD CONSTRAINT grd_chk
	CHECK  (grade IN ('bronze','silver','gold','vip'));

ALTER TABLE products
	ADD CONSTRAINT prod_pk PRIMARY KEY (prodid);

ALTER TABLE orders
	ADD CONSTRAINT orders_pk PRIMARY KEY (ordrid);

ALTER TABLE orders
	ADD CONSTRAINT ordrs_usrid_fk
	FOREIGN KEY (userid) REFERENCES customers (userid);

ALTER TABLE orders
	ADD CONSTRAINT ordrs_prodid_fk
	FOREIGN KEY (prodid) REFERENCES products (prodid);

-- 제약조건 삭제
CREATE TAbLE abc123 (
	userid varchar(12),
	passwd varchar(12)
);

-- email 컬럼 추가
-- not null 제약조건도 추가
ALTER TABLE abc123
	ADD email varchar(50) NOT NULL;

SELECT CONSTRAINT_name, FROM ALL_CONSTRAINTS
	WHERE table_name = 'ABC123';

-- 제약조건 제거시
-- 이름을 따로 지정하지 않으면
-- 시스템이 자동으로 부여해 줌 (sys_?????)
-- 삭제시 해당 제약조건의 이름을 확인해야하는 불편 존재

ALTER TABLE abc123
	DROP CONSTRAINT sys_c007120;

SELECT CONSTRAINT_name, FROM ALL_CONSTRAINTS
	WHERE table_name = 'ABC123';

-- 테이블 삭제
-- DROP TABLE 테이블명
-- 단, 외래키가 설정된 테이블은
-- 먼저 외래키 제약조건을 삭제해야함!

DROP TABLE bc123;

-- 외래키에 의해 참조중인 테이블이므로,
-- 테이블을 바로 삭제할 수 없음

DROP TABLE CUSTOMER;











































