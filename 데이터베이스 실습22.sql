-- 함수
-- 입력값(매개변수, parameter)를 전달받아
-- 특정 작업을 수행하고 결과를 반환return하는 코드묶음
-- 종류 : 내장함수, 사용자 정의 함수

-- 숫자함수
-- 절대값 계산 : abs(값)
SELECT abs(-4) FROM dual;

-- 반올림 계산 : round(값, 자릿수)
-- 자릿수가 음수인 경우, 정수부를 반올림함
SELECT round(123.456), round(123.456,1),
		round(123.456,2), round(123.456,-1)
FROM dual;

-- 무족건올림 : ceil(값)
-- 실수 이하 최대 정수를 구함 (0.5미만도 올림)
SELECT ceil(123.456), ceil(123.678)
FROM dual;

-- 무족건내림 : floor(값)
-- 실수 이하 최소 정수를 구함 (0.5이상도 내림)
SELECT floor(123.456), floor(123.678)
FROM dual;

-- 나머지 연산 : mod(값1, 값2)
SELECT 10/5, 10/3 FROM dual;
SELECT MOD(10,5), MOD(10,3) FROM dual;

-- 150초는 몇분 몇초인가? v1
SELECT floor(150/60), mod(150,60) FROM dual;

-- 난수생성 : dbms_random.명령어
-- value : 0 ~ 1 사이 임의의 실수
-- value (low, high) : low ~ high-1 사이 임의의 실수
-- string(char, len) : 지정한 길이만큼 다양한 문자를 난수로 생성
SELECT dbms_random.VALUE FROM dual;

SELECT floor(dbms_random.VALUE(0,10)) FROM dual;

-- 1 ~ 45 사이 임의의 숫자 6개 생성


SELECT
		floor(dbms_random.VALUE(1,45+1)) a, 
		floor(dbms_random.VALUE(1,45+1)) b,
		floor(dbms_random.VALUE(1,45+1)) c,
		floor(dbms_random.VALUE(1,45+1)) d,
		floor(dbms_random.VALUE(1,45+1)) e,
		floor(dbms_random.VALUE(1,45+1)) f
FROM dual;


-- 대문자upper 난수
SELECT dbms_random.string ('U', 10) FROM dual;

-- 소문자lower 난수
SELECT dbms_random.string ('L', 10) FROM dual;

-- 대소문자 난수
SELECT dbms_random.string ('A', 10) FROM dual;

-- 대소문자, 숫자 난수
SELECT dbms_random.string ('X', 10) FROM dual;

-- 문자, 숫자 난수
SELECT dbms_random.string ('P', 10) FROM dual;

-- 절사함수 : trunc(값, 옵션)
-- 숫자 뿐만 아니라 날짜나 시간 절사에도 사용

SELECT trunc(123.456), trunc(123.678),
		trunc(123.678, 1), trunc(123.678, 2),
		trunc(123.678, -1), trunc(123.678, -2)
FROM dual;

-- -78 과 +78의 절댓값을 구하시오
SELECT abs(-78), abs(78) FROM dual;
-- 4.875를 소수 첫쨰 자리까지 반올림한 값을 구하시오
SELECT ROUND(4.875, 1) FROM dual;

-- 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오
SELECT CUSTID, AVG(saleprice) 평균주문금액,
		 ROUND(AVG(saleprice), -2) 평균주문금액
FROM "ORDER"
GROUP BY CUSTID;





