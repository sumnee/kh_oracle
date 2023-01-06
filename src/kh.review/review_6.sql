--day08----------------------------

--kh���� ������ �� employee, job, department���̺��� �Ϻ������� ����ڿ��� �����Ϸ��� �Ѵ�.
-- ������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի����� �÷������� ��(v_emp_info)�� (�б� ��������) �����Ͽ���.
CREATE OR REPLACE VIEW V_EMP_INFO
AS SELECT E.EMP_ID ������̵�, E.EMP_NAME �����, JOB_NAME ���޸�, DEPT_TITLE �μ���, M.EMP_NAME �����ڸ�
FROM EMPLOYEE E
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN EMPLOYEE M ON M.EMP_ID = E.MANAGER_ID;

SELECT * FROM V_EMP_INFO;

CREATE OR REPLACE FORCE VIEW V_FORCE_STH
AS SELECT EMP_ID, EMP_NAME FROM NTH_TBL;
SELECT * FROM V_FORCE_STH;
--FORCE : ���̺�, �÷�, �Լ� ���� ��� ������ ����

CREATE OR REPLACE VIEW V_EMP_D6
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' WITH CHECK OPTION;
--WITH CHECK OPTION : WHERE�� ���ǿ� ����� �÷��� ���� �Ұ���
SELECT * FROM V_EMP_D6;
UPDATE V_EMP_D6 SET SALARY=3800000 WHERE EMP_ID = '203';
UPDATE V_EMP_D6 SET DEPT_CODE = 'D1' WHERE SALARY >= 3900000; --�Ұ���

CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE WITH READ ONLY;
--WITH READ ONLY : �б� ����
UPDATE V_EMPLOYEE SET EMP_NAME = '����' WHERE DEPT_CODE = 'D6'; --�Ұ���

--@�ǽ�����
--���� ��ǰ�ֹ��� ����� ���̺� TBL_ORDER�� �����, ������ ���� �÷��� �����ϼ���
-- ORDER_NO(�ֹ�NO) : PK
-- USER_ID(�����̵�)
-- PRODUCT_ID(�ֹ���ǰ���̵�)
-- PRODUCT_CNT(�ֹ�����) 
-- ORDER_DATE : DEFAULT SYSDATE
CREATE TABLE TBL_ORDER(
    ORDER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    PRODUCT_ID VARCHAR(30),
    PRODUCT_CNT NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_ORDERNO;
INSERT INTO TBL_ORDER 
VALUES(SEQ_ORDERNO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDERNO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDERNO.NEXTVAL, 'ring', 'onionring', 50, DEFAULT);
SELECT * FROM ORDER_TBL;


-- �ǽ�����2
--KH_MEMBER ���̺��� ����
--MEMBER_ID	NUNBER
--MEMBER_NAME	VARCHAR2(20)
--MEMBER_AGE	NUMBER
--MEMBER_JOIN_COM	NUMBER
--�̶� �ش� ������� ������ INSERT �ؾ� ��
--ID ���� JOIN_COM�� SEQUENCE �� �̿��Ͽ� ������ �ְ��� ��
CREATE TABLE KH_MEMBER(
    MEMBER_ID NUMBER,
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE NUMBER,
    MEMBER_JOIN_COM NUMBER
);
--1. ID���� 500 �� ���� �����Ͽ� 10�� �����Ͽ� ���� �ϰ��� ��
--2. JOIN_COM ���� 1������ �����Ͽ� 1�� �����Ͽ� ���� �ؾ� ��
--(ID ���� JOIN_COM ���� MAX�� 10000���� ����)
CREATE SEQUENCE SEQ_MEMBERID
START WITH 500
INCREMENT BY 10
MAXVALUE 10000;
CREATE SEQUENCE SEQ_MEMBERJOIN
MAXVALUE 10000;
--	500		        ȫ�浿		20		        1
--	510		        �踻��		30		        2
--	520		        �����		40		        3
--	530		        ����		24		        4
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBERID.NEXTVAL, 'ȫ�浿', 20, SEQ_MEMBERJOIN.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBERID.NEXTVAL, '�踻��', 30, SEQ_MEMBERJOIN.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBERID.NEXTVAL, '�����', 40, SEQ_MEMBERJOIN.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_MEMBERID.NEXTVAL, '����', 24, SEQ_MEMBERJOIN.NEXTVAL);
SELECT * FROM KH_MEMBER;


-- #PL/SQL
-- > ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���ν� 
-- SQL�� ������ �����Ͽ� SQL ���峻���� ������ ����, ����ó��, �ݺ�ó�� ���� ������


-- '������' �̶�� ����� EMP_ID���� �����Ͽ� ID��� ������ �־��ְ� PUT_LINE�� ���� �����
--���� '������' �̶�� ����� ������ 'No Data!!!' ��� ���� ������ ����ϵ��� ��
DECLARE 
    vID NUMBER;
BEGIN 
    SELECT EMP_ID INTO vID FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('ID='||vID);
EXCEPTION
    WHEN NO_dATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA!');
END;
/

--����1)
--PL/SQL�� SELECT������ EMPLOYEE ���̺��� �ֹι�ȣ�� �̸� ��ȸ�ϱ�
DECLARE
    vNO EMPLOYEE.EMP_NO%TYPE; --%TYPE���� �� �÷��� Ÿ���� �������� �� ���
    vNAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NO �ֹι�ȣ,EMP_NAME �̸�
    INTO vNO, vNAME FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�ֹε�Ϲ�ȣ : '||vNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||vNAME);
END;
/

--���� 2)
--�̿��� ����� �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHIREDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, HIRE_DATE
    INTO VNAME, VSALARY, VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_NAME = '�̿���';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
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

--'&EMPID' ���̵� �޼��� : ����, Ư������ �Ұ���

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
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    IF(VBONUS <> 0 )
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ� : '|| VBONUS * 100 || '%');
    ELSE DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �����');
    END IF;
END;
/

--����2) ��� �ڵ带 �Է� �޾����� ���, �̸�, �����ڵ�, ���޸�, �Ҽ� ���� ����Ͻÿ�
--�׶�, �ҼӰ��� J1,J2 �� �ӿ���, �׿ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�

--## ���� �ǽ� 1 ##
-- ��� ��ȣ�� ������ �ش� ����� ��ȸ, �̶� �����,�μ��� �� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ��� �Դϴ�' �� ���
DECLARE 
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VDCODE DEPARTMENT.DEPT_ID%TYPE; 
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, DEPT_ID
    INTO VNAME, VDTITLE, VDCODE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID='&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    IF(VDCODE IS NULL)
    THEN DBMS_OUTPUT.PUT_LINE('�μ��� ���� ����Դϴ�.');
    ELSE DBMS_OUTPUT.PUT_LINE('�μ��� : '||VDTITLE);
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
    VID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SGRADE VARCHAR2(3);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VID, VNAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    
    IF(VSALARY BETWEEN 0 AND 1000000) THEN SGRADE := 'F';
    ELSIF (VSALARY BETWEEN 1000000 AND 2000000) THEN SGRADE := 'E';
    ELSIF (VSALARY BETWEEN 2000000 AND 3000000) THEN SGRADE := 'D';
    ELSIF (VSALARY BETWEEN 3000000 AND 4000000) THEN SGRADE := 'C';
    ELSIF (VSALARY BETWEEN 4000000 AND 5000000) THEN SGRADE := 'B';
    ELSE SGRADE := 'A';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : '|| VID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| VSALARY);
    DBMS_OUTPUT.PUT_LINE('��� : '|| SGRADE);
END;
/
    

























