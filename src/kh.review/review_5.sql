--DAY07--------------------------

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
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE = '���������');

--3. �Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� 
--���,�̸�,�Ŵ��� �̸�, ������ ���Ͻÿ�.
SELECT EMP_ID, EMP_NAME, (SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID=E.MANAGER_ID)"�Ŵ��� �̸�", SALARY
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL;

--�Ŵ����� �ִ� ��� �� ������ ��ü��� �Ѵ� ������ ��� �̸� �Ŵ����̸� ���� ���
SELECT EMP_ID, EMP_NAME
,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "�Ŵ��� �̸�", SALARY
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- �����ȣ    �����     ����    ��տ���    ����-��տ���
SELECT EMP_ID, EMP_NAME, SALARY, AVG_SAL ��տ���, SALARY - AVG_SAL ������
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);

-- ����� '+' ǥ���ϱ�
SELECT EMP_ID, EMP_NAME, SALARY, AVG_SAL ��տ���
,(CASE WHEN SALARY - AVG_SAL>0 THEN '+'END)||(SALARY - AVG_SAL)������
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);










