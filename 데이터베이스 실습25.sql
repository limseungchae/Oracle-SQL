-- 날짜, 시간, 변환 함수

-- 날짜,시간을 문자로 변환 : to_char(값, 출력형식)
SELECT 
	sysdate,
	TO_CHAR(sysdate, 'YYYY') 년도만,
	TO_CHAR(sysdate, 'YYYY-MM-DD') 날짜만,
	TO_CHAR(sysdate, 'HH24:MI:SS') 시간만
FROM dual;

SELECT 
	TO_CHAR(sysdate, 'D') a, -- 요일을 의미하는 정수
	TO_CHAR(sysdate, 'DY') b,
	TO_CHAR(sysdate, 'DAY') c,
	TO_CHAR(sysdate, 'Dl') d
FROM dual;

SELECT 
	TO_CHAR(sysdate, 'DDD') a, -- 일수
	TO_CHAR(sysdate, 'WW') b,  -- 주
	TO_CHAR(sysdate, 'Q') c 	-- 분기
FROM dual;

SELECT 
	TO_CHAR(123, '999') a,		-- 자리가 남으면 공백으로 채움
	TO_CHAR(123, '0009') b,		-- 자리가 남으면 0으로 채움
	TO_CHAR(1234, '0,009') c,	-- 4자리마다, 표시
	TO_CHAR(1234567, '0,000,009') d,
	TO_CHAR(1234567, 'L0,000,009') e -- 통화기호 표시
FROM dual;

-- 문자열을 날짜형을 변환 : str_to_date(값, 출력형식)
-- 외부에서 날짜형식의 문자열을 읽어오는 경우
-- 적절히 사용함
SELECT to_date('2022-12-31','yyyy-mm-dd') 
FROM dual;

-- 날짜계산: add_months(날짜, 간격)
-- 날짜형 데이터를 +/- 연산자로 계산할 수 있음

-- 현재의 기준 100일 후는 언제인가?
SELECT sysdate + 100 FROM dual;

-- 현재의 기준 100일 전은 언제인가?
SELECT sysdate - 100 FROM dual;

-- 2022-12-19에서 2023-06-09까지 총 몇일인가?
SELECT abs(to_date('2022-12-19', 'yyyy-mm-dd') -  
		to_date('2023-06-09', 'yyyy-mm-dd')) 총일수 
FROM dual;

SELECT ADD_MONTHS(sysdate, 6)		-- 이후 6개월
		ADD_MONTHS(sysdate, -6)	-- 이전 6개월
FROM dual;

-- 개월 수 계산 : months_between(날짜1,날짜2)

-- 2022-12-19에서 2023-06-09까지 총 몇일인가?
SELECT round(abs(MONTHS_BETWEEN(
		to_date('2022-12-19', 'yyyy-mm-dd'),
		to_date('2023-06-09', 'yyyy-mm-dd'))),1) 개월수
 FROM dual;		-- 5.7개월 : 6일이 모자란 6개월

 -- 해달월이 마지막 날 계산 :last_day
 
 SELECT LAST_DAY(SYSDATE) FROM dual;

-- 현재일 기준 다음주 일요일 계산 : next_day
SELECT NEXT_day(sysdate, '일요일') FROM dual;






