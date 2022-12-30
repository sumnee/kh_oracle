--@@@@ HAVING

--�μ��� �޿� ����� 3,000,000��(��������) �̻���  �μ��鿡 ���ؼ� �μ���, �޿������ ����ϼ���.
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;
--GROUP BY�� ������ ����� ���� ���� HAVING / ������ WHERE�� �ٸ��� �ڿ� ����

--@�ǽ�����
--1. �μ��� �ο��� 5���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) >5;

--2. �μ��� �� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >=3;

--3. �Ŵ����� �����ϴ� ����� 2�� �̻��� �Ŵ��� ���̵�� �����ϴ� ����� ���
SELECT MANAGER_ID, COUNT(*) �����
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL
ORDER BY 1;

--@@@@ ROLLUP // CUBE
SELECT JOB_CODE, COUNT(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

SELECT JOB_CODE, COUNT(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;
--��� �ΰ��� �ڵ�ó�� �׷� ������ �ϳ��� ��쿡 ���̰� ����


--�μ��� ���޺� �޿� �հ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--�μ��� ��

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--�μ��� ���޺� ��

--@@@@ ���տ����� RESULTSET
--������ INTERSECT 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;

--������ UNION(�ߺ� ����) / UNION ALL(�ߺ� ���)
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;
--UNION ����� ����
--1.SELECT���� �÷� ������ �ݵ�� ���ƾ�
--2.�÷��� ������ Ÿ���� �ݵ�� ���ų� ��ȯ �����ؾ�

--������ MINUS 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;

--@@@ JOIN
--�������̺��� ���ڵ带 �����Ͽ� �ϳ��� ���� ǥ��
--�ΰ� �̻��� ���̺��� ������ �ִ� �����͵��� �÷��������� �з��Ͽ� ���ο� ���� ���̺� ���
--��, ���� �ٸ� ���̺��� ������ ���밪�� �̿������μ� �ʵ带 ������

--1. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9');
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

--@@@ JOIN��1
--ANSI ǥ�� ����
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

--����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID;

--EQUI-JOIN : ON �ڿ� �������� ���, �Ϲ��� ���
--NON-EQUI-JOIN : BETWEEN AND, IS NULL, IN ������ ���

--@�ǽ�����

--1. �μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE, LOCAL_NAME FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. ������ ���޸��� ����ϼ���. EMPLOYEE, JOB ���̺� �̿�
--ON ���� Į������ ������ ����, ��ó ���̺��� ǥ�����־����!
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE
JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
--���̺� ��ó ���� ǥ���Ͽ� �ذ�
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;
--���̺� ��Ī ����� ���� �ذ�
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
--USING ����� ���� �ذ�

-- 3. ������� �������� ����ϼ���. LOCATION, NATION ���̺� �̿�
SELECT LOCAL_NAME, NATIONAL_NAME FROM LOCATION
JOIN NATIONAL USING(NATIONAL_CODE);

--@@@ JOIN��2
--INNER JOIN : �Ϲ��� ���, ������
--OUTER JOIN : ������, ��� ���
--- > 1. LEFT  (OUTER) JOIN : LEFT���� ��� ���
--- > 2. RIGHT (OUTER) JOIN : RIGHT���� ��� ���
--- > 3. FULL  (OUTER) JOIN : ��� ���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--LEFT�� DEPT_CODE ���� ��� ���

--����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
--DEPT_ID ���� ��� ��� //DEPT_CODE(+) = DEPT_ID �ϸ� DEPT_CODE������!
--FULL JOIN�� ANSI ǥ�� ������ ����~

--EX.OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM DEPARTMENT RIGHT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE;

--@@@ JOIN��3
--1. CROSS JOIN
--2. SELF JOIN
--3. ���� JOIN : �������� ���ι��� �ѹ��� ��� / ������ �߿�
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--@�ǽ�����
-- ������ �븮�̸鼭, ASIA ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT EMP_ID,EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';

--@ ���� �ǽ�����
--1. 2022�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE(20221225), 'DAY') ũ�������� FROM DUAL;

--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME,EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE (SUBSTR(EMP_NO,1,2)) BETWEEN 70 AND 79 AND SUBSTR(EMP_NO,8,1)='2'
AND EMP_NAME LIKE '��%';

--3. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%��%';

--4. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

--5. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

--6. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';

--7. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_NAME, SALARY, SALARY*12 ����
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVER)
WHERE SALARY > MAX_SAL; ???

--8. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�','�Ϻ�');

--9. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME IN ('����', '���') AND BONUS IS NULL;

--10. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(ENT_YN, 'Y','����', 'N', '����') AS �ټӿ���, COUNT(*) AS ������
FROM EMPLOYEE
GROUP BY DECODE(ENT_YN, 'Y','����', 'N', '����');









