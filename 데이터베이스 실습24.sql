
-- EMPLOYEES 테이블에서 King의 정보를 소문자로 검색하고 사원번호, 성명, 담당업무(소문자로),부서번호를 출력하라.
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,
		lower(JOB_ID), DEPARTMENT_ID
FROM EMPLOYEES 
WHERE lower(LAST_NAME) = lower('king') 
	OR lower(FIRST_NAME) = lower('king') ;

-- EMPLOYEES 테이블에서 King의 정보를 대문자로 검색하고 사원번호, 성명, 담당업무(대문자로),부서번호를 출력하라.
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,
		UPPER(JOB_ID), DEPARTMENT_ID
FROM EMPLOYEES 
WHERE UPPER(LAST_NAME) = UPPER('King') 
	OR UPPER (FIRST_NAME) = UPPER('King') 

-- DEPARTMENTS 테이블에서 (부서번호와 부서이름), 부서이름과 위치번호를 합하여 출력하도록 하라.
SELECT 	CONCAT(DEPARTMENT_ID, DEPARTMENT_NAME),
		CONCAT(DEPARTMENT_ID, LOCATION_ID)
FROM DEPARTMENTS;

SELECT DEPARTMENT_ID || '' || DEPARTMENT_NAME,
		DEPARTMENT_ID || '' || LOCATION_ID
FROM DEPARTMENTS;

-- EMPLOYEES 테이블에서 이름의 첫 글자가 ‘K’ 보다 크고 ‘Y’보다 적은 사원의 정보를
-- 사원번호, 이름, 업무, 급여, 부서번호를 출력하라.
-- 단 이름순으로 정렬하여라.
SELECT 
	EMPLOYEE_ID ,FIRST_NAME ,JOB_ID ,SALARY ,
	DEPARTMENT_ID 
FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME,1,1) > 'K' 
AND SUBSTR(FIRST_NAME,1,1) < 'Y'
ORDER BY FIRST_NAME;

-- EMPLOYEES 테이블에서 20번 부서 중 이름의 길이 및 급여의 자릿수를 사원번호, 이름, 이름의 자릿수(LENGTH), 급여, 급여의 자릿수를 출력하라.
SELECT EMPLOYEE_ID 사원번호, LAST_NAME 이름,
	LENGTH(LAST_NAME) 이름자릿수, SALARY 급여,
	LENGTH(SALARY) 급여자릿수
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;

-- EMPLOYEES 테이블에서 이름 중 ‘e’자의 위치를 출력하라.
SELECT FIRST_NAME, INSTR(FIRST_NAME,'e'),
	INSTR(lower(FIRST_NAME),'e') 
FROM EMPLOYEES;

-- 다음의 쿼리를 실행하고 결과를 출력하고 확인하라.
 SELECT  ROUND(4567.678), 	  -- 4568
         ROUND(4567.678, 0), -- 4568
         ROUND(4567.678, 2), -- 4567.68
        ROUND(4567.678, -2) FROM dual; -- 4600


-- EMPLOYEES 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈 나머지를 구하여 출력하라.
SELECT DEPARTMENT_ID , MOD(SALARY,30) 
FROM EMPLOYEES e
WHERE DEPARTMENT_ID = 80 ;

-- EMPLOYEES 테이블에서 30번 부서 중 이름과 담당 업무를 연결하여 출력하여라.
SELECT concat(FIRST_NAME, JOB_ID),
	FIRST_NAME || ' ' || JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

-- EMPLOYEES 테이블에서 50번 부서 사원의 이름, 부서번호,급여 를 출력하라 
-- 단, 급여 앞에 $를 삽입하고 3자리마다 ,를 출력하라
SELECT FIRST_NAME, DEPARTMENT_ID, 
	SALARY, CONCAT ('$',SALARY)
FROM EMPLOYEES e
WHERE DEPARTMENT_ID = 50;

-- EMPLOYEES 테이블에서 현재까지 근무일 수가 몇주 몇일 인가를 출력하여라.
-- 단 근무 일수가 많은 사람 순으로 출력하여라.
SELECT FIRST_NAME 이름, 
		to_char(HIRE_DATE,'yyyy-mm-dd') 입사일,
		to_char(sysdate,'yyyy-mm-dd')  현재일,
		trunc(sysdate) - HIRE_DATE,
		trunc(sysdate - HIRE_DATE) || '일' 총근무일수,
		trunc((sysdate - HIRE_DATE) / 7) 총근무주수,
		trunc (MOD(sysdate - HIRE_DATE, 7)) 나머지일수
FROM EMPLOYEES;

-- 사원 테이블에서 이름의 끝자리가
-- N으로 끝나는 사원의 정보를 출력하세요.
SELECT FIRST_NAME ,JOB_ID ,DEPARTMENT_ID 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%n';

-- steven
SELECT FIRST_NAME ,JOB_ID ,DEPARTMENT_ID 
FROM EMPLOYEES
WHERE substr(FIRST_NAME,LENGTH(FIRST_NAME) ,1) = 'n';

SELECT FIRST_NAME ,JOB_ID ,DEPARTMENT_ID 
FROM EMPLOYEES
WHERE substr(FIRST_NAME,-1 ,1) = 'n';

-- 사원들의 급여가 평균보다 큰 경우 '평균급여이상'이라 출력하고
-- 아닌 경우 '평균급여이하' 라고 출력하세요

-- decode : 검사대상과 값이 일치할떄 적절한 값으로 처리
-- case when : 검사대상이 지정한 조건을 만족할때 적절한 값으로 처리

-- case when 조건1 then 처리1
--		WHEN 조건2 the 처리2
--		ELSE 처리3
-- end

SELECT round(avg(SALARY)) FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY,
		CASE WHEN SALARY < 6462 THEN  '평균이하'
			 ELSE '평균이상'
		END 급여평가
FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY,
		CASE WHEN SALARY < (SELECT avg(SALARY) 
								FROM EMPLOYEES) 
			THEN '평균이하'
		    ELSE '평균이상'
		END 급여평가
FROM EMPLOYEES;


-- 사원들을 입사일자가 빠른 순으로
-- 정렬한 뒤 본인보다 입사일자가 빠른
-- 사원의 급여를 본인의 급여와 함께 출력하세요
SELECT FIRST_NAME, HIRE_DATE, SALARY  
FROM EMPLOYEES
ORDER BY HIRE_DATE;

-- AND나 BETWEEN을 사용하지 않고
-- 2002 년도에 입사한 직원의 이름과
-- 월급을 출력하세요.
SELECT HIRE_DATE, FIRST_NAME, SALARY  
FROM EMPLOYEES
WHERE HIRE_DATE >= '2002-01-01'
		AND HIRE_DATE <= '2002-12-31'
ORDER BY HIRE_DATE;

SELECT HIRE_DATE, FIRST_NAME, SALARY  
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2002-01-01'
		AND '2002-12-31'
ORDER BY HIRE_DATE;

SELECT HIRE_DATE, FIRST_NAME, SALARY  
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '2002%'
ORDER BY HIRE_DATE;

SELECT HIRE_DATE, FIRST_NAME, SALARY  
FROM EMPLOYEES
WHERE SUBSTR(HIRE_DATE, 1, 4) = '2002'
ORDER BY HIRE_DATE;

-- 사원 테이블에서 사원의 이름이
-- 5글자인 사원의 이름을 첫글자만 대문자로 출력하세요.
SELECT 
	FIRST_NAME, SUBSTR(FIRST_NAME, 1, 1) 첫글자 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_____';
ORDER BY FIRST_NAME;

SELECT 
	FIRST_NAME, SUBSTR(FIRST_NAME, 1, 1) 첫글자 
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) = 5
ORDER BY FIRST_NAME;

-- 사원 테이블에서 이름과 입사일자
-- 그리고 현재날까지의 경과일을 산출하세요
-- (소숫점을 빼버리고 해당이름을 경과일로 바꾸세요)
SELECT 
	FIRST_NAME, HIRE_DATE,
	TO_char(trunc(sysdate) - HIRE_DATE, 
				'9,999') || '일' 경과일
FROM EMPLOYEES;

-- 이전문제에서 경과일을 개월수로 바꿔서
-- 산출하세요. 소숫점을 빼버리고
-- 해당이름을 경과개월수로 바꾸세요
SELECT 
	FIRST_NAME, HIRE_DATE,
	trunc((trunc(sysdate) - HIRE_DATE) / 30.5) 개월수,
	trunc(MONTHS_BETWEEN(sysdate, HIRE_DATE)) 경과개월수
FROM EMPLOYEES;

-- 사원 테이블에서 입사후 6개월이
-- 지난날짜 바로 다음 일요일을 구하세요.
SELECT 
	FIRST_NAME, 
	to_char (HIRE_DATE, 'yyyy-mm-dd') 입사일,
	to_char (HIRE_DATE + (30.5 * 6), 'yyyy-mm-dd') a,
	to_char(add_months (HIRE_DATE, 6), 'yyyy-mm-dd') b,
	next_day(add_months (HIRE_DATE, 6), '일요일') c
FROM EMPLOYEES;

-- 교육시작일이 2020-12-19인 경우,
-- 5개월(18주)이 지난후 돌아오는 첫번째 금요일이
-- 언제인지 조회하세요 (5개월(18주) : 2021-03-08)
SELECT 
	to_date('2022-12-19', 'yyyy-mm-dd') a,
	add_months(to_date('2022-12-19', 'yyyy-mm-dd'), 5) b,
	NEXT_DAY(add_months(
	to_date('2022-12-19', 'yyyy-mm-dd'),5), '금') 
FROM dual;

SELECT 
	add_months('2022-12-19', 5) a,
	NEXT_DAY(add_months('2022-12-19', 5), '금') b 
FROM dual;
 
-- 교육시작일이 2020-12-19인 경우,
-- 131일이 지난후 돌아오는 첫번째 금요일이
-- 언제인지 조회하세요 (131일후 : 2021-03-25)
SELECT 
	to_date('2022-12-19') + 131 a,
	next_day(to_date('2022-12-19') + 131, '금') b
FROM dual;


-- 사원 테이블에서 입사후
-- 첫 휴일(일요일)은 언제일지 구하세요
SELECT 
	FIRST_NAME, 
	to_char(HIRE_DATE, 'yyyy-mm-dd') a,
	to_char (NEXT_DAY(HIRE_DATE, '일'),'yyyy-mm-dd') b 
FROM EMPLOYEES;

-- 오늘날짜를 "xx년 xx월 xx일" 형식으로 출력하세요
SELECT 
	SYSDATE,
	to_char(sysdate, 'yyyy"년"-mm"월"-dd"일"') a
FROM dual;

-- 지금 현재 '몇시 몇분'인지 출력하세요.
-- AWS RDS의 시간은 미국 기준
-- 한국 기준시로 변경하고 싶다면 서버설정변경(time-zone) 필요
-- 한국은 UTC 기준 9시간 추가 : KST = UTC + 9
SELECT 
	sysdate,
	to_char(sysdate, 'am hh"시"-mi"분"') 한국시,
	to_char(sysdate - (9/24), 'am hh"시"-mi"분"') 미국시
FROM dual;

-- 이번 년도 12월 31일까지 몇일이
-- 남았는지 출력하세요.
SELECT 
	to_date('2022-12-31','yyyy-mm-dd')
		- trunc(sysdate) 연말까지남은이수
FROM dual;

-- 사원들의 입사일에서
-- 입사 년도와 입사 달을 조회하세요
SELECT 
	FIRST_NAME,
	to_char(HIRE_DATE,'yyyy-mm-dd') a,
	to_char(HIRE_DATE,'yyyy"년"mm"월"') b
FROM EMPLOYEES e ;


-- 9월에 입사한 사원을 조회하세요
-- 2022-03-15
SELECT 
	FIRST_NAME,
	to_char(HIRE_DATE,'yyyy-mm-dd') a
FROM EMPLOYEES
WHERE substr(HIRE_DATE, 7, 1) = '9';

-- 입사일에서 '09'라는 문자의 위치 확인
SELECT 
	to_char(HIRE_DATE,'yyyy-mm-dd') a,
	instr(HIRE_DATE, '09') b
FROM EMPLOYEES;

SELECT 
	FIRST_NAME,
	to_char(HIRE_DATE,'yyyy-mm-dd') a
FROM EMPLOYEES
WHERE instr (HIRE_DATE, '09') = 6;

-- 사원들의 입사일을 출력하되,
-- 요일까지 함께 조회하세요
SELECT 
	FIRST_NAME,
	to_char(HIRE_DATE,'yyyy-mm-dd day') a,
	to_char(HIRE_DATE,'yyyy-mm-dd dy') b,
	to_char(HIRE_DATE,'dl') c
FROM EMPLOYEES

-- 사원들의 급여를 통화 기호를 앞에 붙이고
-- 천 단위마다 콤마를 붙여서 조회하세요
SELECT 
	FIRST_NAME,
	to_char(SALARY ,'$99,999') a,
	to_char(round(SALARY * 1262.44),'L99,999,999') b
FROM EMPLOYEES;

-- 사원들의 급여를 10자리로 출력하되
-- 자릿수가 남는 경우 빈칸으로 채워서 조회하세요
-- _____12345
SELECT 
	FIRST_NAME,
	'|' || to_char(SALARY ,'$9,999,999,999') a,
	'|' || to_char(SALARY ,'$0,000,000,009') b,
	'|' || to_char(SALARY ,'FM$9,999,999,999') c
FROM EMPLOYEES;

SELECT 
	FIRST_NAME,
	'|' || lpad (SALARY, 10, ' ') a, -- 공백 채움
	'|' || lpad (SALARY, 10, '0') b  -- 0으로 채움
FROM EMPLOYEES;


-- 각 사원들의 근무한 개월 수를 현재를
-- 기준으로 구하세요

 


-- 각 사원들의 입사일에서
-- 4개월을 추가한 날짜를 조회하세요
SELECT 
	FIRST_NAME, HIRE_DATE,
	to_char(HIRE_DATE, 'dl') a,
	to_char(ADD_MONTHS(HIRE_DATE, 4), 'dl') c
FROM EMPLOYEES


-- 각 사원들의 입사한 달의 마지막 날을
-- 조회하세요
SELECT 
	FIRST_NAME, HIRE_DATE,
	to_char(HIRE_DATE, 'dl') a,
	to_char(LAST_day(HIRE_DATE), 'dl') c
FROM EMPLOYEES





-- 이름과 성을 입력하면
-- 사번, 입사일, 직책, 연봉, 부서번호, 부서명등을
-- 출력하는 함수 작성 (showempinfo)
SELECT * FROM EMPLOYEES ;
SELECT * FROM DEPARTMENTS d; 
SELECT * FROM JOBS j ; 

CREATE OR REPLACE 
	FUNCTION showempinfo(
		fname varchar, lname varchar)
	RETURN varchar
IS 
	empno  NUMBER;
	hdate  varchar(10);
	jobid  varchar(10);
	sal	   NUMBER;
	deptid NUMBER;
	dname  varchar(25);
 
BEGIN 
	SELECT EMPLOYEE_ID, HIRE_DATE, JOB_ID, 
			SALARY, DEPARTMENT_ID, DEPARTMENT_NAME
	INTO empno, hdate, jobid, sal, deptid, dname
	FROM EMPLOYEES e JOIN DEPARTMENTS d
	USING (DEPARTMENT_ID)
	WHERE FIRST_NAME = fname AND LAST_NAME = lname;

	RETURN empno || ',' || hdate ||  ',' ||
			jobid || ',' || sal || ',' ||
			deptid || ',' || dname;				
END;


SELECT showempinfo ('Steven','King') FROM dual;


-- 부서번호를 입력하면
-- 사번, 이름, 입사일, 직책, 연봉, 부서명등을
-- 출력하는 함수 작성 (showdeptinfo)
CREATE OR REPLACE PROCEDURE showdeptinfo (
			deptid IN EMPLOYEES.DEPARTMENT_ID%type)
	RETURN NUMBER 
IS 

BEGIN 
	FOR rs IN 
			(SELECT EMPLOYEE_ID ,FIRST_NAME ,HIRE_DATE,
					JOB_ID ,SALARY ,DEPARTMENT_NAEM 
			FROM EMPLOYEES e JOIN DEPARTMENTS d
			USING (DEPARTMENT_ID)
			WHEN DEPARTMENT_ID = deptid)
END;

	LOOP dbms_out.put_line (rs.EMPLOYEE_ID || ','
			|| rs.FIRST_NAME || '.' || rs.HIRE_DATE || ','
			|| rs.JOB_ID || ',' || rs.SALARY || ','
			|| rs.DEPARTMENT_NEAM);
		END LOOP;
END;

BEGIN
	showdeptinfo(30);
END




