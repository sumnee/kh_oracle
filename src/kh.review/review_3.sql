--DAY05--------------------
--�μ��� �޿� ����� 3,000,000��(��������) �̻���  �μ��鿡 ���ؼ� �μ���, �޿������ ����ϼ���.
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

--@�ǽ�����
--1. �μ��� �ο��� 5���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

--2. �μ��� �� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3;

--3. �Ŵ����� �����ϴ� ����� 2�� �̻��� �Ŵ��� ���̵�� �����ϴ� ����� ���
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL;

--1. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ
SELECT EMP_NAME, DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������') �μ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9');

--ROLLUP // CUBE
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
--�μ���+���޺� ��


--���տ����� RESULTSET
--������ INTERSECT 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;

--������ UNION(�ߺ� ����) / UNION ALL(�ߺ� ���)
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;

--������ MINUS 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;


--JOIN 
--@�ǽ�����
--1. �μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE, LOCAL_NAME FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. ������ ���޸��� ����ϼ���. EMPLOYEE, JOB ���̺� �̿�
--ON ���� Į������ ������ ����, ��ó ���̺��� ǥ�����־����!
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 3. ������� �������� ����ϼ���. LOCATION, NATION ���̺� �̿�
SELECT LOCAL_NAME, NATIONAL_NAME FROM LOCATION
JOIN NATIONAL USING (NATIONAL_CODE);

-- ������ �븮�̸鼭, ASIA ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT

--1. 2022�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT


--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT

--3. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT

--4. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT

--5. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT

--6. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT

--7. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
SELECT

--8. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT

--9. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
SELECT

--10. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT













