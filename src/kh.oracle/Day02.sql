DESC EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, SALARY*12 AS "연봉"
FROM EMPLOYEE
WHERE SALARY>3000000 OR EMP_NAME = '전지연'
ORDER BY SALARY ASC;
--WHERE로 조건 검색(행 선택)
--AND OR 논리연산자 사용 가능
--ASC 오름차순 DESC 내림차순   //NULL은 제일 작게 인식됨
--FROM -> WHERE -> SELECT -> ORDER BY(마지막에 실행)

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 6000000
ORDER BY SALARY ASC;
--WHERE SALARY>2000000 AND SALARY<6000000 와 같다!

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8');
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' 와 같다!

SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
--WHERE BONUS IS NULL; 

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
-- 전 으로 시작하는 데이터 찾기
-- %전% 전이 든 것 //NOT LIKE 가능

--1. 연으로 끝나는 이름 찾기
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
-- '_연' 일연 -> 이것만 나옴 / '__연' 일이연 (언더바 하나 당 한글자)
-- '%연' 연 일연 일이연 일이삼연 ... 다 나옴(퍼센트 자리의 길이가 정해지지 않음)

--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3. 
EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND EMAIL LIKE '%S%' 
AND DEPT_CODE IN ('D6','D9') 
AND SALARY >= 2700000;

--4. EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--5. EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 
--언더바를 문자로 사용하기 위해 ESCAPE 사용

--6. 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  직원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--7. 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--8. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함), 실수령액(총 수령액-(월급*세금 3%*12))가 출력되도록 하시오
SELECT EMP_NAME AS "이름", SALARY*12 AS "연봉", SALARY*12+SALARY*BONUS AS "총수령액(보너스포함)",
(SALARY*12 + SALARY*BONUS)-(SALARY*0.03*12) AS "실수령액" 
FROM EMPLOYEE;

--9. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오.(SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME "이름", SYSDATE - HIRE_DATE "근무일수" 
FROM EMPLOYEE;
--SYSDATE 오늘 날짜

--10. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오.
SELECT EMP_NAME "이름", SALARY "월급", BONUS "보너스율"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 >= 20;





