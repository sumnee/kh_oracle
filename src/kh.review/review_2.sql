--Day03_04-----------------

--3. ��¥ó���Լ�
--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 3������ �� ��¥�� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �������� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;

--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի���� ���������� ��ȸ�ϼ���
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

--EMPLOYEE ���̺��� ��� �̸�, �Ի� �⵵, �Ի� ��, �Ի� ���� ��ȸ�Ͻÿ�
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'��' �Ի�⵵, EXTRACT(MONTH FROM HIRE_DATE)||'��' �Ի��, EXTRACT(DAY FROM HIRE_DATE)||'��' �Ի���
FROM EMPLOYEE;

/*
     ���úη� �Ͽ��ھ��� ���뿡 ���ϴ�.
     ������ �Ⱓ�� 1�� 6������ �Ѵٶ�� �����ϸ�
     ù��°,�������ڸ� ���Ͻð�,
     �ι�°,�������ڱ��� �Ծ���� «���� �׷���� ���մϴ�.
     (��, 1�� 3���� �Դ´ٰ� �Ѵ�.)
*/
SELECT ADD_MONTHS(SYSDATE,18) ������, (ADD_MONTHS(SYSDATE,18)-SYSDATE)*3 �Ļ��
FROM DUAL;

-- ���� �ǽ� ���� 
-- 1. �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
SELECT EMP_NAME, EMP_NO, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)) BETWEEN 5 AND 10;


-- 2. �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE,(ENT_DATE - HIRE_DATE) �ٹ��Ⱓ, ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- 3. �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME, SALARY*1.5 �޿�, CEIL((SYSDATE-HIRE_DATE)/365) �ټӳ��
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >= 10
ORDER BY 3;

-- 4. �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE, SALARY
FROM EMPLOYEE
WHERE SALARY <= 2000000 AND HIRE_DATE BETWEEN '99/01/01' AND '10/01/01';

-- 5. �޿��� 2000000�� ~ 3000000�� �� ���� ���� �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE,'����')
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 3000000) AND EMP_NO LIKE '__04__-2%'
ORDER BY 2 DESC;

-- 6. ����� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME, FLOOR((SYSDATE-HIRE_DATE)/1000)*0.1*SALARY Ư�����ʽ�
FROM EMPLOYEE
WHERE BONUS IS NULL AND SUBSTR(EMP_NO,8,1) = '1'
ORDER BY 1;



--DAY04--------------------------------
--@@�ǽ�����
--1. ���̺��� ������� �޿� �� ���� ���
SELECT TO_CHAR(SUM(SALARY),'L999,999,999')
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. ���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ������ ���
SELECT SUM(SALARY*12+SALARY*NVL(BONUS,0))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. ���̺��� �� ����� ���ʽ� ����� �Ҽ� ��°¥������ �ݿø��Ͽ� ���Ͽ���
SELECT ROUND(AVG(NVL(BONUS,0)),2)
FROM EMPLOYEE;

--4. ���̺��� D5 �μ��� ���� �ִ� ����� ���� ��ȸ
SELECT COUNT(*) �����
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--5. ���̺��� ������� �����ִ� �μ��� ���� ��ȸ (NULL�� ���ܵ�)
SELECT COUNT (DISTINCT DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

--6. ���̺��� ��� �� ���� ���� �޿�, ���� ���� �޿��� ��ȸ
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;


--7. ���̺��� ���� ������ �Ի��ϰ� ���� �ֱ� �Ի����� ��ȸ�Ͻÿ�
SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;

--GROUP BY
--�μ��� �޿� �հ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;

--���޺� �޿� �հ�
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

--�μ��ڵ� �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��), �ο����� ��ȸ�ϰ�, �μ��ڵ� ������ ����
SELECT DEPT_CODE, SUM(SALARY), ROUND(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;

--���̺��� �μ��ڵ� �׷캰, ���ʽ��� ���޹޴� ��� ���� ��ȸ�ϰ� �μ��ڵ� ������ ����
--BONUS�÷��� ���� �����Ѵٸ�, �� ���� 1�� ī����/���ʽ��� ���޹޴� ����� ���� �μ��� ����.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;

--@�ǽ�����
--1. EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���.
SELECT JOB_CODE, COUNT(*), FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE
ORDER BY 1;

--2. EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵, COUNT(*) �ο���
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY 1;

--3. ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ (����ó��)�޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��') ����, FLOOR(SUM(SALARY)), COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��') 
ORDER BY �ο��� DESC;

--4. �μ��� ���� �ο����� ���ϼ���.
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��') ����, COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��');






