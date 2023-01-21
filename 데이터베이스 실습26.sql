-- rownum
-- oracle에서 내부적으로 생서되는 가상 컬럼
-- 페이징을 이용한 부분 레코드 조회시 주로 사용
-- 12c부터는 fetch 구문으로 대신 사용

-- 순번 매기기 1
SELECT rownum "no", e.* FROM EMPLOYEES e;

-- 순번 매기기 2
SELECT rownum "no", e.FIRST_NAME,LAST_NAME 
FROM EMPLOYEES e;

-- 사원들 중 연봉이 가장 많은 사원 순으로 조회
-- 단, rownum으로 순번컬럼도 생성
SELECT rownum "no",EMPLOYEE_ID ,e.SALARY,FIRST_NAME
FROM EMPLOYEES e;
ORDER BY SALARY DESC; --번호가 이상함

-- 먼저 연봉순으로 정렬한 후
-- rownum을 이용해서 번호를 매김
SELECT ROWNUM "NO", EMP.* FROM(
SELECT EMPLOYEE_ID ,e.SALARY,FIRST_NAME
FROM EMPLOYEES e
ORDER BY SALARY DESC) emp; 

-- 연봉이 가장 많은 사원 10명만 조회
SELECT ROWNUM "NO", EMP.* FROM(
SELECT EMPLOYEE_ID ,e.SALARY,FIRST_NAME
FROM EMPLOYEES e
ORDER BY SALARY DESC) emp
WHERE rownum <= 10;

-- 연봉이 가장 많은 사원 5명만 조회
-- 단, 11위부터 15위에 해당하는 사원을 대상
SELECT * FROM 
(SELECT ROWNUM rn, EMP.* FROM(
	SELECT EMPLOYEE_ID ,e.SALARY,FIRST_NAME
	FROM EMPLOYEES e
	ORDER BY SALARY DESC) emp
WHERE ROWNUM <= 20)
WHERE rn > 10 AND rn <= 15;

-- 차집합 이용
SELECT * FROM(
	SELECT EMPLOYEE_ID ,e.SALARY,FIRST_NAME
	FROM EMPLOYEES e
	ORDER BY SALARY DESC) emp
WHERE ROWNUM <= 15
MINUS 
SELECT * FROM(
	SELECT EMPLOYEE_ID ,e.SALARY,FIRST_NAME
	FROM EMPLOYEES e
	ORDER BY SALARY DESC) emp
WHERE ROWNUM <= 10;

-- 행과 행간의 관계를 쉽게 파악하기 위해 만든 함수
-- 분석함수, 순위함수라도도 함
-- 순위함수 : rank, row_number
-- 집계함수 : sum, max, min, avg, count
-- 순서관련함수 : first_value, last_value, lag, lead
-- 비율관련함수 : percent_rank
-- 통계분석함수 : stddev, corr, cov

-- 윈도우 함수문법
-- SELECT 윈도우함수(인수)
-- over(파티션by 컬럼 order by 절 윈도우절)
-- from 테이블명
-- partition by : 대상을 그룹화할 기준
-- order by : 그룹화한 대상에 대한 정렬 기준
-- window절 : 분석대상의 범위 지정

-- 부서별 사원 연봉 합계 조회
-- 단, 부서 소속 사원도 같이 출력
SELECT DEPARTMENT_ID, sum(SALARY) 연봉합계
FROM EMPLOYEES e 
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
		sum(SALARY) OVER(PARTITION BY DEPARTMENT_ID) 연봉합계 
FROM EMPLOYEES;


-- 부서별 사원 최대/최소/평균 연봉 사원수 조회
-- 단, 부서 소속 사원도 같이 출력
SELECT FIRST_NAME, SALARY,DEPARTMENT_ID,
		MAX(SALARY) OVER(PARTITION BY DEPARTMENT_ID) 최대,
		MIN(SALARY) OVER(PARTITION BY DEPARTMENT_ID) 최소, 
		round(AVG(SALARY)) OVER(PARTITION BY DEPARTMENT_ID) 평균,
		COUNT(SALARY) OVER(PARTITION BY DEPARTMENT_ID) 사원수
FROM EMPLOYEES;

-- 전체연봉 순위와 부서별 사원 연봉 순위 조회
-- rank : 1 2 2 4 5  (동률순위일떄 처리방식이 다름)
-- dense_rank : 1 2 2 3 4
-- row_number : 1 2 3 4 5

SELECT FIRST_NAME, DEPARTMENT_ID, SALARY,
	rank() OVER (ORDER BY SALARY desc) 전체연봉순위,
	rank() OVER (PARTITION BY DEPARTMENT_ID  
				ORDER BY SALARY desc) 부서별연봉순위
FROM EMPLOYEES e ;

SELECT FIRST_NAME, DEPARTMENT_ID, SALARY,
	dense_rank() OVER (ORDER BY SALARY desc) dense_rank,
	row_number() OVER (ORDER BY SALARY desc) row_number
FROM EMPLOYEES e ;

-- 이전/이후 행의 값 불러오기 : lag, lead

-- 사원들을 입사일자가 빠른 순으로 
-- 정렬한 뒤 본인의 입사일자와 
-- 후임 사원의 입사일자 간의 차이 조회
SELECT FIRST_NAME,
		TO_char(HIRE_DATE, 'dl') 입사일,
		lag(HIRE_DATE) OVER(ORDER BY HIRE_DATE) 이전입사일,
		HIRE_DATE - lag(HIRE_DATE) OVER(ORDER BY HIRE_DATE) 입사일차이
FROM EMPLOYEES;

SELECT FIRST_NAME,
		TO_char(HIRE_DATE, 'dl') 입사일,
		lead(HIRE_DATE) OVER(ORDER BY HIRE_DATE) 이후입사일
FROM EMPLOYEES;

-- 사원들을 입사일이 빠른 순으로 정렬한 뒤
-- 본인보다 입사일이 빠른 사원의 급여를
-- 본인의 급여와 함께 출력하세요
SELECT FIRST_NAME, HIRE_DATE,
		to_char(HIRE_DATE, 'di')  입사일,
		SALARY 본인연봉,
		lag(SALARY) OVER(ORDER BY HIRE_DATE) 선임연봉,
		lead(SALARY) OVER(ORDER BY HIRE_DATE) 후임연봉
FROM EMPLOYEES;




-- 마당서점은 주무일로부터 10일 후 매출을 확정한다. 
-- 각 주문의 확정일자를 구하시오
SELECT * FROM BOOK b;
SELECT * FROM "ORDER" o;
SELECT * FROM CUSORDR c ;

SELECT ORDERDATE 주문일 ,ORDERDATE + 10 확정 FROM CUSORDR c;

-- 마당서점이 2014년 7월 7일에 주문 받은 도서의 
-- 주문번호, 주문일, 고객번호 도서번호를 보이고
-- 주문일은 '%Y-%M-%d' 형태로 표현한다
SELECT 
		ORDERID 주문번호,TO_DATE(ORDERDATE,'%Y-%m-%d') 주문일,
		CUSTID 고객번호, BOOKID 도서번호 
FROM CUSORDR;

-- DBMS 서버에 설정된 현재 날짜와 시간,요일을 확인하시오.
SELECT
	SYSDATE,
	abs(to_date(SYSDATE,'yyyy-mm-dd')) a
FROM dual;





