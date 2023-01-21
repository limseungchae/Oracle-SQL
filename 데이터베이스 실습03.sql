--오라클 샘플 데이터베이스 생성하기 : HR

--REGIONS
CREATE TABLE regions(
	region_id	NUMBER,
	region_name	varchar2(30) CONSTRAINTS rgnnm_nn NOT null
);

--COUNTRIES
CREATE TABLE countries(
	country_id		char(2),
	countey_name	varchar2(30) CONSTRAINTS cntynm_nn NOT NULL,
	region_id		NUMBER
);

--LOCATIONS
CREATE TABLE locations(
	location_id		number,
	street_address	varchar2(50) CONSTRAINTS straddr_nn NOT NULL,
	postal_code		varchar2(15),
	city 			varchar2(30) CONSTRAINTS cty_nn NOT NULL,
	state_province	varchar2(20),
	country_id		char(2)
);

--DEPARTMENTS
CREATE TABLE departments(
	department_id	NUMBER,
	department_name	varchar2(30) CONSTRAINTS dptnm_nn NOT NULL,
	manager_id		NUMBER,
	location_id		NUMBER
);

-- JOBS
CREATE TABLE jobs(
	job_id		varchar2(15),
	job_title	varchar2(50) 	CONSTRAINTS jbtit_nn NOT NULL,
	min_salary	NUMBER 			DEFAULT 0,
	max_salary	NUMBER 			DEFAULT 0
);

--EMPLOYEES
CREATE TABLE employees(
	employee_id		NUMBER,
	first_name		varchar2(15) CONSTRAINTS frtnm_nn NOT NULL,
	last_name		varchar2(15) CONSTRAINTS lstnm_nn NOT NULL,
	email			varchar2(15) CONSTRAINTS emlnm_nn NOT NULL,
	phone_number	varchar2(30) CONSTRAINTS phnnm_nn NOT NULL,
	hire_date		DATE	   	  CONSTRAINTS hrdt_nn NOT NULL,
	job_id			varchar2(15),
	salary			NUMBER		 DEFAULT 0,
	commission_pct	NUMBER (*,2),
	manager_id		NUMBER,
	department_id	NUMBER
);

-- JOB_HISTORY
CREATE TABLE job_history(
	employee_id		NUMBER,
	start_date		DATE,
	end_date		DATE,
	job_id			varchar2(15),
	department_id	NUMBER
);

-- pk
ALTER TABLE regions 
	ADD CONSTRAINT rgn_pk PRIMARY KEY (region_id);

ALTER TABLE countries 
	ADD CONSTRAINT cnty_pk PRIMARY KEY (country_id);

ALTER TABLE locations 
	ADD CONSTRAINT loc_pk PRIMARY KEY (location_id);

ALTER TABLE departments 
	ADD CONSTRAINT dept_pk PRIMARY KEY (department_id);

ALTER TABLE jobs
	ADD CONSTRAINT jb_pk PRIMARY KEY (job_id);

ALTER TABLE employees 
	ADD CONSTRAINT emp_pk PRIMARY KEY (employee_id);

ALTER TABLE job_history 
	ADD CONSTRAINT jbh_pk PRIMARY KEY (employee_id, start_date);

-- fk
ALTER TABLE countries 
	ADD CONSTRAINT cnty_rgnid_fk
	FOREIGN KEY (region_id) REFERENCES regions (region_id);

ALTER TABLE locations 
	ADD CONSTRAINT loc_cntyid_fk
	FOREIGN KEY (country_id) REFERENCES countries (country_id);

ALTER TABLE departments 
	ADD CONSTRAINT dept_locid_fk
	FOREIGN KEY (location_id) REFERENCES locations (location_id);

ALTER TABLE employees 
	ADD CONSTRAINT emp_deptid_fk
	FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE employees 
	ADD CONSTRAINT emp_jobid_fk
	FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE employees 
	ADD CONSTRAINT emp_mgrid_fk
	FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

ALTER TABLE job_history
	ADD CONSTRAINT jbh_deptid_fk
	FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE job_history 
	ADD CONSTRAINT jbh_jobid_fk
	FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE job_history 
	ADD CONSTRAINT jbh_empid_fk
	FOREIGN KEY (employee_id) REFERENCES employees (employee_id);


