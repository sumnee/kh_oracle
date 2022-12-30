--�׷��Լ�
--SUM AVG COUNT MAX MIN

--���� ����
--FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY

--@@�ǽ�����
--1. ���̺��� ������� �޿� �� ���� ���
SELECT TO_CHAR(SUM(SALARY),'L999,999,999') AS "�� �޿� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. ���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ������ ���
SELECT TO_CHAR(SUM(SALARY*12+SALARY*NVL(BONUS,0)),'L999,999,999') AS "D5 ����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. ���̺��� �� ����� ���ʽ� ����� �Ҽ� ��°¥������ �ݿø��Ͽ� ���Ͽ���
SELECT ROUND(AVG(NVL(BONUS,0)),2) AS "���ʽ� ���"
FROM EMPLOYEE;
--ROUND �ݿø� / ��°�ڸ� 2

--4. ���̺��� D5 �μ��� ���� �ִ� ����� ���� ��ȸ
SELECT COUNT(*) "D5 ��� ��"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
--SELECT COUNT(EMP_NAME)�� ���������� *�� ������

--5. ���̺��� ������� �����ִ� �μ��� ���� ��ȸ (NULL�� ���ܵ�)
SELECT COUNT(DISTINCT DEPT_CODE) AS "����� ���� �μ��� ��"
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;
--DISTINCT ����ϱ�~

--6. ���̺��� ��� �� ���� ���� �޿�, ���� ���� �޿��� ��ȸ
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

--7. ���̺��� ���� ������ �Ի��ϰ� ���� �ֱ� �Ի����� ��ȸ�Ͻÿ�
SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;


--GROUP �Լ�
--������ �׷� ���� ���� ����� �׷� �Լ��� �� �Ѱ��� ������� ����
--�������� ������� �����ϱ� ���ؼ��� ���� �׷��� GROUP BY ���� ����Ͽ� ���
--GROUP BY �� GROUP �Լ��� �־�� ��� ����~***
--EX. �μ��� �޿� �հ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1 ASC;

--���޺� �޿� �հ�
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 ASC;

--�μ��ڵ� �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��), �ο����� ��ȸ�ϰ�, �μ��ڵ� ������ ����
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

--���̺��� �μ��ڵ� �׷캰, ���ʽ��� ���޹޴� ��� ���� ��ȸ�ϰ� �μ��ڵ� ������ ����
--BONUS�÷��� ���� �����Ѵٸ�, �� ���� 1�� ī����/���ʽ��� ���޹޴� ����� ���� �μ��� ����.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;
--COUNT(*) �ϸ� NULL���� �հ迡 �ִ´�/ ���⼭ COUNT(BONUS) �ϸ� WHERE�� ������

--@�ǽ�����
--1. EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���.
SELECT JOB_CODE ����, COUNT(*) �����, FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--2. EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,COUNT(*) �ο���
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY 1 ASC;

--3. ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��') ����, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��')
ORDER BY 4 DESC;

--4. �μ��� ���� �ο����� ���ϼ���.
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') ����, COUNT(*) �ο���
FROM EMPLOYEE 
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��');


