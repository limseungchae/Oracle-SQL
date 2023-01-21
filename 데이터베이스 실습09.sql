SELECT DISTINCT "Year" 연도
FROM SUMMERMEDALS
ORDER BY 연도;

-- 국가별 금메달 획득수 조회
SELECT COUNTRY, count(medal) 메달수
FROM SUMMERMEDALS
GROUP BY COUNTRY, medal
ORDER BY 메달수 DESC;

-- 그룹핑 후 조건 검색 -오버헤드 발생
SELECT COUNTRY, count(medal) 메달수
FROM SUMMERMEDALS
GROUP BY COUNTRY, medal
HAVING MEDAL = 'gold'
ORDER BY 메달수 DESC;

--금메달을 먼저 추출후 그룹핑 - 속도 빠름
SELECT COUNTRY, count(medal) 메달수
FROM SUMMERMEDALS
WHERE MEDAL = 'gold'
GROUP BY COUNTRY;
ORDER BY 메달수 desc;


-- 국가별, 연도별  금메달 획득수 조회

SELECT COUNTRY, "Year", count(medal) 메달수
FROM SUMMERMEDALS
GROUP BY COUNTRY, "Year", medal
HAVING MEDAL = 'gold'
ORDER BY 메달수 DESC;

SELECT COUNTRY, "Year", count(medal) 메달수
FROM SUMMERMEDALS
WHERE MEDAL = 'gold'
GROUP BY COUNTRY, "Year"
ORDER BY 메달수 DESC;

-- 국가별 은메달 획득수 조회
SELECT COUNTRY, count(MEDAL) 메달수
FROM SUMMERMEDALS
GROUP BY COUNTRY, MEDAL
HAVING MEDAL = 'silver'
ORDER BY 메달수 desc;


-- 국가별 동메달 획득수 조회
SELECT COUNTRY, count(medal) 메달수
FROM SUMMERMEDALS
GROUP BY COUNTRY, medal
HAVING MEDAL = 'bronze'
ORDER BY 메달수 desc;

-- 국가별 참여 선수 성별 현황
SELECT COUNTRY 국가, GENDER 성별, count(GENDER) 현황
FROM SUMMERMEDALS
GROUP BY COUNTRY, GENDER
ORDER BY 성별 DESC;

-- 국가별 연도별 참여 선수 성별 현황
SELECT COUNTRY 국가, "Year" 연도, GENDER 성별, count(GENDER) 현황
FROM SUMMERMEDALS
GROUP BY COUNTRY, "Year",GENDER
ORDER BY 성별 DESC;


-- 국가별 연도별 종목별 참여 선수 성별 현황
SELECT COUNTRY 국가, "Year" 연도, SPORT 종목, GENDER 성별, count(GENDER) 현황
FROM SUMMERMEDALS
GROUP BY COUNTRY, "Year",SPORT, GENDER
ORDER BY 성별 DESC;

-- 핫도그 많이 먹기 대회에서 가장 많이 우승한 나라순으로 조회
SELECT COUNTRY, count(COUNTRY) 우승수
FROM HOTDOG_WINNERS
GROUP BY COUNTRY
ORDER BY 우승수 desc;

-- 핫도그 많이 먹기 대회에서 가장 많이 우승한 선수순으로 조회
SELECT WINNER, count(WINNER) 선수
FROM HOTDOG_WINNERS
GROUP BY WINNER
ORDER BY 선수 DESC;

--이름만 추출해서 가장많이 우승한 선수순으로 조회
-- substr(대상, 시작위치, 추출할글자수)
-- instr(대상, 기준문자) : 기준문자의 위치 출력
SELECT  WINNER, SUBSTR(WINNER, 0, 5) 추출한이름
FROM HOTDOG_WINNERS; -- 글자가 제대로 안잘림

SELECT  WINNER, INSTR(WINNER, ' ') 공백위치
FROM HOTDOG_WINNERS;

SELECT  WINNER, 
		SUBSTR(WINNER, 0, instr(winner,' ')) 추출한이름
FROM HOTDOG_WINNERS; -- 글자가 제대로 안잘림

SELECT 
		SUBSTR(WINNER, 0, instr(winner,' ')) 우승자,
		count(WINNER) 우승수
FROM HOTDOG_WINNERS
GROUP BY SUBSTR(WINNER,0,INSTR(winner, ' '))
ORDER BY 우승수 DESC;






