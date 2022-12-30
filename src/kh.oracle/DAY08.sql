--�� ��������! �ٽ� �� ����

--@�ǽ�����
--kh���� ������ �� employee, job, department���̺��� �Ϻ������� ����ڿ��� �����Ϸ��� �Ѵ�.
-- ������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի����� �÷������� ��(v_emp_info)�� (�б� ��������) �����Ͽ���.
CREATE OR REPLACE VIEW V_EMP_INFO
AS SELECT E.EMP_ID AS ������̵�, E.EMP_NAME AS �����
, JOB_NAME AS ���޸�, DEPT_TITLE AS �μ���
, M.EMP_NAME AS �����ڸ�
, E.HIRE_DATE AS �Ի���
FROM EMPLOYEE E
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN EMPLOYEE M ON M.EMP_ID = E.MANAGER_ID;
-- ORA-00955: name is already used by an existing object
SELECT * FROM V_EMP_INFO;
DROP VIEW V_EMP_INFO;

-- VIEW �ɼ�
-- VIEW�� ���� �Ŀ� �����ؾߵ� ��� ���� �� ������ؾ���.
-- 1. OR REPLACE
-- > ������ �䰡 �����ϸ� �並 ��������.
--CREATE OR REPLACE SEQUENCE SEQ_USERNO; (X)
--CREATE OR REPLACE TABLE EMPLOYEE; (X)
-- 2. FORCE/NOFORCE
-- �⺻���� NOFORCE�� �����Ǿ� ����.
CREATE OR REPLACE FORCE VIEW V_FORCE_SOMETHING
AS SELECT EMP_ID, EMP_NO FROM NOTHING_TBL;
-- ORA-00942: table or view does not exist
-- 3. WITH CHECK OPTION
-- > WHERE�� ���ǿ� ����� �÷��� ���� �������� ���ϰ� ��.
CREATE OR REPLACE VIEW V_EMP_D5
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
SELECT * FROM V_EMP_D5;
UPDATE V_EMP_D5 SET EMP_NAME = '������' 
WHERE SALARY >= 800000;
UPDATE V_EMP_D5 SET DEPT_CODE = 'D2'
WHERE SALARY >= 8500000;
-- ORA-01402: view WITH CHECK OPTION where-clause violation
ROLLBACK;
-- 4. WITH READ ONLY
-- View�����ϱ�
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WITH READ ONLY;
-- �б� �������� ����
-- View V_EMPLOYEE��(��) �����Ǿ����ϴ�.

-- View����
UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = 200;
-- ORA-42399: cannot perform a DML operation on a read-only view

-- SEQUENCE �ǽ�
--@�ǽ�����
--���� ��ǰ�ֹ��� ����� ���̺� TBL_ORDER�� �����, ������ ���� �÷��� �����ϼ���
-- ORDER_NO(�ֹ�NO) : PK
-- USER_ID(�����̵�)
-- PRODUCT_ID(�ֹ���ǰ���̵�)
-- PRODUCT_CNT(�ֹ�����) 
-- ORDER_DATE : DEFAULT SYSDATE
CREATE TABLE ORDER_TBL(
    ORDER_NO NUMBER, 
    USER_ID VARCHAR2(20),
    PRODUCT_ID VARCHAR(30),
    PRODUCT_CNT NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT PK_ORDER_NO PRIMARY KEY(ORDER_NO)
);
-- ORDER_NO�� ������ SEQ_ORDER_NO�� �����, ���� �����͸� �߰��ϼ���.(����ð� ����)
-- * kang���� saewookkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
-- * gam���� gamjakkang��ǰ�� 30�� �ֹ��ϼ̽��ϴ�.
-- * ring���� onionring��ǰ�� 50�� �ֹ��ϼ̽��ϴ�.
CREATE SEQUENCE SEQ_ORDER_NO;
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50, DEFAULT);
SELECT * FROM ORDER_TBL;
COMMIT;
ROLLBACK;
INSERT INTO ORDER_TBL
VALUES(1, 'khuser01', 'product01', 1, DEFAULT);
ROLLBACK;

-- �ǽ�����2
--KH_MEMBER ���̺��� ����
--�÷�
--MEMBER_ID	NUNBER
--MEMBER_NAME	VARCHAR2(20)
--MEMBER_AGE	NUMBER
--MEMBER_JOIN_COM	NUMBER
--�̶� �ش� ������� ������ INSERT �ؾ� ��
--ID ���� JOIN_COM�� SEQUENCE �� �̿��Ͽ� ������ �ְ��� ��

--1. ID���� 500 �� ���� �����Ͽ� 10�� �����Ͽ� ���� �ϰ��� ��
--2. JOIN_COM ���� 1������ �����Ͽ� 1�� �����Ͽ� ���� �ؾ� ��
--(ID ���� JOIN_COM ���� MAX�� 10000���� ����)

--	500		        ȫ�浿		20		        1
--	510		        �踻��		30		        2
--	520		        �����		40		        3
--	530		        ����		24		        4

CREATE TABLE KH_MEMBER(
    MEMBER_ID NUMBER,
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE NUMBER,
    MEMBER_JOIN_COM NUMBER
);
CREATE SEQUENCE SEQ_MEMBER_ID
START WITH 500
INCREMENT BY 10
MAXVALUE 10000;
CREATE SEQUENCE SEQ_JOIN_COME
MAXVALUE 10000;
SELECT * FROM USER_SEQUENCES;

INSERT INTO KH_MEMBER VALUES(SEQ_MEMBER_ID.NEXTVAL, 'ȫ�浿', 20, SEQ_JOIN_COME.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(SEQ_MEMBER_ID.NEXTVAL, '�踻��', 30, SEQ_JOIN_COME.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(SEQ_MEMBER_ID.NEXTVAL, '�ֻ��', 40, SEQ_JOIN_COME.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(SEQ_MEMBER_ID.NEXTVAL, '����', 24, SEQ_JOIN_COME.NEXTVAL);
SELECT * FROM KH_MEMBER;


-- ### ROLE
-- > ����ڿ��� ���� ���� ������ �ѹ��� �ο��� �� �ִ� �����ͺ��̽� ��ü
-- > �ʿ��� ������ ��� ����,ȸ���� �� ��
-- ex. GRANT CONNECT, RESOURCE TO KH;
-- ���Ѱ� ���õ� ��ɾ�� �ݵ�� SYSTEM���� ����!

-- CONNECT, RESOURCE ���̴�. ���� ������ �������� ���ִ�.
-- ROLE
-- CONNECT�� : CREATE SESSION
-- RESOURCE�� : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE
--             CREATE TRIGGER, CREATE TYPE, CREATE INDEXTYPE, CREATE OPERATOR;
-- SYSTEM���� ��ȸ ����, SYS�� ��ȸ�ؾ� CONNECT, RESOURCE �ѿ� ���� ������ ����.
-- 1. KH���� ��ȸ��
-- 2. SYSTEM���� ��ȸ�ȵ�
-- 3. KH���� �ο��޾Ұ�, SYSTEM���� �ο���������.
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT';
-- ��ȸ ������.

CREATE ROLE ROLE_PUBLIC_EMP;
-- ROLE ����
GRANT SELECT ON KH.V_EMP_INFO TO ROLE_PUBLIC_EMP;
--GRANT ����

-- �����
SELECT * FROM USER_SYS_PRIVS;


-- 4. INDEX
-- SQL ��ɹ��� ó���ӵ��� ����Ű�� ���ؼ� �÷��� ���ؼ� �����ϴ� ����Ŭ ��ü
-- > key-value ���·� ������ �Ǹ� key���� �ε����� ���� �÷���, value���� ���� �����
-- �ּҰ��� �����.
-- * ���� : �˻��ӵ��� �������� �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����ų �� ����.
-- * ���� : 1. �ε����� ���� �߰� ���� ������ �ʿ��ϰ�, �ε����� �����ϴµ� �ð��� �ɸ�
--         2. �������� �����۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ�� ���̺� INDEX ������
--            ������ �������ϰ� �߻��� �� ����.
-- SELECT�� �� ���Ǵ� BUFFER CACHE�� �÷����� �۾�
-- * � �÷��� �ε����� ����� ������?
-- �����Ͱ��� �ߺ��� ���� ���� ������ �����Ͱ��� ������ �÷��� ����� ���� ���� ����.
-- �׸��� ���� ���Ǵ� �÷��� ����� ����.
-- * ȿ������ �ε��� ��� ��
-- where���� ���� ���Ǵ� �÷��� �ε��� ����
-- > ��ü ������ �߿��� 10% ~ 15% �̳��� �����͸� �˻��ϴ� ���, �ߺ��� ���� ���� �÷��̾�� ��.
-- > �� �� �̻��� �÷� WHERE���̳� ����(join) �������� ���� ���Ǵ� ���
-- > �� �� �Էµ� �������� ������ ���� �Ͼ�� �ʴ� ���
-- > �� ���̺� ����� ������ �뷮�� ����� Ŭ ���
--* ��ȿ������ �ε��� ��뿹
-- �ߺ����� ���� �÷��� ���� �ε���
-- NULL���� ���� �÷��� ���� �ε���

-- INDEX ���� ��ȸ
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
-- �ѹ��� ������ �ʾ����� PK, UNIQUE �������� �÷��� �ڵ����� ������ �̸��� �ε����� ������

-- INDEX ����
-- CREATE INDEX �ε����� ON ���̺��(�÷���1, �÷���2, ...);
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '������';
-- ����Ŭ �÷�, Ʃ���� �� ����ϰ� F10���� ���డ����.
CREATE INDEX IDX_EMP_NAME ON EMPLOYEE(EMP_NAME);

-- �ε��� ����
DROP INDEX IDX_EMP_NAME;


SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';
SELECT * FROM USER_TABLES;

-- ������ ��ųʸ�(DD, DATA DICTIONARY)
-- > �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
-- > ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
-- �۾��� �� �� �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺�
-- ����. ����ڴ� ������ ��ųʸ��� ������ ���� �����ϰų� ������ �� ����.
-- ������ ��ųʸ� �ȿ��� �߿��� ������ ���� �ֱ� ������ ����ڴ� �̸� Ȱ���ϱ� ����
-- ������ ��ųʸ� ��(�������̺�)�� ����ϰ� ��.

-- ������ ��ųʸ� ���� ����1
-- 1. USER_XXXX
-- > �ڽ�(����)�� ������ ��ü � ���� ���� ��ȸ����
-- ����ڰ� �ƴ� DB���� �ڵ�����/�������ִ� ���̸� USER_�ڿ� ��ü���� �Ἥ ��ȸ��.
-- 2. ALL_XXXX
-- > �ڽ��� ������ �����ϰų� ������ �ο����� ��ü � ���� ���� ��ȸ����
-- 3. DBA_XXXX
-- > �����ͺ��̽� �����ڸ� ������ ������ ��ü � ���� ���� ��ȸ����
-- (DBA�� ��� ������ �����ϹǷ� �ᱹ DB�� �ִ� ��� ��ü�� ���� ��ȸ ����)
-- �Ϲݻ���ڴ� ������
SELECT * FROM DBA_TABLES;

-- 1. VIEW
-- 2. SEQUENCE
-- 3. ROLE
-- 4. INDEX


-- PL/SQL

SET SERVEROUTPUT ON;
-- sqldeveloper�� ���ٰ� ���� �� ���� �����ؾ���
-- �����ߴµ� �ȳ����� ��(DBMS_OUTPUT.PUT_LINE�����µ�..)

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO');
END;
/

-- #PL/SQL
-- > Oracle's Procedural Language Extension to SQL�� ����
-- > ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���ν� 
-- SQL�� ������ �����Ͽ� SQL ���峻���� ������ ����, ����ó��, �ݺ�ó�� ���� ������

-- ## PL/SQL�� ����(�͸���)
-- 1. �����(����)
-- DECLARE : ������ ����� �����ϴ� �κ�
-- 2. �����(�ʼ�)
-- BEGIN : ���, �ݺ���, �Լ� ���� �� ���� ���
-- 3. ����ó����(����)
-- EXCEPTION : ���ܻ��� �߻��� �ذ��ϱ� ���� ���� ���
-- END; --��� ����
-- /    -- PL/SQL ���� �� ����

-- '������' �̶�� ����� EMP_ID���� �����Ͽ� ID��� ������ �־��ְ� PUT_LINE�� ���� �����
--���� '������' �̶�� ����� ������ 'No Data!!!' ��� ���� ������ ����ϵ��� ��
DECLARE
    vId NUMBER;
BEGIN
    SELECT EMP_ID
    INTO vId
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('ID='||vId);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;
/

-- ## ���� ����
-- ������ [CONSTANT] �ڷ���(����Ʈũ��) [NOT NULL] [:=�ʱⰪ];

-- ## ������ ����
-- �Ϲݺ���, ���, %TYPE, %ROWTYPE, ���ڵ�(RECORD)

-- ## ���
-- �Ϲݺ����� �����ϳ� CONSTANT��� Ű���尡 �ڷ��� �տ� �ٰ�
-- ����ÿ� ���� �Ҵ����־�� ��.


-- PL/SQL������ SELECT��
-- > SQL���� ����ϴ� ��ɾ �״�� ����� �� ������ SELECT ���� ����� ���� ����
-- ������ �Ҵ��ϱ� ���� �����.

--����1)
--PL/SQL�� SELECT������ EMPLOYEE ���̺��� �ֹι�ȣ�� �̸� ��ȸ�ϱ�
DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE; -- CHAR(14)
    VENAME EMPLOYEE.EMP_NAME%TYPE; -- VARCHAR2(20)
BEGIN
    SELECT EMP_NO AS �ֹι�ȣ, EMP_NAME AS �̸�
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�ֹε�Ϲ�ȣ : '||VEMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VENAME);
END;
/

--���� 2)
--������ ����� �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHIREDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, HIRE_DATE
    INTO VENAME, VSALARY, VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||VHIREDATE);
END;
/

--���� 3)
--�����ȣ�� �Է� �޾Ƽ� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
   VENAME EMPLOYEE.EMP_NAME%TYPE;
   VSALARY EMPLOYEE.SALARY%TYPE;
   VHIREDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
   SELECT EMP_NAME, SALARY, HIRE_DATE
   INTO VENAME, VSALARY, VHIREDATE
   FROM EMPLOYEE
   WHERE EMP_ID = '&EMPID';
   DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
   DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
   DBMS_OUTPUT.PUT_LINE('�Ի��� : '||VHIREDATE); 
END;
/
--���̵�޼��� = '&EMPID' : ���� Ư������ �ȵ�


--���� 4)
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ���,���޸��� ��µǵ��� PL/SQL�� ����� ���ÿ�
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VJOBNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO VNAME, VDEPTTITLE, VJOBNAME
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
    LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VNAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '|| VDEPTTITLE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '|| VJOBNAME);
END;
/

-- ### PL/SQL�� ���ù�
-- ��� ������� ����� ������� ���������� �����
-- ������ ���������� �����Ϸ��� IF���� ����ϸ��
-- IF ~ THEN ~ END IF; ��

--����1) �����ȣ�� ������ ����� ���,�̸�,�޿�,���ʽ����� ����ϰ�
-- ���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�' �� ����Ͻÿ�.
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VBONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO VEMPID, VENAME, VSALARY, VBONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '200';
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    -- ���ʽ����� ������ ���ʽ��� ����ϰ�
    -- ���ʽ����� ������(0�̸�) ���ʽ��� ���޹��� �ʴ� ����Դϴ�. ���
    -- IF ~ THEN ~ END IF; ��
    IF(VBONUS <> 0)
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ� : '|| VBONUS * 100 || '%');
    ELSE DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
END;
/
-- VBONUS <> 0 : 0�� �ƴ�

--����2) ��� �ڵ带 �Է� �޾����� ���, �̸�, �����ڵ�, ���޸�, �Ҽ� ���� ����Ͻÿ�
--�׶�, �ҼӰ��� J1,J2 �� �ӿ���, �׿ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VJOBCODE EMPLOYEE.JOB_CODE%TYPE;
    VJOBNAME JOB.JOB_NAME%TYPE;
    VTEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
    INTO VEMPID, VEMPNAME, VJOBCODE, VJOBNAME
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMPID';    
    IF(VJOBCODE IN ('J1', 'J2'))
    THEN VTEAM := '�ӿ���';
    ELSE VTEAM := '�Ϲ�����';
    END IF;
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||VJOBCODE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '||VJOBNAME);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : '|| VTEAM);
END;
/

--## ���� �ǽ� 1 ##
-- ��� ��ȣ�� ������ �ش� ����� ��ȸ, �̶� �����,�μ��� �� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ��� �Դϴ�' �� ����ϰ�
DECLARE
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VDCODE DEPARTMENT.DEPT_ID%TYPE;  
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, DEPT_ID
    INTO VEMPNAME, VDTITLE, VDCODE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VEMPNAME);
    IF(VDCODE IS NULL)
    THEN DBMS_OUTPUT.PUT_LINE('�μ��� ���� ����Դϴ�.');
    ELSE DBMS_OUTPUT.PUT_LINE('�μ��� : '|| VDTITLE);
    END IF;
END;
/


--## ���� �ǽ�2 ##
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�

--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A

DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SGRADE VARCHAR2(3);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    
    VSALARY := VSALARY / 10000;
    IF(VSALARY BETWEEN 0 AND 100) THEN SGRADE := 'F';
    ELSIF(VSALARY >= 100 AND VSALARY <= 199) THEN SGRADE := 'E';
    ELSIF(VSALARY >= 200 AND VSALARY <= 299) THEN SGRADE := 'D';
    ELSIF(VSALARY BETWEEN 300 AND 399) THEN SGRADE := 'C';
    ELSIF(VSALARY BETWEEN 400 AND 499) THEN SGRADE := 'B';
    ELSE SGRADE := 'A';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : '|| VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| VSALARY);
    DBMS_OUTPUT.PUT_LINE('��� : '|| SGRADE);
    
END;
/

-- CASE������
-- ����1)
-- CASE ����
--      WHEN ��1 THEN ���๮1;
--      WHEN ��2 THEN ���๮2;
--      ELSE ���๮3;
-- END CASE;
-- ����2)
-- CASE 
--      WHEN ����1 THEN ���๮1;
--      WHEN ����2 THEN ���๮2;
--      ELSE ���๮3;
-- END CASE;

DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SGRADE VARCHAR2(3);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&�˻��һ��';
    VSALARY := VSALARY / 10000;
    CASE FLOOR(VSALARY/100)
        WHEN 0 THEN SGRADE := 'F';
        WHEN 1 THEN SGRADE := 'F';
        WHEN 2 THEN SGRADE := 'F';
        WHEN 3 THEN SGRADE := 'F';
        WHEN 4 THEN SGRADE := 'F';
        ELSE SGRADE := 'A';
    END CASE;
    CASE       
        WHEN (VSALARY >= 0 AND VSALARY <= 99)    THEN SGRADE := 'F';
        WHEN (VSALARY BETWEEN 100 AND 199)       THEN SGRADE := 'E';
        WHEN (VSALARY BETWEEN 200 AND 299)       THEN SGRADE := 'D';
        WHEN (VSALARY >= 300 AND VSALARY <= 399) THEN SGRADE := 'C';
        WHEN (VSALARY >= 400 AND VSALARY <= 499) THEN SGRADE := 'B';
        ELSE SGRADE := 'A';
    END CASE;
    CASE       
        WHEN (VSALARY >= 0 AND VSALARY <= 99)    THEN SGRADE := 'F';
        WHEN (VSALARY <= 199) THEN SGRADE := 'E';
        WHEN (VSALARY <= 199) THEN SGRADE := 'D';
        WHEN (VSALARY <= 199) THEN SGRADE := 'C';
        WHEN (VSALARY <= 199) THEN SGRADE := 'B';
        ELSE SGRADE := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('��� : '|| VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| VSALARY || '����');
    DBMS_OUTPUT.PUT_LINE('��� : '|| SGRADE);
END;
/






