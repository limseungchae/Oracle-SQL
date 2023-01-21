-- UPDATE
-- 테이블에 저장된 값을 다른 값으로 변경시 사용
-- 중요한 작업시 commit, rollback 명령 활용
-- auto-commit 기능은 불편하지만, 꺼두는 것이 좋음

-- update 테이블명
-- set 변경대상컬럼 = 변경값
-- where 조건문

-- 고객번호가 5인 고객
SELECT * FROM CUSTOMER
WHERE CUSTID = 5;  -- 수정전 (대전)

UPDATE CUSTOMER 
SET ADDRESS = '대한민국 부산'
WHERE custid = 5;

SELECT * FROM CUSTOMER 
WHERE CUSTID = 5; -- 수정후 (부산)

-- 박세리 고객의 주소를 김연아 고객의 주소로 수정
SELECT * FROM CUSTOMER
WHERE name =  '박세리'; -- 부산

SELECT * FROM CUSTOMER
WHERE name =  '김연아'; -- 서울

UPDATE CUSTOMER
SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER 
WHERE name =  '김연아')
WHERE name =  '박세리';

SELECT ADDRESS FROM CUSTOMER
WHERE name =  '박세리';

-- DELETE
-- 테이블에 있는 레코드를 삭제하는 명령

-- delete from 데이블명
-- where 조건문

-- 고객번호가 5인 고객의 정보를 삭제 
DELETE FROM CUSTOMER
WHERE CUSTID = 5;

SELECT * FROM CUSTOMER;

-- 모든고객을 삭제
DELETE FROM "ORDER";

DELETE FROM CUSTOMER;

SELECT * FROM CUSTOMER; -- 삭제 결과 확인






