DESC EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, SALARY*12 AS "����"
FROM EMPLOYEE
WHERE SALARY>3000000 OR EMP_NAME = '������'
ORDER BY SALARY ASC;
--WHERE�� ���� �˻�(�� ����)
--AND OR �������� ��� ����
--ASC �������� DESC ��������   //NULL�� ���� �۰� �νĵ�
--FROM -> WHERE -> SELECT -> ORDER BY(�������� ����)

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 6000000
ORDER BY SALARY ASC;
--WHERE SALARY>2000000 AND SALARY<6000000 �� ����!

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8');
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' �� ����!

SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
--WHERE BONUS IS NULL; 

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
-- �� ���� �����ϴ� ������ ã��
-- %��% ���� �� �� //NOT LIKE ����

--1. ������ ������ �̸� ã��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
-- '_��' �Ͽ� -> �̰͸� ���� / '__��' ���̿� (����� �ϳ� �� �ѱ���)
-- '%��' �� �Ͽ� ���̿� ���̻￬ ... �� ����(�ۼ�Ʈ �ڸ��� ���̰� �������� ����)

--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ���
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3. 
EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND EMAIL LIKE '%S%' 
AND DEPT_CODE IN ('D6','D9') 
AND SALARY >= 2700000;

--4. EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--5. EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 
--����ٸ� ���ڷ� ����ϱ� ���� ESCAPE ���

--6. ������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ����  ������ �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--7. �μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--8. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%*12))�� ��µǵ��� �Ͻÿ�
SELECT EMP_NAME AS "�̸�", SALARY*12 AS "����", SALARY*12+SALARY*BONUS AS "�Ѽ��ɾ�(���ʽ�����)",
(SALARY*12 + SALARY*BONUS)-(SALARY*0.03*12) AS "�Ǽ��ɾ�" 
FROM EMPLOYEE;

--9. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ�.(SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME "�̸�", SYSDATE - HIRE_DATE "�ٹ��ϼ�" 
FROM EMPLOYEE;
--SYSDATE ���� ��¥

--10. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�.
SELECT EMP_NAME "�̸�", SALARY "����", BONUS "���ʽ���"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 >= 20;





