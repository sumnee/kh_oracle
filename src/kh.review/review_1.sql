--DAY01----------------------
CREATE TABLE EXAMPLE(
    NAME VARCHAR2(30),
    AGE NUMBER,
    ADDRESS VARCHAR2(100)
);

DROP TABLE EXAMPLE;

INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('����',50,'���α�');
INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('����',60,'������');
INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('����',30,'�߱�');

UPDATE EXAMPLE
SET AGE = 20
WHERE AGE = 60;

DELETE FROM EXAMPLE
WHERE AGE = 50;

SELECT NAME, AGE
FROM EXAMPLE
WHERE NAME = '����';

--DAY02----------------------
DESC EXAMPLE;

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY 1 ASC;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000
ORDER BY SALARY DESC;

SELECT EMP_NAME, EMP_ID
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8');

SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

--������ ������ �̸� ã��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ���
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--�����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6 
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü������ ���
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%S%' 
AND DEPT_CODE IN ('D6','D9')
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND SALARY >= 2700000;

--EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ����  ������ �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--�μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--�̸�, �ٹ� �ϼ��� ����غ��ÿ�.(SYSDATE�� ���)
SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) �ٹ��ϼ�
FROM EMPLOYEE;

--20�� �̻� �ټ����� �̸�,����,���ʽ����� ���
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (ROUND(SYSDATE-HIRE_DATE)/365) > 20;

--DAY03----------------------
--������ �̸��� �̸��ϱ��� ���
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

--������ �̸��� �̸��� �ּ��߾��̵� �κи� ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@',1,1)-1)
FROM EMPLOYEE;
--INSTR(�÷�,ã�°�,������,���°��)
--������ : 1 �տ������� / -1 �ڿ�������
--���°�� : ù��°�� ã������ 1 �ι�°�� ã������ 2 ...
--3, 4��°ĭ�� ���� ���� -> ���� �� �տ������� ù��°�� ã��

--60��뿡 �¾ ������� ���, ���ʽ� ���� ���(���ʽ� NULL�̸� 0)
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2),NVL(BONUS,0)
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';

--'010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ���(_��)
SELECT COUNT(*)||'��'
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--������� �Ի����� ����Ͻÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
SELECT EMP_NAME ������, 
EXTRACT(YEAR FROM HIRE_DATE)||'�� '
||EXTRACT(MONTH FROM HIRE_DATE)||'��' �Ի���
FROM EMPLOYEE;

--������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO,1,8)||'******' �ֹε�Ϲ�ȣ
FROM EMPLOYEE;

--������, �����ڵ�, ���� ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--  ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME, JOB_CODE, TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999') ����
FROM EMPLOYEE;

--�μ��ڵ尡 D5, D9�� ���� �� 2004�⵵�� �Ի��� ������ ��� ����� �μ��ڵ� �Ի���
SELECT EMP_NO, EMP_NAME, DEPT_CODE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND HIRE_DATE LIKE '04%';

--������, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	 (EMP_ID 200,201,214 �� ����)
SELECT EMP_NAME, '19'||SUBSTR(EMP_NO,1,2)||'�� '||SUBSTR(EMP_NO,3,2)||'�� '||SUBSTR(EMP_NO,5,2)||'��' AS �������, 
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "����(��)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200,201,245);

--������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME, 
CASE
    WHEN DEPT_CODE='D5' THEN '�ѹ���'
    WHEN DEPT_CODE='D6' THEN '��ȹ��'
    WHEN DEPT_CODE='D9' THEN '������' END AS �μ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY �μ��� ASC;

--1. ����ó���Լ�
--���� ���ڿ����� ���ڸ� ���� '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402','0123456789'),'0123456789') FROM DUAL;

-- ������� ���� �ߺ����� ���������� ����ϼ���.
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) ��
FROM EMPLOYEE
ORDER BY �� ASC;

-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8)||'******', SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. ����ó���Լ�
--EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ�
SELECT EMP_NAME, ROUND(SYSDATE - HIRE_DATE) �ٹ��ϼ�
FROM EMPLOYEE;














