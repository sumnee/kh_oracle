--DAY01----------------------
CREATE TABLE EXAMPLE(
    NAME VARCHAR2(30),
    AGE NUMBER,
    ADDRESS VARCHAR2(100)
);

DROP TABLE EXAMPLE;

INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('민지',50,'종로구');
INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('은지',60,'광진구');
INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('현지',30,'중구');

UPDATE EXAMPLE
SET AGE = 20
WHERE AGE = 60;

DELETE FROM EXAMPLE
WHERE AGE = 50;

SELECT NAME, AGE
FROM EXAMPLE
WHERE NAME = '은지';

--DAY02----------------------
DESC EXAMPLE;

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY 1 ASC;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000
ORDER BY SALARY DESC;

SELECT EMP_NAME, EMP_ID
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8');

SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '송%';

--연으로 끝나는 이름 찾기
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 출력
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6 
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체정보를 출력
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%S%' 
AND DEPT_CODE IN ('D6','D9')
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND SALARY >= 2700000;

--EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  직원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--이름, 근무 일수를 출력해보시오.(SYSDATE를 사용)
SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) 근무일수
FROM EMPLOYEE;

--20년 이상 근속자의 이름,월급,보너스율를 출력
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (ROUND(SYSDATE-HIRE_DATE)/365) > 20;

--DAY03----------------------
--직원명 이메일 이메일길이 출력
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

--직원의 이름과 이메일 주소중아이디 부분만 출력
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@',1,1)-1)
FROM EMPLOYEE;
--INSTR(컬럼,찾는것,시작점,몇번째것)
--시작점 : 1 앞에서부터 / -1 뒤에서부터
--몇번째것 : 첫번째로 찾은것은 1 두번째로 찾은것은 2 ...
--3, 4번째칸은 생략 가능 -> 생략 시 앞에서부터 첫번째것 찾음

--60년대에 태어난 직원명과 년생, 보너스 값을 출력(보너스 NULL이면 0)
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2),NVL(BONUS,0)
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';

--'010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력(_명)
SELECT COUNT(*)||'명'
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--직원명과 입사년월을 출력하시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
SELECT EMP_NAME 직원명, 
EXTRACT(YEAR FROM HIRE_DATE)||'년 '
||EXTRACT(MONTH FROM HIRE_DATE)||'월' 입사년월
FROM EMPLOYEE;

--직원명과 주민번호를 조회하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO,1,8)||'******' 주민등록번호
FROM EMPLOYEE;

--직원명, 직급코드, 연봉 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--  연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME, JOB_CODE, TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999') 연봉
FROM EMPLOYEE;

--부서코드가 D5, D9인 직원 중 2004년도에 입사한 직원의 사번 사원명 부서코드 입사일
SELECT EMP_NO, EMP_NAME, DEPT_CODE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND HIRE_DATE LIKE '04%';

--직원명, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	 (EMP_ID 200,201,214 번 제외)
SELECT EMP_NAME, '19'||SUBSTR(EMP_NO,1,2)||'년 '||SUBSTR(EMP_NO,3,2)||'월 '||SUBSTR(EMP_NO,5,2)||'일' AS 생년월일, 
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "나이(만)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200,201,245);

--사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME, 
CASE
    WHEN DEPT_CODE='D5' THEN '총무부'
    WHEN DEPT_CODE='D6' THEN '기획부'
    WHEN DEPT_CODE='D9' THEN '영업부' END AS 부서명
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY 부서명 ASC;

--1. 문자처리함수
--다음 문자열에서 숫자를 제거 '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402','0123456789'),'0123456789') FROM DUAL;

-- 사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) 성
FROM EMPLOYEE
ORDER BY 성 ASC;

-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8)||'******', SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. 숫자처리함수
--EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오
SELECT EMP_NAME, ROUND(SYSDATE - HIRE_DATE) 근무일수
FROM EMPLOYEE;














