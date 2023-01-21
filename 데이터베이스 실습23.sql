-- 문자함수

-- 대소문자 변환 : upper/lower
SELECT upper ('abc'), lower('ABC') FROM dual;

-- 문자추출함수 : substr(값, 위치, 길이)
-- 지정한 위치에서 지정한 길이의 문자 추출
-- 위치는 1부터 시작

-- 다음 숫자묶음에서 567을 추출
SELECT substr('123456789', 5, 3) FROM dual;

-- 주민번호 (123456-1234567)에서 성별 코드 추출
SELECT substr('123456-1234567', 8, 1) 성별코드 FROM dual;

-- 문자열 결합 : concat(문자1, 문자2)
SELECT concat('Hello','World!!') FROM dual;

SELECT concat(concat('Hello','' ),'''World!!') FROM dual;

-- 150초는 몇분 몇초인가? v2
SELECT concat(trunc (150/60),'분'),
		concat(mod(150,60), '초') FROM dual;
	
SELECT concat(concat(trunc (150/60),'분'),
		concat(mod(150,60), '초')) FROM dual;
	
-- 문자열 변경 : replace (값, 찾을문자, 변경문자)

-- worlde라는 문자열을 Oracle로 변경
SELECT REPLACE('Hello,World!!', 'World', 'Oacle') 
FROM dual;

-- 문자열 내 문자 위치 파악 : instr(값, 찾을문자, 옵션)
-- 문자를 찾지 못하는 경우 0이 반환
SELECT INSTR('Hello,World!!', 'World') 
FROM dual;

-- 3번쨰 or의 위치는?
SELECT INSTR('Oracle corporate', 'or') 
FROM dual;

SELECT INSTR('Oracle corporate', 'or',11) 
FROM dual;	-- 시작 위치 지정

SELECT INSTR('Oracle corporate', 'or',-1) 
FROM dual;	-- 오른쪽을 시작위치로 문자 위치 찾음


-- 문자열 길이 : length(값), length(값)
SELECT LENGTH(123), LENGTH('abc'),LENGTH('가나다') FROM dual;

SELECT LENGThb(123), LENGTHb('abc'),LENGTHb('가나다') FROM dual;

-- 문자열 채움 : lpab(값, 너비, 채움문자), rpad(값, 너비, 채움문자)
-- 문자열의 자릿수를 일정하게 맞추기 위해 사용
SELECT 123, lpad(123, 10,'0'),
		lpad(1234567890, 10,'0') FROM dual;
		
SELECT 123, rpad(123, 10,'0'),
		rpad(1234567890, 10,'0') FROM dual;

-- 1234-5678 이라는 전화번호에 지역번호를 추가하세요
SELECT lpad('1234-5678',13,'010-')FROM dual;

-- 고백제거, 문자 채움
-- trim(값, 제거대상), ltrim, rtrim
SELECT ' abc ', trim(' abc '), 
	ltrim(' abc '), rtrim(' abc ')
FROM dual; -- 앞뒤 공백제거

SELECT trim(' abc123 '),  -- trim은 공백만 제거
	ltrim('abc123', 'abc'), 
	rtrim('abc123', '123')
FROM dual;

SELECT trim ('abc' FROM 'abc123')
FROM dual; -- 문자 사용불가

SELECT trim (' ' FROM 'abc123')
FROM dual; -- 공백 제거 가능

SELECT trim ('0' FROM '00001111')
FROM dual; -- 슷자 제거 가능

SELECT trim ('1' FROM '00001111')
FROM dual; -- 슷자 제거 가능

SELECT trim ('1' FROM '0000abc0000'),
	trim (LEADING '0' FROM '0000abc0000'),
	trim (TRAILING '0' FROM '0000abc0000')
FROM dual; -- trim함수로 ltrim, rtrim 구현

-- 아스키 코드 변환 : ascii(문자)
-- 문자에 대응하는 ascii 코드값 출력
-- 아스키 코드는 영문자와 제어문자에 
-- 대한 숫자(10진수, 16진수) 변환 체계
SELECT ASCII('A'), ASCII('a'), ASCII('1')
FROM dual;

-- 문자 변환 : chr(코드값)
-- 아스키 코드값에 대응하는 문자 출력
SELECT chr(65), chr(97), chr(49)
FROM dual;

-- 도서제목에 야구가 포함된 도서를 농구로 변경한후 도서목록 확인
SELECT * FROM  BOOK; 
SELECT BOOKNAME, REPLACE(BOOKNAME, '야구', '농구')  FROM BOOK b;

-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인.
-- 한글은 2바이트 혹은 UNICODE 경우는 3바이트를 차지함.
SELECT BOOKNAME, PUBLISHER, LENGTH (BOOKNAME) 글자수,
	LENGTHB (BOOKNAME) 바이트수
FROM BOOK
WHERE PUBLISHER ='굿스포츠';

-- 마당서점 고객중에서 같은 성 을 가진 사람이 몇명인 인원수 확인
SELECT * FROM CUSTOMER ;

SELECT SUBSTR(NAME,1,1) 성, COUNT(CUSTID) 인원 
FROM CUSTOMER
GROUP BY SUBSTR(NAME,1,1)
ORDER BY 인원 DESC, 성;

-- null 처리함수 : nvl(대상, ntll일때값)
-- nvl2(대상, ntll일때값)

-- 전화번호가 null이면 xxx-xxxx-xxxx로 출력
SELECT name, PHONE , 
	nvl(PHONE,'xxx-xxxx-xxxx') 전화번호
FROM  CUSTOMER;

-- 전화번호가 null이면 번호없음,null이아니면 번호있음으로 출력
SELECT name, PHONE , 
	nvl2(PHONE,'번호있음','번호없음') 전화번호
FROM  CUSTOMER;

-- 다중조건문 : decode(값, 조건1, 값1, 조건2, 값2, 값3)
-- oracle 전용 함수, 많이 사용함
-- case when으로도 많이 사용

-- 출판사가 이상미디여면 상급, 대한미디어면 중급, 
-- 굿스포츠면 하급, 나머지는 보통으로 출력
SELECT PUBLISHER,
decode(PUBLISHER,'이상미디여','상급',
		'대한미디어','중급',
		'굿스포츠','하급','보통') 등급
FROM  BOOK;





