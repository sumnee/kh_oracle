-- PL/SQL
-- 익명블록

SELECT * FROM EMPLOYEE;
SET SERVEROUTPUT ON;

DECLARE
    VSAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO VSAL
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    VSAL := VSAL / 1000000;
    CASE FLOOR(VSAL)
        WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('F등급입니다.');
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('E등급입니다.');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('D등급입니다.');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('C등급입니다.');
        WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('B등급입니다.');
        ELSE DBMS_OUTPUT.PUT_LINE('A등급입니다.');
    END CASE;
END;
/

-- 기본 LOOP문
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        IF N>5 THEN EXIT;
        END IF;
    END LOOP;
END;
/

-- ## FOR LOOP
-- 카운트용 변수가 자동으로 선언됨
-- 따로 변수를 선언할 필요없음(DECLARE 필요없음)
-- 카운트 값은 자동으로 1씩 증가함. REVERSE를 사용하면 1씩 감소함.
BEGIN 
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/
BEGIN 
    FOR N IN REVERSE 5..10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- EMPLOYEE 테이블에서 사원번호가 201, 202, 203, 204인 직원의
-- 이름과 급여를 출력하시오.
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSAL EMPLOYEE.SALARY%TYPE;
BEGIN
    FOR N IN 1..4 LOOP
        SELECT EMP_NAME, SALARY
        INTO VNAME, VSAL
        FROM EMPLOYEE
        WHERE EMP_ID = 200+N;
        DBMS_OUTPUT.PUT_LINE('이름 : '|| VNAME);
        DBMS_OUTPUT.PUT_LINE('급여 : '|| VSAL);
    END LOOP;
END;
/

--사용자로부터 2~9사이의 수를 입력받아 구구단 출력하시오
DECLARE 
    DAN NUMBER;
    N NUMBER;
BEGIN
    FOR N IN 1..9 LOOP
    DAN := '&구구단';
    DBMS_OUTPUT.PUT_LINE(DAN||' * '||N||' = '||DAN*N);
    END LOOP;
END;
/


























