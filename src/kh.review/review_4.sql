--DAY06----------------------------------------
--1. ������ ������ ������ �̸��� ����϶�
--�������� ������ID ã��-> ������ID�� ���� �̸� ���ϱ�
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '������');

--2. �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿��� ��ȸ�Ͻÿ�
--��� �޿��� ���Ѵ� -> ��ձ޿����� ���� �޿��� �޴� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--EX1 ���߱�, �ڳ����� �μ��� ���� ��� ���� ���
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('���߱�','�ڳ���'));

--EX2 ������, ������ ����� �޿����(sal_level)�� ���� ����� ���޸�, ������� ���.
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN ('���¿�','������'));

--EX3 ASIA1 ������ �ٹ��ϴ� ����� �μ��ڵ�, �����
--JOIN ���
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

--EX ������ ��ǥ, �λ����� �ƴ� ��� ����� �μ����� ���
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
WHERE JOB_CODE NOT IN (SELECT JOB_NAME FROM JOB WHERE JOB_NAME IN ('��ǥ','�λ���'))
ORDER BY 1;

--EX1 ���������� �Ѹ��̶� �ִ� ���� ���
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID=E.EMP_ID);

--EX2 DEPT_CODE�� ���� ��� ���(��� ����������)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT 1 FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE);

--EX3 ���� ���� �޿��� �޴� ���(��� ����������)
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SALARY > E.SALARY);

--EX4 ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����
SELECT E.EMP_NAME, E.DEPT_CODE, E.SALARY, AVG_SAL
FROM EMPLOYEE E
JOIN (SELECT DEPT_CODE, ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE
GROUP BY DEPT_CODE) A ON E.DEPT_CODE = A.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1','J2','J3') AND E.SALARY > AVG_SAL;

--EX ����� �μ��� �μ��� ����ӱ��� ��Į�� ���������� ��� 
SELECT EMP_NAME, DEPT_CODE, (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE 
WHERE DEPT_CODE = D.DEPT_ID) "�μ� ����ӱ�"
FROM EMPLOYEE
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID;

--EX1 2010�⵵�� �Ի��� ����� ���, �����, �Ի�⵵�� �ζ��κ並 ����ؼ� ���.
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵ FROM EMPLOYEE) 
WHERE �Ի�⵵ BETWEEN 2010 AND 2019;

--EX2 ����� 30��, 40���� ���ڻ���� ���, �μ���, ����, ���̸� �ζ��κ並 ����ؼ� ����϶�.
SELECT *
FROM (SELECT EMP_ID, DEPT_TITLE, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') ����, 
EXTRACT(YEAR FROM SYSDATE) - (1900+TO_NUMBER(SUBSTR(EMP_NO,1,2))) ����
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID)
WHERE ���� = '��' AND ���� BETWEEN 30 AND 49; 



