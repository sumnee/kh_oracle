---@ 서브쿼리
--- > 하나의 SQL문 안에 포함되어 있는 또다른 SQL문(SELECT)
--- > 메인쿼리가 서브쿼리를 포함하는 종속적인 관계
--@특징
--1. 서브쿼리는 연산자의 오른쪽에 위치해야함
--2. 반드시 소괄호로 묶어야함


--EX문제
--1. 전지연 직원의 관리자 이름을 출력하라
--전지연의 관리자ID 찾기-> 관리자ID로 직원 이름 구하기
SELECT MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '전지연'; --214
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = '214';
--서브쿼리로 한번에
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '전지연');

--2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하시오
--평균 급여를 구한다 -> 평균급여보다 많은 급여를 받는 직원을 조회
SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE; -- 3047662
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE
WHERE SALARY > 3047662;
-- 서브쿼리로 한번에
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--@ 서브쿼리의 유형
--- 1. 단일행 서브쿼리(조회 결과가 1개)
--- 2. 다중행 서브쿼리(조회 결과가 여러개)
--- 3. 다중열 서브쿼리
--- 4. 다중행 다중열 서브쿼리
--- 5. 상호연관 서브쿼리 
--- 6. 스칼라 서브쿼리

--다중행 서브쿼리 : 일반 비교연산자 사용이 불가능 (IN ANY ALL EXIST 사용)
--@ IN : 비교 조건이 결과 중에서 하나라도 일치하는 것
--EX1 송중기, 박나라의 부서에 속한 사원 정보 출력
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('송중기','박나라'));

--EX2 차태현, 전지연 사원의 급여등급(sal_level)과 같은 사원의 직급명, 사원명을 출력.
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN ('차태연','전지연'));

--EX3 ASIA1 지역에 근무하는 사원의 부서코드, 사원명
--JOIN 사용
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1';

--서브쿼리 사용
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1');

--@ NOT IN : 쿼리의 비교조건이 하나도 일치하지 않는 것
--EX1 직급이 대표, 부사장이 아닌 모든 사원을 부서별로 출력
SELECT  DEPT_CODE, EMP_NAME
FROM EMPLOYEE
WHERE JOB_CODE NOT IN (SELECT JOB_CODE FROM JOB
WHERE JOB_NAME IN ('대표','부사장'))
ORDER BY 1;

--@ 상호연관 서브쿼리 : 메인쿼리의 값을 서브쿼리에 주고 수행한 다음
--  그 결과를 다시 메인쿼리로 반환해서 수행하는 쿼리
--  메인쿼리 수행 -> 서브쿼리 WHERE절 수행
--  메인쿼리의 레코드에 따라 서브쿼리의 결과 값도 바뀜

--일반 서브쿼리
SELECT EMP_NAME, SALARY
FROM EMPLOYEE WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '대표');
--상관 서브쿼리
SELECT EMP_NAME, SALARY
FROM EMPLOYEE WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

--EX1 부하직원이 한명이라도 있는 직원 출력
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E WHERE EXISTS(SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID=E.EMP_ID);
--1 TRUE / 0 FALSE
--DISTINCT 중복제거 / EXISTS 존재여부

--EX2 DEPT_CODE가 없는 사람 출력(상관 서브쿼리로)
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE E 
WHERE NOT EXISTS(SELECT 1 FROM DEPARTMENT  WHERE DEPT_ID = E.DEPT_CODE);

SELECT EMP_NAME FROM EMPLOYEE WHERE DEPT_CODE IS NULL; --일반

--EX3 가장 많은 급여를 받는 사원
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E 
WHERE NOT EXISTS(SELECT 1 FROM EMPLOYEE  WHERE SALARY > E.SALARY);--상관쿼리
SELECT EMP_NAME FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);--일반쿼리

--EX4 직급이 J1, J2, J3이 아닌 사원중에서 자신의 부서별 평균급여보다 많은 급여를 받는 사원출력.
-- 부서코드, 사원명, 급여, 부서별 급여평균
SELECT E.DEPT_CODE, E.EMP_NAME, E.SALARY, AVG_SAL
FROM EMPLOYEE E
JOIN (SELECT DEPT_CODE,ROUND(AVG(SALARY)) "AVG_SAL"
FROM EMPLOYEE GROUP BY DEPT_CODE) A ON E.DEPT_CODE = A.DEPT_CODE
WHERE JOB_CODE NOT IN ('J1','J2','J3') AND E.SALARY > AVG_SAL;


--@ 스칼라 서브쿼리 : 결과값이 하나인 상관서브쿼리, SELECT문에서 사용됨

----스칼라 서브쿼리 SELECT절
--EX 사원명 부서명 부서별 평균임금을 스칼라 서브쿼리로 출력 
SELECT EMP_NAME AS 사원명, DEPT_TITLE AS 부서명, 
(SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = D.DEPT_ID) "부서별 평균임금"
FROM EMPLOYEE
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID;

----스칼라 서브쿼리 WHERE절
--EX 자신이 속한 직급의 평균 급여보다 많이 받는 직원의 이름 직급 급여 출력 ??

SELECT ROUNG(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = 'D6';

----스칼라 서브쿼리 ORDER BY절
--EX 모든 직원의 사번 이름 소속부서를 조회 후 부서명 오름차순 정렬

--@  인라인 뷰 : FROM절에서 서브쿼리를 사용
SELECT EMP_ID, SALARY
FROM (SELECT EMP_ID, SALARY, EMP_NAME, EMP_NO FROM EMPLOYEE);

--*VIEW : 실제테이블에 근거한 가상 테이블, 사용자가 하나의 테이블로 사용 가능
-- 1. STORED VIEW : 영구적 사용 가능
-- 2. INLINE VIEW : FROM절에 사용하는 서브쿼리, 1회용

--EX1 2010년도에 입사한 사원의 사번, 사원명, 입사년도를 인라인뷰를 사용해서 출력.
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 입사년도 FROM EMPLOYEE) 
WHERE 입사년도 BETWEEN 2010 AND 2019;

--EX2 사원중 30대, 40대인 여자사원의 사번, 부서명, 성별, 나이를 인라인뷰를 사용해서 출력하라.
SELECT *
FROM
(SELECT EMP_ID, DEPT_TITLE, 
DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별, 
EXTRACT(YEAR FROM SYSDATE) - (1900+TO_NUMBER(SUBSTR(EMP_NO,1,2))) 나이
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID)
WHERE 성별 = '여' AND 나이 BETWEEN 30 AND 49;


--@ 고급쿼리
--TOP-N분석
--WITH
--계층형 쿼리
--윈도우 함수(순위함수) 






