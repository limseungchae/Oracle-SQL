SELECT * FROM DEPARTMENTS d;
SELECT * FROM EMPLOYEES e;

----(1) 사원의 이름과 업무를 출력하시오. 단, 사원의 이름은 ‘사원이름’, 직위는 ‘사원업무’머리글이 나오도록 출력한다.
SELECT EMPLOYEE_ID 사원이름, JOB_ID 사원업무 
FROM EMPLOYEES

--(2) 30번 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오.
SELECT FIRST_NAME,LAST_NAME,SALARY  FROM EMPLOYEES
WHERE DEPARTMENT_ID IN 30;

--(3) 사원 번호와 이름, 현재 급여와 10% 인상된 급여--(열 이름은 ‘인상된 급여’)를 출력하시오.
-- 단, 사원 번호순으로 출력한다. 증가된 급여분에 대한 열 이름은 ‘증가액’으로 한다.
SELECT EMPLOYEE_ID 번호, FIRST_NAME 이름, SALARY 기본급여, SALARY * 1.1 "인상된 급여", SALARY * 0.1 증가액 FROM EMPLOYEES
ORDER BY EMPLOYEE_ID ;

--(4) ‘S’로 시작하는 모든 사원과 부서번호를 출력하시오.
SELECT FIRST_NAME 사원, DEPARTMENT_ID 부서번호 FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%';

--(5) 모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오.
 -- 열 이름은 각각 MAX, MIN, SUM, AVG로 한다.
 -- 단, 소수점 이하는 반올림하여 정수로 출력한다.
SELECT MAX(SALARY) 최대급여, MIN(SALARY) 최소급여, SUM(SALARY) 합급여, ROUND(AVG(SALARY))평균급여 FROM EMPLOYEES

--(6) 업무이름과 업무별로 동일한 업무를 하는 사원의 수를 출력하시오.
-- 열 이름은 각각 ‘업무’와 ‘업무별 사원수’로 한다
SELECT  JOB_ID 업무, COUNT (JOB_ID) "업무별 사원수" FROM EMPLOYEES
GROUP BY JOB_ID;

--(7) 사원의 최대 급여와 최소 급여의 차액을 출력하시오.
SELECT  MAX(SALARY) 최대급여,MIN(SALARY) 최소급여, MAX(SALARY)-MIN(SALARY) 차액  FROM EMPLOYEES

--(8) 30번 부서의 구성원 수와 사원들 급여의 합계와 평균을 출력하시오.
SELECT  COUNT(EMPLOYEE_ID), SUM(SALARY) 합계, AVG(SALARY)평균 FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30

--(9) 평균급여가 가장 높은 부서의 번호를 출력하시오.--(ROUND 함수 사용을 권함)
SELECT * FROM 
	(SELECT  DEPARTMENT_ID, ROUND(avg(SALARY)) 평균급여 FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID ORDER BY 평균급여 DESC)
WHERE ROWNUM <= 1; -- 인라인 뷰


SELECT  MAX(ROUND(avg(SALARY)))FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID;
	-- 1567, 2175, 2917

SELECT DEPARTMENT_ID FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING ROUND(avg(SALARY)) =
		(SELECT MAX(ROUND(avg(SALARY))) FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID);

--(10) 세일즈맨을 제외하고, 각 업무별 사원들의 총 급여가 3000 이상인 각 업무에 대해서, 
-- 업무명과 각 업무별 평균 급여를 출력하되, 평균급여의 내림차순으로 출력하시오.
SELECT JOB_ID, ROUND(AVG(SALARY)) 평균급여 FROM EMPLOYEES
GROUP BY JOB_ID
HAVING SUM(SALARY) >= 3000 AND 
	JOB_ID <> 'SALESMAN'
ORDER BY 평균급여 DESC;

SELECT JOB_ID, ROUND(AVG(SALARY)) 평균급여 FROM EMPLOYEES
WHERE JOB_ID < 'SALESMAN'
GROUP BY JOB_ID
HAVING SUM(SALARY) >= 3000  
ORDER BY 평균급여 DESC;

--(11) 전체 사원 가운데 관리자--(mgr)이 있는 사원의 수를 출력하시오.

SELECT MANAGER_ID FROM EMPLOYEES ORDER BY MANAGER_ID;

SELECT COUNT(DISTINCT MANAGER_ID) 관리자수 FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

--(12) Emp 테이블에서 이름, 급여, 커미션 금액, 총액--(sal*12 + comm)을 구하여 총액이 많은 순서대로 출력하시오. 
-- 단, 커미션이 NULL인 사람은 제외한다.
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT, SALARY * 12 + COMMISSION_PCT 총액
FROM EMPLOYEES
WHERE COMMISSION_PCT IN NOT NULL
ORDER BY 총액 DESC;

--(13) 각 부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수를 출력하시오
SELECT DEPARTMENT_ID, JOB_ID, COUNT(EMPLOYEE_ID) 인원수  FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

--(14) 사원이 한 명도 없는 부서의 이름을 출력하시오.--(표준은 EXCEPT, 오라클은 MUNUS)
SELECT EMPLOYEE_ID 이름, DEPARTMENT_ID 부서
FROM EMPLOYEES e RIGHT OUTER JOIN DEPARTMENTS d 
USING (DEPARTMENT_ID)
WHERE EMPLOYEE_ID IS null
ORDER BY DEPARTMENT_ID;

--(15) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.
SELECT JOB_ID, count(EMPLOYEE_ID) 인원수 
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING count(EMPLOYEE_ID) >= 4;

--(16) 사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오.
SELECT * 
FROM EMPLOYEES
WHERE EMPLOYEE_ID  BETWEEN 7400 AND 7600;

--(17) 사원의 이름과 사원의 부서이름을 출력하시오.
SELECT FIRST_NAME 사원이름,EMPLOYEE_ID, DEPARTMENT_NAME 부서이름 FROM EMPLOYEES e
JOIN DEPARTMENTS d USING (DEPARTMENT_ID);

--(18) 사원의 이름과 팀장의 이름을 출력하시오.
SELECT e.FIRST_NAME  사원이름, e.EMPLOYEE_ID 사원이름
		e.MANAGER_ID  상사번호, m.EMPLOYEE_ID 상사이름
		FROM EMPLOYEES e JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID;

--(19) 사원 SCOTT 보다 급여를 많이 받는 사람의 이름을 출력하시오.
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'SCOOT';

SELECT FIRST_NAME  FROM EMPLOYEES 
WHERE SALARY > (SELECT LAST_NAME  FROM EMPLOYEES 
WHERE FIRST_NAME = 'SCOOT');



--(20) 사원 SCOTT가 일하는 부서번호 혹은 DALLAS에 있는 부서번호를 출력하시오
SELECT DEPARTMENT_ID  FROM EMPLOYEES
WHERE FIRST_NAME = 'SCOOT' ; -- 20

SELECT DEPARTMENT_ID  FROM DEPARTMENTS
WHERE LOCATION_ID  = 'DALLAS';

SELECT EMPLOYEE_ID, DEPARTMENT_NAME, LAST_NAME 
FROM EMPLOYEES e  JOIN DEPARTMENTS d 
USING (DEPARTMENT_ID)
WHERE  = 'SCOTT' OR LAST_NAME = 'DALLAS';




INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788,TO_DATE('1983-01-12', 'YYYY-MM-DD'), 1100, NULL, 20);

INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('1982-12-09', 'YYYY-MM-DD'), 3000, NULL, 20);







































