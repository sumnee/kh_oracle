--Day03_04-----------------

--3. 날짜처리함수
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'년' 입사년도, EXTRACT(MONTH FROM HIRE_DATE)||'월' 입사월, EXTRACT(DAY FROM HIRE_DATE)||'일' 입사일
FROM EMPLOYEE;

/*
     오늘부로 일용자씨가 군대에 갑니다.
     군복무 기간이 1년 6개월을 한다라고 가정하면
     첫번째,제대일자를 구하시고,
     두번째,제대일자까지 먹어야할 짬밥의 그룻수를 구합니다.
     (단, 1일 3끼를 먹는다고 한다.)
*/
SELECT ADD_MONTHS(SYSDATE,18) 제대일, (ADD_MONTHS(SYSDATE,18)-SYSDATE)*3 식사수
FROM DUAL;

-- 최종 실습 문제 
-- 1. 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
SELECT EMP_NAME, EMP_NO, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)) BETWEEN 5 AND 10;


-- 2. 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE,(ENT_DATE - HIRE_DATE) 근무기간, ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- 3. 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME, SALARY*1.5 급여, CEIL((SYSDATE-HIRE_DATE)/365) 근속년수
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >= 10
ORDER BY 3;

-- 4. 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE, SALARY
FROM EMPLOYEE
WHERE SALARY <= 2000000 AND HIRE_DATE BETWEEN '99/01/01' AND '10/01/01';

-- 5. 급여가 2000000원 ~ 3000000원 인 여자 직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE,'없음')
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 3000000) AND EMP_NO LIKE '__04__-2%'
ORDER BY 2 DESC;

-- 6. 남사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME, FLOOR((SYSDATE-HIRE_DATE)/1000)*0.1*SALARY 특별보너스
FROM EMPLOYEE
WHERE BONUS IS NULL AND SUBSTR(EMP_NO,8,1) = '1'
ORDER BY 1;



--DAY04--------------------------------
--@@실습예제
--1. 테이블에서 남사원의 급여 총 합을 계산
SELECT TO_CHAR(SUM(SALARY),'L999,999,999')
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. 테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉을 계산
SELECT SUM(SALARY*12+SALARY*NVL(BONUS,0))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. 테이블에서 전 사원의 보너스 평균을 소수 둘째짜리에서 반올림하여 구하여라
SELECT ROUND(AVG(NVL(BONUS,0)),2)
FROM EMPLOYEE;

--4. 테이블에서 D5 부서에 속해 있는 사원의 수를 조회
SELECT COUNT(*) 사원수
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--5. 테이블에서 사원들이 속해있는 부서의 수를 조회 (NULL은 제외됨)
SELECT COUNT (DISTINCT DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

--6. 테이블에서 사원 중 가장 높은 급여, 가장 낮은 급여를 조회
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;


--7. 테이블에서 가장 오래된 입사일과 가장 최근 입사일을 조회하시오
SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;

--GROUP BY
--부서별 급여 합계
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;

--직급별 급여 합계
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

--부서코드 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리), 인원수를 조회하고, 부서코드 순으로 정렬
SELECT DEPT_CODE, SUM(SALARY), ROUND(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;

--테이블에서 부서코드 그룹별, 보너스를 지급받는 사원 수를 조회하고 부서코드 순으로 정렬
--BONUS컬럼의 값이 존재한다면, 그 행을 1로 카운팅/보너스를 지급받는 사원이 없는 부서도 있음.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY 1;

--@실습문제
--1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
SELECT JOB_CODE, COUNT(*), FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE
ORDER BY 1;

--2. EMPLOYEE테이블에서 직급이 J1을 제외하고,  입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT EXTRACT(YEAR FROM HIRE_DATE) 입사년도, COUNT(*) 인원수
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY 1;

--3. 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 (정수처리)급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여') 성별, FLOOR(SUM(SALARY)), COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여') 
ORDER BY 인원수 DESC;

--4. 부서내 성별 인원수를 구하세요.
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여') 성별, COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여','3','남','4','여');






