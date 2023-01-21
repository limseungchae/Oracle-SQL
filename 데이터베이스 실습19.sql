
-- EMPLOYEES 테이블에서 사원 번호가 107인 사원의 부서를 
-- 10번으로 변경하여라.
SELECT * FROM EMPLOYEES;

UPDATE EMPLOYEES SET EMPLOYEE_ID = 10
WHERE EMPLOYEE_ID = 107;

SELECT DEPARTMENT_ID FROM EMPLOYEES
WHERE EMPLOYEE_ID =10;

-- EMPLOYEES 테이블에서 사원번호가 180인 사원의
-- 부서를 20, 급여를 3500을 변경하여라.

SELECT DEPARTMENT_ID  FROM EMPLOYEES 
WHERE EMPLOYEE_ID = 180;

UPDATE EMPLOYEES
SET DEPARTMENT_ID =20, SALARY =3500
WHERE EMPLOYEE_ID = 180;

-- EMPLOYEES 테이블에서 Smith의 업무와 급여가 Hall의 업무와 급여와 일치하도록 수정하라.
SELECT FIRST_NAME, JOB_ID, SALARY  FROM EMPLOYEES
WHERE FIRST_NAME = 'hall' OR LAST_NAME = 'hall';

UPDATE EMPLOYEES 
SET (JOB_ID,SALARY) = (SELECT FIRST_NAME, JOB_ID, SALARY 
	FROM EMPLOYEES WHERE FIRST_NAME = 'hall' 
	OR LAST_NAME = 'hall')
WHERE FIRST_NAME  = 'Smith' OR LAST_NAME = 'Smith';

SELECT FIRST_NAME, JOB_ID, SALARY  FROM EMPLOYEES
WHERE FIRST_NAME = 'Smith' OR LAST_NAME = 'Smith';

-- EMPLOYEES 테이블에서 10번 부서의 사원들을 모두 제거 하세요
DELETE  FROM EMPLOYEES
WHERE DEPARTMENT_ID =10;


-- 사원수가 가장 많은 도시에서 근무하는 모든 사원들의
-- 연봉 총합을 조회하라.
SELECT * FROM LOCATIONS l;
SELECT * FROM EMPLOYEES e;
SELECT * FROM DEPARTMENTS d;

-- emp,dept,loc 테이블을 join 한 뷰 생성

CREATE OR replace VIEW empdeptloc
  (employee_id, job_id,
    manager_id, department_id,
    first_name, last_name,
    salary, commission_pct,
    department_name, city,
    state_province)
AS
SELECT e.employee_id, e.job_id,
  e.manager_id, e.department_id,
  e.first_name, e.last_name,
  e.salary, e.commission_pct,
  d.department_name, l.city,
  l.state_province
FROM EMPLOYEES e JOIN DEPARTMENTS d
on e.department_id = d.DEPARTMENT_ID
JOIN LOCATIONS l on d.location_id = l.LOCATION_ID;


CREATE OR replace VIEW empdeptloc
  (employee_id, job_id,
    manager_id, department_id,
    first_name, last_name,
    salary, commission_pct,
    department_name, city,
    state_province)
AS
SELECT e.employee_id, e.job_id,
  e.manager_id, department_id,
  e.first_name, e.last_name,
  e.salary, e.commission_pct,
  d.department_name, l.city,
  l.state_province
FROM EMPLOYEES e JOIN DEPARTMENTS d
USING (department_id)
JOIN LOCATIONS l on (location_id);

-- 결과 확인
SELECT * FROM empdeptloc;

-- 사원수가 많은 도시 조회
SELECT 도시 FROM (
	SELECT city 도시, count(employee_id) 사원수
	FROM empdeptloc 
	GROUP BY city OR BY 사원수 DESC)
WHERE rownum <= 1;

-- 샌프란시스코에 근무하는 사원들의 연봉 총합
SELECT sum(salary) FROM EMPDEPTLOC
WHERE city = (SELECT 도시 FROM (
	SELECT city 도시, count(employee_id) 사원수
	FROM empdeptloc 
	GROUP BY city ORDER BY 사원수 DESC)
WHERE rownum <= 1);


