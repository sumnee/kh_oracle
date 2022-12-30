--@DQL���սǽ�����

--1. ��������ο� ���� ������� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�.
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������';

--2. ��������ο� ���� ����� �� ���� ������ ���� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������' AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE = '���������');

--3. �Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� 
--���,�̸�,�Ŵ��� �̸�, ������ ���Ͻÿ�.
SELECT EMP_ID, EMP_NAME
,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "�Ŵ��� �̸�", SALARY
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);


-- # ��������
-- ## 1. CHECK
CREATE TABLE USER_CHECK (
    USER_NO NUMBER PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER CHAR(5)
);
DROP TABLE USER_CHECK;
SELECT * FROM USER_CHECK;

--�̹� ���̺��� ����� �� ���¿��� �������� �߰��ϴ� ���
DELETE FROM USER_CHECK;  --���� ������ �������ϱ� ������ ��������

ALTER TABLE USER_CHECK
ADD CONSTRAINT GENDER_VAL CHECK(USER_GENDER IN('��','��'));
--F M ���� ���� �̷��� �� �� ���� �����ϵ��� �������� CHECK
--CONSTRAINT GENDER_VAL <- ���������� �̸� �����ϴ� ��

INSERT INTO USER_CHECK(USER_NO,USER_NAME,USER_GENDER)
VALUES ('1','��','��');
INSERT INTO USER_CHECK
VALUES ('2','��','��');
INSERT INTO USER_CHECK
VALUES ('3','��','M');
INSERT INTO USER_CHECK
VALUES ('4','��','F');

-- ## 2. DEFAULT
--�÷��� �⺻���� ����
CREATE TABLE USER_DEFAULT(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_DATE DATE DEFAULT SYSDATE,
    USER_YN CHAR(1) DEFAULT 'Y'
);
DROP TABLE USER_DEFAULT;

INSERT INTO USER_DEFAULT(USER_NO,USER_NAME,USER_DATE,USER_YN)
VALUES ('1','��','2022/12/23','Y');
INSERT INTO USER_DEFAULT
VALUES ('2','��',SYSDATE,'N');
INSERT INTO USER_DEFAULT
VALUES ('3','��',DEFAULT,DEFAULT);



--# �������� SELFJOIN
--�Ŵ����� �ִ� ��� �� ������ ��ü��� �Ѵ� ������ ��� �̸� �Ŵ����̸� ���� ���
SELECT EMP_ID, EMP_NAME
,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "�Ŵ��� �̸�", SALARY
FROM EMPLOYEE E --���Ŀ�� �̿�
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

SELECT E.EMP_ID, E.EMP_NAME, M.EMP_NAME FROM EMPLOYEE E
JOIN EMPLOYEE M ON M.EMP_ID = E.MANAGER_ID; --�������� �̿�
--FROM TBL ��Ī �ʼ�!(���� �÷��̴ϱ� �����ؾ���)


--# ��ȣ���� CROSSJOIN
--## ī���̼� �� CARTENSIAL PRODUCT
--   :���εǴ� ���̺��� �� ����� ��� ���ε� ����
--    ���� ���̺��� ������� ���ν��� ��� ����Ǽ��� ���ϹǷ� ��� ������ �� �÷����� ��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT;
--EMPLOYEE 23 * DEPARTMENT 9 ->207

--�Ʒ�ó�� �������� �ϼ���.
----------------------------------------------------------------
-- �����ȣ    �����     ����    ��տ���    ����-��տ���
----------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY, AVG_SAL ��տ���, SALARY-AVG_SAL "����-��տ���"
FROM EMPLOYEE 
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);

-- ����� '+' ǥ���ϱ�
SELECT EMP_ID , EMP_NAME ,SALARY , AVG_SAL ��տ���
,(CASE WHEN SALARY-AVG_SAL > 0 THEN '+' END) || (SALARY-AVG_SAL) AS "����-��տ���"
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);


--TCL
INSERT INTO USER_CHECK (USER_NO,USER_NAME,USER_GENDER)
VALUES ('1','��','��');
INSERT INTO USER_CHECK
VALUES ('2','��','��');
INSERT INTO USER_CHECK
VALUES ('3','��','��');
COMMIT; --��������
INSERT INTO USER_CHECK
VALUES ('4','��','��');
SAVEPOINT TEMP1; --�ӽ�����

ROLLBACK;
ROLLBACK TO TEMP1;
SELECT * FROM USER_CHECK;

--COMMIT �ؾ� �ݿ��Ǿ� �ٸ� ���������� ���δ�!


--DCL   ----> ������ �ý��� �������� �ؾ���
--DB�� ���� ����, ����, ���Ἲ ���� ���� / ������� ����, ������ ���� �� ó��
--���Ἲ? ��Ȯ��, �ϰ����� �����ϴ� ��

--ROLE�� �ʿ��� ������ ��� ����, �ѹ��� �پ��� ������ ����, ȸ�� �� ��
--CONNECT ROLE : CREATE SESSION
--RESOURCE ROLE : CREATE CLUSTER,PROCEDURE,SEQUENCE,TABLE,TRIGGER,TYPE,INDEXTYPE,OPERATOR ...


--ORACLE OBJECT ����Ŭ ��ü : DB�� ȿ�������� ����, �����ϰ�
--����: ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX), ��Ű��(PACKAGE), 
--     ���ν���(PROCEDUAL), �Լ�(FUNCTION), Ʈ����(TRIGGER), ���Ǿ�(SYNONYM), �����(USER)
--1. VIEW : �ϳ� �̻��� ���̺��� ���ϴ� �����͸� �����Ͽ� ������ ���̺��� �������
--   ��������ü�� �����ϴ� ���� �ƴ϶� �ٸ� ���̺��� �����͸� �����ִ� ��
--   ���������� ������ġ �� �����ϴ°��� �ƴ϶� ��ũ �����̴�.
--   --> Ư�� ����ڰ� �������̺��� ��� �����͸� �� �� ���� �並 ���� Ư�������͸� �����ش�
--   �並 ����� ���ؼ��� ������ �ʿ�(�ý��� �������� ����) -> GRANT CREATE VIEW TO KH;
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_NAME, JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_ID = '200';
SELECT * FROM V_EMPLOYEE;
DROP VIEW V_EMPLOYEE;

UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = '200';
--�並 ���� ������ ���� ����

CREATE VIEW V_EMP_DEP
AS SELECT EMP_NAME, JOB_CODE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT * FROM V_EMP_DEP;
--���ε� ����


--2. SEQUENCE : ���������� �������� �ڵ� ����
--   �ɼ� 6����(��������) START WITH,INCREMENT BY, MAXVALUE, MINVALUE, CYCLE, CACHE

CREATE SEQUENCE SEQ_USERNO;
SELECT * FROM USER_SEQUENCES; 
--������� ������ Ȯ��

DELETE FROM USER_DEFAULT; 
--�����ϰ� �������� �ٽ� ��������
INSERT INTO USER_DEFAULT
VALUES(SEQ_USERNO.NEXTVAL, '�ϳ�' ,DEFAULT,DEFAULT);
INSERT INTO USER_DEFAULT
VALUES(SEQ_USERNO.NEXTVAL, '��' ,DEFAULT,DEFAULT);
SELECT * FROM USER_DEFAULT;

SELECT SEQ_USERNO.CURRVAL FROM DUAL;
--���� ������ �� Ȯ�� // ������ ���� CURRVAL���� �����Ѵ�
DROP SEQUENCE SEQ_USERNO; 
--����

CREATE SEQUENCE SQE_SAMPLE1;
ALTER SEQUENCE SQE_SAMPLE1
INCREMENT BY 10;
--����
--START WITH ���� ���� �Ұ����Ͽ�, �����Ϸ��� ���� �� �����ؾ���

SELECT * FROM USER_SEQUENCES;

-- @ NEXTVAL, CURRVAL ����� �� �ִ� ���
--1. ���������� �ƴ� SELECT��
--2. INSERT���� SELECT��
--3. INSERT���� VALUES��
--4. UPDATE���� SET��
-- @ CURRVAL ��� ������
-- NEXTVAL�� ������ 1�� ������ �� CURRVAL ��� ����






