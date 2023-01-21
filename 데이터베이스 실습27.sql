-- 이름으로 정렬한후, 현재 회원 기준 이전(이후) 회원과의 마일리지 차이 계산후 조회
SELECT  *  FROM CUSTOMERS  

SELECT NAME, MILEAGE 기준회원마일리지,
	lag(MILEAGE) OVER (ORDER BY NAME) 이전회원마일리지,
	MILEAGE - lag(MILEAGE) OVER (ORDER BY NAME) 이전마일리지차이,
	MILEAGE 기준회원마일리지,
	lead(MILEAGE) OVER (ORDER BY NAME) 이후회원마일리지,
	MILEAGE - lead(MILEAGE) OVER (ORDER BY NAME) 이후마일리지차이
FROM CUSTOMERS;

-- 코로나 확진자 현황
-- data.go.kr
-- 현재 확진자수는 전일 확진자수 대비 증가여부 확인
SELECT * FROM COVID19 c;

SELECT
 	기준일,
	TO_char(TO_DATE(기준일, 'yyyymmdd'), 'dl')기준일,
	"확진자 수",
 	lead ("확진자 수") OVER (ORDER BY 기준일 DESC ) 전일확진자수,
  	"확진자 수" - lead ("확진자 수") OVER (ORDER BY 기준일 DESC ) 증가여부
FROM COVID19 c;

SELECT 
	등록일시분초,
	to_char(to_timestamp(등록일시분초,
			'yyyy-mm-dd hh:mi:ss.FF'),'dl') a
FROM COVID19 c 

-- 회원 등급이 vip면 '프리미엄', gold면 '우수',
-- silver 면 우량, 그외에는 '일반' 이라 표시
SELECT  name, grade,
	CASE WHEN grade = 'vip' THEN '프리미엄'
		 WHEN grade = 'gold' THEN '우수'
		 WHEN grade = 'silver' THEN '우량'
		 ELSE '일반'
	END 회원등급
FROM CUSTOMERS;
		
