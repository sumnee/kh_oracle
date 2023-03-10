--DAY01----------------------
CREATE TABLE EXAMPLE(
    NAME VARCHAR2(30),
    AGE NUMBER,
    ADDRESS VARCHAR2(100)
);

DROP TABLE EXAMPLE;

INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('肯走',50,'曽稽姥');
INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('精走',60,'韻遭姥');
INSERT INTO EXAMPLE(NAME, AGE, ADDRESS)
VALUES ('薄走',30,'掻姥');

UPDATE EXAMPLE
SET AGE = 20
WHERE AGE = 60;

DELETE FROM EXAMPLE
WHERE AGE = 50;

SELECT NAME, AGE
FROM EXAMPLE
WHERE NAME = '精走';

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
WHERE EMP_NAME LIKE '勺%';

--尻生稽 魁蟹澗 戚硯 達奄
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%尻';

--穿鉢腰硲 坦製 3切軒亜 010戚 焼観 紫据税 戚硯, 穿鉢腰硲 窒径
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--五析爽社税 's'亜 級嬢亜檎辞, DEPT_CODE亜 D9 暁澗 D6 
--壱遂析戚 90/01/01 ~ 01/12/01戚檎辞, 杉厭戚 270幻据戚雌昔 紫据税 穿端舛左研 窒径
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%S%' 
AND DEPT_CODE IN ('D6','D9')
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' 
AND SALARY >= 2700000;

--EMAIL ID 掻 @ 蒋切軒亜 5切軒昔 送据聖 繕噺
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--EMAIL ID 掻 '_' 蒋切軒亜 3切軒昔 送据聖 繕噺
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--淫軒切(MANAGER_ID)亀 蒸壱 採辞 壕帖(DEPT_CODE)亀 閤走 省精  送据税 戚硯 繕噺
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--採辞壕帖研 閤走 省紹走幻 左格什研 走厭馬澗 送据 穿端 舛左 繕噺
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--戚硯, 悦巷 析呪研 窒径背左獣神.(SYSDATE研 紫遂)
SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE) 悦巷析呪
FROM EMPLOYEE;

--20鰍 戚雌 悦紗切税 戚硯,杉厭,左格什晴研 窒径
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (ROUND(SYSDATE-HIRE_DATE)/365) > 20;

--DAY03----------------------
--送据誤 戚五析 戚五析掩戚 窒径
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

--送据税 戚硯引 戚五析 爽社掻焼戚巨 採歳幻 窒径
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@',1,1)-1)
FROM EMPLOYEE;
--INSTR(鎮軍,達澗依,獣拙繊,護腰属依)
--獣拙繊 : 1 蒋拭辞採斗 / -1 及拭辞採斗
--護腰属依 : 湛腰属稽 達精依精 1 砧腰属稽 達精依精 2 ...
--3, 4腰属牒精 持繰 亜管 -> 持繰 獣 蒋拭辞採斗 湛腰属依 達製

--60鰍企拭 殿嬢貝 送据誤引 鰍持, 左格什 葵聖 窒径(左格什 NULL戚檎 0)
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2),NVL(BONUS,0)
FROM EMPLOYEE
WHERE EMP_NO LIKE '6%';

--'010' 輩球肉 腰硲研 床走 省澗 紫寓税 呪研 窒径(_誤)
SELECT COUNT(*)||'誤'
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--送据誤引 脊紫鰍杉聖 窒径馬獣神
--	    送据誤		脊紫鰍杉
--	ex) 穿莫儀		2012鰍 12杉
SELECT EMP_NAME 送据誤, 
EXTRACT(YEAR FROM HIRE_DATE)||'鰍 '
||EXTRACT(MONTH FROM HIRE_DATE)||'杉' 脊紫鰍杉
FROM EMPLOYEE;

--送据誤引 爽肯腰硲研 繕噺馬獣神
--	ex) 畠掩疑 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO,1,8)||'******' 爽肯去系腰硲
FROM EMPLOYEE;

--送据誤, 送厭坪球, 尻裟 繕噺
--  舘, 尻裟精 ��57,000,000 生稽 妊獣鞠惟 敗
--  尻裟精 左格什匂昔闘亜 旋遂吉 1鰍帖 厭食績
SELECT EMP_NAME, JOB_CODE, TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0),'L999,999,999') 尻裟
FROM EMPLOYEE;

--採辞坪球亜 D5, D9昔 送据 掻 2004鰍亀拭 脊紫廃 送据税 紫腰 紫据誤 採辞坪球 脊紫析
SELECT EMP_NO, EMP_NAME, DEPT_CODE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND HIRE_DATE LIKE '04%';

--送据誤, 持鰍杉析, 蟹戚(幻) 繕噺
--   舘, 持鰍杉析精 爽肯腰硲拭辞 蓄窒背辞, しししし鰍 しし杉 しし析稽 窒径鞠惟 敗.
--   蟹戚澗 爽肯腰硲拭辞 蓄窒背辞 劾促汽戚斗稽 痕発廃 陥製, 域至敗
--	 (EMP_ID 200,201,214 腰 薦須)
SELECT EMP_NAME, '19'||SUBSTR(EMP_NO,1,2)||'鰍 '||SUBSTR(EMP_NO,3,2)||'杉 '||SUBSTR(EMP_NO,5,2)||'析' AS 持鰍杉析, 
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "蟹戚(幻)"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200,201,245);

--紫据誤引, 採辞誤聖 窒径馬室推.
--   採辞坪球亜 D5戚檎 恥巷採, D6戚檎 奄塙採, D9戚檎 慎穣採稽 坦軒馬獣神.(case 紫遂)
--   採辞坪球 奄層生稽 神硯託授 舛慶敗.
SELECT EMP_NAME, 
CASE
    WHEN DEPT_CODE='D5' THEN '恥巷採'
    WHEN DEPT_CODE='D6' THEN '奄塙採'
    WHEN DEPT_CODE='D9' THEN '慎穣採' END AS 採辞誤
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY 採辞誤 ASC;

--1. 庚切坦軒敗呪
--陥製 庚切伸拭辞 収切研 薦暗 '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402','0123456789'),'0123456789') FROM DUAL;

-- 紫据誤拭辞 失幻 掻差蒸戚 紫穿授生稽 窒径馬室推.
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) 失
FROM EMPLOYEE
ORDER BY 失 ASC;

-- employee 砺戚鷺拭辞 害切幻 紫据腰硲, 紫据誤, 爽肯腰硲, 尻裟聖 蟹展鎧室推.
-- 爽肯腰硲税 急6切軒澗 *坦軒馬室推.
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8)||'******', SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. 収切坦軒敗呪
--EMPLOYEE 砺戚鷺拭辞 戚硯, 悦巷 析呪研 窒径背左獣神
SELECT EMP_NAME, ROUND(SYSDATE - HIRE_DATE) 悦巷析呪
FROM EMPLOYEE;














