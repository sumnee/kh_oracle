-- PL/SQL
-- �͸���

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
        WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('F����Դϴ�.');
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('E����Դϴ�.');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('D����Դϴ�.');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('C����Դϴ�.');
        WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('B����Դϴ�.');
        ELSE DBMS_OUTPUT.PUT_LINE('A����Դϴ�.');
    END CASE;
END;
/

-- �⺻ LOOP��
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
-- ī��Ʈ�� ������ �ڵ����� �����
-- ���� ������ ������ �ʿ����(DECLARE �ʿ����)
-- ī��Ʈ ���� �ڵ����� 1�� ������. REVERSE�� ����ϸ� 1�� ������.
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

-- EMPLOYEE ���̺��� �����ȣ�� 201, 202, 203, 204�� ������
-- �̸��� �޿��� ����Ͻÿ�.
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSAL EMPLOYEE.SALARY%TYPE;
BEGIN
    FOR N IN 1..4 LOOP
        SELECT EMP_NAME, SALARY
        INTO VNAME, VSAL
        FROM EMPLOYEE
        WHERE EMP_ID = 200+N;
        DBMS_OUTPUT.PUT_LINE('�̸� : '|| VNAME);
        DBMS_OUTPUT.PUT_LINE('�޿� : '|| VSAL);
    END LOOP;
END;
/

--����ڷκ��� 2~9������ ���� �Է¹޾� ������ ����Ͻÿ�
DECLARE 
    DAN NUMBER;
    N NUMBER;
BEGIN
    FOR N IN 1..9 LOOP
    DAN := '&������';
    DBMS_OUTPUT.PUT_LINE(DAN||' * '||N||' = '||DAN*N);
    END LOOP;
END;
/


























