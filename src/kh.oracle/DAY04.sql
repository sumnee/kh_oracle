--그룹함수
--SUM AVG COUNT MAX MIN

--실행 순서
--FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY

--@@실습예제
--1. 테이블에서 남사원의 급여 총 합을 계산
SELECT TO_CHAR(SUM(SALARY),'L999,999,999') AS "남 급여 합"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. 테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉을 계산
SELECT TO_CHAR(SUM(SALARY*12+SALARY*NVL(BONUS,0)),'L999,999,999') AS "D5 연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. 테이블에서 전 사원의 보너스 평균을 소수 둘째짜리에서 반올림하여 구하여라
SELECT ROUND(AVG(NVL(BONUS,0)),2) AS "보너스 평균"
FROM EMPLOYEE;
--ROUND 반올림 / 둘째자리 2

--4. 테이블에서 D5 부서에 속해 있는 사원의 수를 조회
SELECT COUNT(*) "D5 사원 수"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
--SELECT COUNT(EMP_NAME)도 가능하지만 *이 빠르다

--5. 테이블에서 사원들이 속해있는 부서의 수를 조회 (NULL은 제외됨)
SELECT COUNT(DISTINCT DEPT_CODE) AS "사원이 속한 부서의 수"
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;
--DISTINCT 사용하기~

--6. 테이블에서 사원 중 가장 높은 급여, 가장 낮은 급여를 조회
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

--7. 테이블에서 가장 오래된 입사일과 가장 최근 입사일을 조회하시오
SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;


--GROUP 함수
--별도의 그룹 지정 없이 사용한 그룹 함수는 단 한개의 결과값만 산출
--여러개의 결과값을 산출하기 위해서는 기준 그룹을 GROUP BY 절에 기술하여 사용
--GROUP BY 는 GROUP 함수가 있어야 사용 가넝~***
--EX. 부서별 급여 합계
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1 ASC;

--직급별 급여 합계
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1 ASC;

--부서코드 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리), 인원수를 조회하고, 부서코드 순으로 정렬
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

--테이블에서 부서코드 그룹별, 보너스를 지급받는 사원 수를 조회하고 부서코드 순으로 정렬
--BONUS컬럼의 값이 존재한다면, 그 행을 1로 카운팅/보너스를 지급받는 사원이 없는 부서도 있음.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;
--COUNT(*) 하면 NULL값도 합계에 넣는다/ 여기서 COUNT(BONUS) 하면 WHERE절 빼도됨

--@실습문제
--1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
SELECT JOB_CODE 직급, COUNT(*) 사원수, FLOOR(AVG(SALARY)) 평균급여
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--2. EMPLOYEE테이블에서 직급이 J1을 제외하고,  입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT EXTRACT(YEAR FROM HIRE_DATE) 입사년도,COUNT(*) 인원수
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY 1 ASC;

--3. 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여') 성별, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여')
ORDER BY 4 DESC;

--4. 부서내 성별 인원수를 구하세요.
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별, COUNT(*) 인원수
FROM EMPLOYEE 
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여');


