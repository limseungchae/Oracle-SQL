-- 저장 프로시져
-- PL/SQL 블록 외부에 선언해서 데이터베이스에 저장
-- PL/SQL 블록을 별도로 작성하므로 프로그램이 단순-모듈화
-- 서버 부하도 줄이고, 네트워크 트래픽도 감소-효율성
-- PL/SQL, 트리거, 각종 응용프로그램등에서 호출가능-재사용성
-- 프로그램 관리가 용이 - 유지보수성
-- CREATE OR REPLACE PROCEDURE 이름(IN/OUT/INOUT 매개변수목록)
-- IS
-- BEGIN
-- END;
CREATE OR REPLACE PROCEDURE sayHello3
IS
BEGIN
    -- 출력문    
    dbms_output.put_line('Hello, World!!');
END;
-- 프로시져이므로 실행불가!
-- SELECT sayHello3 FROM dual;
-- dbeaver, intellij 에서는 불가!
-- sql developer에서 실행 가능!
-- EXEC sayHello3;
BEGIN
    sayHello3;
END;
-- IN : 입력용 매개변수라는 의미
CREATE OR REPLACE
    PROCEDURE sayHello4(msg IN varchar)
IS
BEGIN
    dbms_output.put_line('Hello, ' || msg || '!!!');
END;
BEGIN
    sayHello4('Java');
END;
-- 도서 정보를 입력받아
-- book 테이블에 저장하는 프로시져 작성
CREATE OR REPLACE PROCEDURE newBook(
    bkid        IN   BOOK.BOOKID%type,
    bkname  IN   BOOK.BOOKNAME%type,
    pubname IN   BOOK.PUBLISHER%type,
    bkprice IN   BOOK.PRICE%type
)
is
BEGIN
    INSERT INTO book
            VALUES (bkid, bkname, pubname, bkprice);   
    dbms_output.put_line('도서정보 입력완료!');
END;

begin
    newBook('9999', '자바 프로그래밍', '더조은', 35000);
END;
SELECT * FROM book;

-- 커서 cursor
-- 이전 예제에서 select 문의 실행결과를 하나만 처리했었음
-- 한편, 오라클에서는 select 문의 실행결과로 복수행이
-- 반환되는 경우, cursor로 처리하도록 지원
-- 커서는 질의결과로 얻어진 복수행 집합 중
-- 각 행의 위치를 의미 : 결과집합에서 하나의 행을 읽어옴
-- 커서에는 암시적implicit/명시적explicit 커서가 존재
-- 일반적으로 암시적 커서는 단일행을 결과로 반환
-- 여러 행을 결과로 반환하는 SQL문에는 명시적 커서가 사용
-- cursor [이름] open ~ fetch ~ close 형식으로 커서를 정의
-- 정의된 커서는 for ~ loop ~ end loop 문으로 처리 : 결과출력
-- 커서의 속성을 제공하는 특수한 명령 지원 : %rowcount, %notfound, %isopen

-- 도서번호를 입력하면
-- 해당 도서의 상세정보 출력하는 프로시져
-- showbookinfo2(bookid)
CREATE OR REPLACE PROCEDURE  
            showbookinfo2(bkid IN book.BOOKID%type)
IS
    bkname varchar(100);
    pubname varchar(100);
    price number;
BEGIN
    SELECT bookname, publisher, price
    INTO bkname, pubname, price
    FROM book WHERE bookid = bkid;
    dbms_output.put_line(bkid || ',' ||
                    bkname || ',' ||
                    pubname || ',' || price);
END;
BEGIN
    showbookinfo2(3);
END;

-- 출판사를 입력하면
-- 해당 도서들의 상세정보 출력하는 프로시져
-- showbookinfo3(publisher)
CREATE OR REPLACE PROCEDURE
            showbookinfo3(pubname IN book.PUBLISHER%type)
IS
    bkid        NUMBER;
    bkname  varchar(100);
    bkprice NUMBER;
BEGIN
    SELECT bookid, bookname, price
    INTO bkid, bkname, bkprice FROM book
    WHERE PUBLISHER = pubname;
    dbms_output.put_line(bkid || ',' ||
                    bkname || ',' || bkprice);
END;

BEGIN
    showbookinfo3('나무수'); -- 결과는 단일행
END;

BEGIN
    showbookinfo3('굿스포츠'); -- 결과가 다중행
END;

-- 출판사를 입력하면
-- 해당 도서들의 상세정보 출력하는 프로시져
-- showbookinfo4(publisher)
CREATE OR REPLACE PROCEDURE showbookinfo4(pubname IN book.PUBLISHER%type)
IS
CURSOR cs_book(pubname IN book.PUBLISHER%type)
    is
    SELECT BOOKID, BOOKNAME, PRICE
    FROM book
    WHERE PUBLISHER = pubname;
BEGIN

-- 커서를 호출하여 rs 변수에 저장해 두고
-- 반복처리를 통해 각 행별로 값을 추출해서 출력
FOR rs IN cs_book(pubname)
    LOOP
            dbms_output.put_line(rs.BOOKID || ',' ||
                    rs.BOOKNAME || ',' || rs.PRICE);
    END LOOP;
END;

BEGIN
    showbookinfo4('나무수'); -- 결과는 단일행
END;

BEGIN
    showbookinfo4('굿스포츠'); -- 결과가 다중행
END;

------------------------------------------------------
CREATE OR REPLACE PROCEDURE showbookinfo4(
            pubname IN book.PUBLISHER%type)
IS
    bkid	NUMBER;
    bkname  varchar(100);
    bkprice NUMBER;
BEGIN
    -- 커서 선언
    DECLARE  cursor cs_book is
    SELECT BOOKID, BOOKNAME, PRICE
    FROM book
    WHERE PUBLISHER = pubname;
    BEGIN
            OPEN cs_book; -- 커서 열기         
            LOOP
                    -- 커서를 호출하여 각 행별로 값을 추출함
                    FETCH cs_book INTO bkid, bkname, bkprice;
                      -- 더 이상 읽어올 데이터가 없으면 반복처리 종료    
                    EXIT WHEN cs_book%NOTFOUND;
                     -- 추출한 값을 출력
                    dbms_output.put_line(bkid || ',' ||            
                            bkname || ',' || bkprice);

            END LOOP;
               CLOSE cs_book;
    END;

BEGIN
    showbookinfo4('나무수'); -- 결과는 단일행
END;

BEGIN
    showbookinfo4('굿스포츠'); -- 결과가 다중행
END;


-- 동적 커서를 사용한 프로시져
CREATE OR REPLACE PROCEDURE showbookinfo5(
            pubname IN book.PUBLISHER%type)
IS
BEGIN
    -- 커서 선언
    FOR rs in
            (SELECT BOOKID, BOOKNAME, PRICE
            FROM book
            WHERE PUBLISHER = pubname)
    LOOP
            -- 추출한 값을 출력
            dbms_output.put_line(rs.bookid || ',' ||       
                    rs.bookname || ',' || rs.price);
    END LOOP;  
END;

BEGIN
    showbookinfo5('굿스포츠'); -- 결과가 다중행
END;










