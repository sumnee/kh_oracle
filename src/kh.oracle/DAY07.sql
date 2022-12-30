--@DQL종합실습문제

--1. 기술지원부에 속한 사람들의 사람의 이름,부서코드,급여를 출력하시오.
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '기술지원부';

--2. 기술지원부에 속한 사람들 중 가장 연봉이 높은 사람의 이름,부서코드,급여를 출력하시오
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '기술지원부' AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE = '기술지원부');

--3. 매니저가 있는 사원중에 월급이 전체사원 평균을 넘고 
--사번,이름,매니저 이름, 월급을 구하시오.
SELECT EMP_ID, EMP_NAME
,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "매니저 이름", SALARY
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);


-- # 제약조건
-- ## 1. CHECK
CREATE TABLE USER_CHECK (
    USER_NO NUMBER PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER CHAR(5)
);
DROP TABLE USER_CHECK;
SELECT * FROM USER_CHECK;

--이미 테이블을 만들어 둔 상태에서 제약조건 추가하는 방법
DELETE FROM USER_CHECK;  --기존 데이터 오류나니까 데이터 삭제해줌

ALTER TABLE USER_CHECK
ADD CONSTRAINT GENDER_VAL CHECK(USER_GENDER IN('남','여'));
--F M 여자 남자 이런거 쓸 수 없이 통일하도록 제약조건 CHECK
--CONSTRAINT GENDER_VAL <- 제약조건의 이름 지정하는 법

INSERT INTO USER_CHECK(USER_NO,USER_NAME,USER_GENDER)
VALUES ('1','일','남');
INSERT INTO USER_CHECK
VALUES ('2','이','여');
INSERT INTO USER_CHECK
VALUES ('3','삼','M');
INSERT INTO USER_CHECK
VALUES ('4','사','F');

-- ## 2. DEFAULT
--컬럼의 기본값을 설정
CREATE TABLE USER_DEFAULT(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_DATE DATE DEFAULT SYSDATE,
    USER_YN CHAR(1) DEFAULT 'Y'
);
DROP TABLE USER_DEFAULT;

INSERT INTO USER_DEFAULT(USER_NO,USER_NAME,USER_DATE,USER_YN)
VALUES ('1','일','2022/12/23','Y');
INSERT INTO USER_DEFAULT
VALUES ('2','이',SYSDATE,'N');
INSERT INTO USER_DEFAULT
VALUES ('3','삼',DEFAULT,DEFAULT);



--# 셀프조인 SELFJOIN
--매니저가 있는 사원 중 월급이 전체평균 넘는 직원의 사번 이름 매니저이름 월급 출력
SELECT EMP_ID, EMP_NAME
,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "매니저 이름", SALARY
FROM EMPLOYEE E --상관커리 이용
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

SELECT E.EMP_ID, E.EMP_NAME, M.EMP_NAME FROM EMPLOYEE E
JOIN EMPLOYEE M ON M.EMP_ID = E.MANAGER_ID; --셀프조인 이용
--FROM TBL 별칭 필수!(같은 컬럼이니까 구별해야함)


--# 상호조인 CROSSJOIN
--## 카테이션 곱 CARTENSIAL PRODUCT
--   :조인되는 테이블의 각 행들이 모두 매핑된 조인
--    양쪽 테이블의 모든행을 조인시켜 모든 경우의수를 구하므로 결과 개수는 두 컬럼수의 곱
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT;
--EMPLOYEE 23 * DEPARTMENT 9 ->207

--아래처럼 나오도록 하세요.
----------------------------------------------------------------
-- 사원번호    사원명     월급    평균월급    월급-평균월급
----------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY, AVG_SAL 평균월급, SALARY-AVG_SAL "월급-평균월급"
FROM EMPLOYEE 
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);

-- 양수에 '+' 표시하기
SELECT EMP_ID , EMP_NAME ,SALARY , AVG_SAL 평균월급
,(CASE WHEN SALARY-AVG_SAL > 0 THEN '+' END) || (SALARY-AVG_SAL) AS "월급-평균월급"
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);


--TCL
INSERT INTO USER_CHECK (USER_NO,USER_NAME,USER_GENDER)
VALUES ('1','일','남');
INSERT INTO USER_CHECK
VALUES ('2','이','여');
INSERT INTO USER_CHECK
VALUES ('3','삼','여');
COMMIT; --최종저장
INSERT INTO USER_CHECK
VALUES ('4','사','여');
SAVEPOINT TEMP1; --임시저장

ROLLBACK;
ROLLBACK TO TEMP1;
SELECT * FROM USER_CHECK;

--COMMIT 해야 반영되어 다른 계정에서도 보인다!


--DCL   ----> 무조건 시스템 계정에서 해야함
--DB에 대한 보안, 복구, 무결성 등을 제어 / 사용자의 권한, 관리자 설정 등 처리
--무결성? 정확성, 일관성을 유지하는 것

--ROLE로 필요한 권한을 묶어서 관리, 한번에 다양한 역할을 수행, 회수 시 편리
--CONNECT ROLE : CREATE SESSION
--RESOURCE ROLE : CREATE CLUSTER,PROCEDURE,SEQUENCE,TABLE,TRIGGER,TYPE,INDEXTYPE,OPERATOR ...


--ORACLE OBJECT 오라클 객체 : DB를 효율적으로 관리, 동작하게
--종류: 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 패키지(PACKAGE), 
--     프로시저(PROCEDUAL), 함수(FUNCTION), 트리거(TRIGGER), 동의어(SYNONYM), 사용자(USER)
--1. VIEW : 하나 이상의 테이블에서 원하는 데이터를 선택하여 가상의 테이블을 만들어줌
--   데이터자체를 포함하는 것이 아니라 다른 테이블의 데이터를 보여주는 것
--   물리적으로 저장장치 내 존재하는것이 아니라 링크 개념이다.
--   --> 특정 사용자가 원본테이블의 모든 데이터를 볼 수 없게 뷰를 통해 특정데이터만 보여준다
--   뷰를 만들기 위해서는 권한이 필요(시스템 계정에서 실행) -> GRANT CREATE VIEW TO KH;
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_NAME, JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_ID = '200';
SELECT * FROM V_EMPLOYEE;
DROP VIEW V_EMPLOYEE;

UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = '200';
--뷰를 통해 원본도 수정 가능

CREATE VIEW V_EMP_DEP
AS SELECT EMP_NAME, JOB_CODE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
SELECT * FROM V_EMP_DEP;
--조인도 가능


--2. SEQUENCE : 순차적으로 정수값을 자동 생성
--   옵션 6가지(생략가능) START WITH,INCREMENT BY, MAXVALUE, MINVALUE, CYCLE, CACHE

CREATE SEQUENCE SEQ_USERNO;
SELECT * FROM USER_SEQUENCES; 
--만들어진 시퀀스 확인

DELETE FROM USER_DEFAULT; 
--삭제하고 시퀀스로 다시 넣을꺼임
INSERT INTO USER_DEFAULT
VALUES(SEQ_USERNO.NEXTVAL, '하나' ,DEFAULT,DEFAULT);
INSERT INTO USER_DEFAULT
VALUES(SEQ_USERNO.NEXTVAL, '둘' ,DEFAULT,DEFAULT);
SELECT * FROM USER_DEFAULT;

SELECT SEQ_USERNO.CURRVAL FROM DUAL;
--현재 시퀀스 값 확인 // 오류가 나도 CURRVAL값은 증가한다
DROP SEQUENCE SEQ_USERNO; 
--삭제

CREATE SEQUENCE SQE_SAMPLE1;
ALTER SEQUENCE SQE_SAMPLE1
INCREMENT BY 10;
--수정
--START WITH 값은 수정 불가능하여, 변경하려면 삭제 후 생성해야함

SELECT * FROM USER_SEQUENCES;

-- @ NEXTVAL, CURRVAL 사용할 수 있는 경우
--1. 서브쿼리가 아닌 SELECT문
--2. INSERT문의 SELECT절
--3. INSERT문의 VALUES절
--4. UPDATE문의 SET절
-- @ CURRVAL 사용 주의점
-- NEXTVAL을 무조건 1번 실행한 후 CURRVAL 사용 가능






