--DAY05--------------------
--부서별 급여 평균이 3,000,000원(버림적용) 이상인  부서들에 대해서 부서명, 급여평균을 출력하세요.
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

--@실습문제
--1. 부서별 인원이 5명보다 많은 부서와 인원수를 출력하세요.
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

--2. 부서별 내 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력하세요.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >= 3;

--3. 매니저가 관리하는 사원이 2명 이상인 매니저 아이디와 관리하는 사원수 출력
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL;

--1. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   부서코드가 D5, D6, D9 인 직원의 정보만 조회
SELECT EMP_NAME, DECODE(DEPT_CODE,'D5','총무부','D6','기획부','D9','영업부') 부서명
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9');

--ROLLUP // CUBE
--부서내 직급별 급여 합계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--부서별 합

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--부서별+직급별 합


--집합연산자 RESULTSET
--교집합 INTERSECT 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;

--합집합 UNION(중복 제거) / UNION ALL(중복 허용)
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;

--차집합 MINUS 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS 
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >=2400000;


--JOIN 
--@실습문제
--1. 부서명과 지역명을 출력하세요. DEPARTMENT, LOCATION 테이블 이용.
SELECT DEPT_TITLE, LOCAL_NAME FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. 사원명과 직급명을 출력하세요. EMPLOYEE, JOB 테이블 이용
--ON 이후 칼럼명이 같으면 오류, 출처 테이블을 표시해주어야함!
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 3. 지역명과 국가명을 출력하세요. LOCATION, NATION 테이블 이용
SELECT LOCAL_NAME, NATIONAL_NAME FROM LOCATION
JOIN NATIONAL USING (NATIONAL_CODE);

-- 직급이 대리이면서, ASIA 지역에 근무하는 직원 조회
-- 사번, 이름 ,직급명, 부서명, 근무지역명, 급여를 조회하시오
SELECT

--1. 2022년 12월 25일이 무슨 요일인지 조회하시오.
SELECT


--2. 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT

--3. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT

--4. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT

--5. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT

--6. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT

--7. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
SELECT

--8. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT

--9. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
SELECT

--10. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT













