-- PL/SQL의 구조 : 선언부/실행부/예외처리부

-- 익명 프로시져 : 이름이 없는 프로시져

BEGIN -- PL/SQL 블럭 시작
	dbms_output.put_line('Hello,World!!!');
END;	  -- PL/SQL 블럭 끝



-- 프로시져 procedure
-- 익명 프로시져는 선언부에 정의하고 실행부에서 호출되어 실행
-- 실행할때 마다 컴파일되어야 하므로 속도가 느림
-- 다른 PL/SQL에서 호출해서 사용 불가 : 코드 재사용 불가

-- 익명 프로시져의 주 용도는 코드 실행 후 테스트 목적
-- 한번 실행하고나면 메모리에서 없어지는 휘발성 코드
-- 실행한 코드를 데이터베이스 내에 남겨
-- 재사용을 가능하게 하려면 함수나 프로시져를 작성

-- 사용자 정의 함수
-- 오라클은 내장함수를 통해 다양한 기능을 제공
-- 사용자가 임의로 코드를 작성해서 함수를 만들수 있음
-- 함수는 매개변수(입력값)를 받아 뭔가를 처리하고
-- 그 결과를 반환하는 데이터베이스 객체

-- create or replace function [-] (매개변수,...)
-- return 데이터유형;
-- is
-- 함수 몸체 블록

-- 간단한 인삿말 출력 - sayHello
CREATE OR REPLACE FUNCTION sayhello
	RETURN varchar
IS 
BEGIN 
	RETURN('Hello,World!!!');
END;

-- 함수 실행
SELECT sayHello() FROM dual; -- Hello,Java!!


-- 간단한 인삿말 출력 -sayhello2 함수 정의
-- create ... 함수명(변수명 자료형)
CREATE OR REPLACE FUNCTION sayhello2(msg varchar)
	RETURN varchar
IS 
BEGIN 
	RETURN('Hello' || msg || '!!!');
END;

--- 함수 실행
SELECT sayHello2('Java') FROM dual; -- Hello,Java!!
SELECT sayHello2('Oracle') FROM dual; -- Hello,Oracle!!
SELECT sayHello2('수지') FROM dual; -- Hello,수지!!

-- 두개의 정수를 입력받아 사칙연산후 결과 출력
CREATE OR REPLACE FUNCTION
			num2compute(x number,y number)
	RETURN varchar
IS 
BEGIN
	RETURN (to_char (x + y) || ',' || 
			to_char (x - y) || ',' ||
			to_char (x * y) || ',' ||
			to_char (x / y, '0.99') );
END;

SELECT num2compute(10,100) FROM dual;
SELECT num2compute(1,10) FROM dual;

-- 변수를 사용하는 사용자 정의 함수
CREATE OR REPLACE FUNCTION
			num2compute2(x number,y number)
	RETURN varchar
IS 
	z1 NUMBER;
	z2 NUMBER;
	z3 NUMBER;
	z4 NUMBER;
BEGIN
	z1 := x + y;
	z2 := x - y;
	z3 := x * y;
	z4 := x / y;
	
	RETURN (to_char (z1) || ',' || to_char (z2) || ',' || to_char (z3) || ',' || to_char (z4, '0.99') );
END;

SELECT num2compute2(1,10) FROM dual;

-- 도서번호를 입력하면 해당 도서의 상세정보 출력하는 함수
-- showbookinfo(bookid)
-- 단, 조회결과는 단일행 이여야 함!!

CREATE OR REPLACE FUNCTION showbookinfo(bkid number)
	RETURN varchar
IS 
	-- 변수 선언
	bkname varchar(100);
	pubname varchar(100);
	price number;
BEGIN 
	-- book테이블에서 도서를 조회하고
	-- 조회결과를 각 변수에 담음
	SELECT bookname, publisher, price 
	INTO bkname, pubname, price
	FROM book WHERE bookid = bkid;
	
	RETURN (bkid || ',' ||
			bkname || ',' ||
			pubname ||  ',' || price);
END;

SELECT showbookinfo(1) FROM dual;
SELECT showbookinfo(5) FROM dual;
SELECT showbookinfo(0) FROM dual;































