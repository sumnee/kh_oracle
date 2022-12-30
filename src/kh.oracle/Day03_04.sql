
CREATE TABLE USER_GRADE (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

DESC USER_GRADE

SELECT * FROM USER_GRADE;
INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');
    
CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE(GRADE_CODE)
);

SELECT CONSTRAINTS_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'USER_FOREIGNKEY';
DESC USER_CONSTRAINTS

INSERT INTO USER_FOREIGNKEY
VALUES (1, 'USER01','PASS01','��','��','EMAIL1@',10);
INSERT INTO USER_FOREIGNKEY
VALUES (2, 'USER02','PASS02','��','��','EMAIL2@',20);
INSERT INTO USER_FOREIGNKEY
VALUES (3, 'USER03','PASS03','��','��','EMAIL3@',30);
INSERT INTO USER_FOREIGNKEY
VALUES (4, 'USER04','PASS04','��','��','EMAIL4@',40);

SELECT GRADE_CODE, GRADE_NAME FROM USER_GRADE;
----USER_GRADE ���� GRADE_CODE, GRADE_NAME ����ؼ� ���°�


--FK �ڽ����̺��� �����ϴ� �θ����̺� �����ʹ� ���������� �����ɼ� �ɰ� ����
--1. ON DELETE SET NULL - �ڽ����̺� ������ NULL��
--2. ON DELETE CASCASE - �ڽ����̺� ������ ����


--1. ������ �̸��� �̸��ϱ��� ���
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL) 
FROM EMPLOYEE;

--2. ������ �̸��� �̸��� �ּ��߾��̵� �κи� ����Ͻÿ�
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1, 6), SUBSTR(EMAIL,1,INSTR('@', 1, 1))
FROM EMPLOYEE;

--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. 
--���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� 
SELECT EMP_NAME, SUBSTR(EMP_NO,1, 2) AS ���, NVL(BONUS,0)
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';
 
--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ� ex) 3��)
SELECT 
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
--	ex) ������		1997�� 3��
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'�� '||EXTRACT(MONTH FROM HIRE_DATE)||'��' AS �Ի���
FROM EMPLOYEE;


--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME, (SUBSTR(EMP_NO,1,8) || '******') AS �ֹε�Ϲ�ȣ
FROM EMPLOYEE;

--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--  ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME, JOB_CODE, TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999') AS "����(��)"
FROM EMPLOYEE;
--'L000,000,000' �ϸ� ���ڸ� 0���� ä��

--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND (SUBSTR(HIRE_DATE,1,2) = '04');

--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) AS �ٹ��ϼ�
FROM EMPLOYEE;

--10. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	* �ֹι�ȣ�� �̻��� ������� ���ܽ�Ű�� ���� �ϵ���(200,201,214 �� ����)
SELECT EMP_NAME, DEPT_CODE, '19'||SUBSTR(EMP_NO,1,2)||'�� '||SUBSTR(EMP_NO,3,2)||'�� '||SUBSTR(EMP_NO,5,2)||'��' AS �������, 
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "����(��)"
FROM EMPLOYEE 
WHERE EMP_ID NOT IN (200,201,245);
--EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) ->YY �ϸ� 1986 �ƴ϶� 2086 ����
--EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,3,2),'MM'))
--EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,5,2),'DD')) ��¥ó�� �Լ��� ������� ���ϱ�
--EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS "����(��)" ����ó�� �Լ��� ���� ���ϱ�
--2000�� ���� ����� DECODE ����Ͽ� 1,2�� 1900 /3,4�� 2000���϶� �� ���� �ϱ�

--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME AS �����, CASE 
    WHEN DEPT_CODE='D5' THEN '�ѹ���'
    WHEN DEPT_CODE='D6' THEN '��ȹ��'
    WHEN DEPT_CODE='D9' THEN '������' END AS �μ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY �μ��� ASC;
--DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������') �̰͵� ����

--1. ����ó���Լ�
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402' , '0123456789'),'0123456789')
FROM DUAL;
--����ϱ� ���� ������ ǥ DUAL ���

-- ������� ���� �ߺ����� ���������� ����ϼ���.
SELECT SUBSTR(EMP_NAME,1,1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;
--��Ī�༭ ����ϰ�! �ƴϸ� �ι� ����Ѵ�
--EX. ORDER BY SUBSTR(EMP_NAME,1,1) ASC;

--�ߺ����� ���
SELECT DISTINCT SUBSTR(EMP_NAME,1,1)
FROM EMPLOYEE
ORDER BY 1 ASC;
--DISTINCT �ߺ�����
--ù �÷��̴ϱ� "1" ����ؼ� �̰͵� ����

-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');
--�Ʒ� �ΰ��� ����� ����
--SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8) || '******', SALARY*12
--SELECT EMP_ID, EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8),'******'), SALARY*12


--2. ����ó���Լ�
--EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� 
SELECT EMP_NAME, ROUND(SYSDATE - HIRE_DATE) "�ٹ��ϼ�"
FROM EMPLOYEE;
--ROUND �ݿø� / FLOOR ���� / CEIL �ø�

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
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM HIRE_DATE)||'��',
EXTRACT(MONTH FROM HIRE_DATE)||'��',EXTRACT(DAY FROM HIRE_DATE)||'��'
FROM EMPLOYEE;

/*
     ���úη� �Ͽ��ھ��� ���뿡 ���ϴ�.
     ������ �Ⱓ�� 1�� 6������ �Ѵٶ�� �����ϸ�
     ù��°,�������ڸ� ���Ͻð�,
     �ι�°,�������ڱ��� �Ծ���� «���� �׷���� ���մϴ�.
     (��, 1�� 3���� �Դ´ٰ� �Ѵ�.)
*/
SELECT ADD_MONTHS(SYSDATE, 18) "��������", 
(ADD_MONTHS(SYSDATE, 18) - SYSDATE) * 3 "�Ļ�"
FROM DUAL;

-- ���� �ǽ� ���� 
-- 1. �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
SELECT EMP_NAME, EMP_NO, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) BETWEEN 5 AND 10;                                                                                

-- 2. �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE,(ENT_DATE - HIRE_DATE) AS �ٹ��Ⱓ, ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- 3. �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME, SALARY * 1.5, CEIL((SYSDATE-HIRE_DATE)/365) AS "�ټӳ��"
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >= 10
ORDER BY 3 ASC;

-- 4. �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE, SALARY 
FROM EMPLOYEE
WHERE (HIRE_DATE BETWEEN TO_DATE('99/01/01') AND TO_DATE('10/01/01'))
AND SALARY <= 2000000;

-- 5. �޿��� 2000000�� ~ 3000000�� �� ���� ���� �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME, EMP_NO, PHONE, NVL(DEPT_CODE,'����')
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 2 AND SUBSTR(EMP_NO,4,1) = 4 AND (SALARY BETWEEN 2000000 AND 3000000)
--EMP_NO LIKE '__04__-2%' �̰͵� ����
ORDER BY 2 DESC;

-- 6. ����� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME, FLOOR((SYSDATE-HIRE_DATE)/1000)*0.1*SALARY AS Ư�����ʽ� 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1 AND BONUS IS NULL
--EMP_NO LIKE '%-1%' �̰͵� ����
ORDER BY 1 ASC;

--�ֹι�ȣ ���� ���� �����ϱ�
SELECT  
    EMP_NAME, DECODE (SUBSTR(EMP_NO,8,1), '1','��','2','��','3','��','4','��')
FROM EMPLOYEE;
