-- IMPLICIT CONVERSION
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID='100'
OR HIRE_DATE='21-SEP-05';

SELECT CONCAT(EMPLOYEE_ID, FIRST_NAME)
FROM EMPLOYEES;

-- DATE FORMATTING
SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH:MI:SS AM')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS AM')
FROM DUAL;

SELECT TO_CHAR(HIRE_DATE, 'DD MONTH YYYY'), TO_CHAR(HIRE_DATE, 'FMDD MONTH YYYY')
FROM EMPLOYEES;

SELECT TO_CHAR(HIRE_DATE, 'FMDD "OF" MONTH YYYY')
FROM EMPLOYEES;

SELECT TO_CHAR(HIRE_DATE, 'FMDDSPTH "OF" MONTH YYYY')
FROM EMPLOYEES;

-- CONDITIONAL SEARCH
SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'FMMM')='2';

SELECT TO_CHAR(1598,'FM999,999,999') FROM DUAL;

SELECT TO_CHAR(7,'FM9') FROM DUAL;

SELECT LENGTH('-7') FROM DUAL;

-- TO_NUMBER
SELECT TO_DATE('10-11-2015','DD-MM-YYYY') FROM DUAL;

SELECT TO_DATE('10.NOVEMBER.2015','DD.MONTH.YYYY') FROM DUAL;

SELECT * FROM EMPLOYEES
WHERE HIRE_DATE > TO_DATE('10-11-2003', 'DD-MM-YYYY');

SELECT TO_CHAR(TO_DATE('10-11-85','DD-MM-YY'),'YYYY') FROM DUAL;

-- NVL
-- DATATYPES FOR THE TWO EXPRESSIONS INSIDE NVL SHOULD BE SAME
SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, NVL(COMMISSION_PCT, 0)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, NVL(TO_CHAR(COMMISSION_PCT), 'NO COMM.')
FROM EMPLOYEES;

--NVL2
SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, NVL2(COMMISSION_PCT, 'SAL AND COMM.', 'ONLY SALARY')
FROM EMPLOYEES;

-- NULLIF - RETURNS NULL IF ARGS EQUAL, ELSE RETURNS FIRST ARGUMENT
SELECT FIRST_NAME, LENGTH(FIRST_NAME), LAST_NAME, LENGTH(LAST_NAME),
NULLIF(LENGTH(FIRST_NAME), LENGTH(LAST_NAME))
FROM EMPLOYEES;

-- COALESCE RETURNS FIRST NON-NULL VALUE
SELECT EMPLOYEE_ID,
COALESCE(COMMISSION_PCT, MANAGER_ID, SALARY),
NVL(NVL(COMMISSION_PCT, MANAGER_ID), SALARY)
FROM EMPLOYEES;

-- CASE FUNCTION
SELECT FIRST_NAME, JOB_ID, SALARY,
       CASE JOB_ID WHEN 'IT_PROG' THEN 1.10*SALARY
                   WHEN 'ST_CLERK' THEN 1.15*SALARY
                   WHEN 'SA_REP' THEN 1.20*SALARY
       ELSE SALARY
       END "REVISED SALARY"
FROM EMPLOYEES;

-- DECODE FUNCTION
SELECT LAST_NAME, JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG', 1.10*SALARY,
               'ST_CLERK', 1.15*SALARY,
               'SA_REP', 1.20*SALARY,
               SALARY)
       REVISED_SALARY
FROM EMPLOYEES;

------------------------------------------------
------------------------------------------------
-- PRACTICE

-- CONVERSION FUNCTIONS
-- EXPLICIT - DONE BY USER
-- '100' TO NUMBER
-- '21-SEP-05' TO DATE
-- ORACLE CAN ALSO IMPLICITLY CONVERT NUMBER OR DATE TO VARCHAR2

SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD.MM.YYYY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS PM') FROM DUAL;

SELECT HIRE_DATE,
TO_CHAR(HIRE_DATE,'DD MON YYYY'),
TO_CHAR(HIRE_DATE,'FMDD MON YYYY')
FROM EMPLOYEES;

SELECT TO_CHAR(SYSDATE, 'FMDD "OF" MONTH YYYY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'FMDDTH "OF" MONTH YYYY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'FMDDSP "OF" MONTH YYYY')
FROM DUAL;

SELECT TO_CHAR(HIRE_DATE, 'FMDDSPTH "OF" MONTH YYYY')
FROM EMPLOYEES;

-- SELECT EMPLOYEES HIRED IN 2003
SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2004;

SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'MM') = '02';

-- TO AVOID ADDITIONAL 0 OR SPACE, USE FM
SELECT *
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'FMMM') = '2';

-- TO_CHAR WITH NUMBERS
SELECT TO_CHAR(1234) FROM DUAL;

SELECT TO_CHAR(1234, '9999') FROM DUAL;

SELECT TO_CHAR(1234, '9,999') FROM DUAL;

SELECT TO_CHAR(1234, '$9,999') FROM DUAL;

SELECT TO_CHAR(1234, '$9G999') FROM DUAL;

SELECT TO_CHAR(1234.87) FROM DUAL;

SELECT TO_CHAR(1234.87, '9999.99') FROM DUAL;

SELECT TO_CHAR(1234.87, '9G999D99') FROM DUAL;
-- G AND D HAVE TO BE USED TOGETHER

SELECT TO_CHAR(1234.87, '9999.9') FROM DUAL;
-- IS ROUNDED

SELECT TO_CHAR(1234, '99999') FROM DUAL;

-- USING 0 FORCES A 0 TO BE DISPLAYED
SELECT TO_CHAR(1234, '00000') FROM DUAL;

SELECT TO_CHAR(1234, '00000000') FROM DUAL;

SELECT TO_CHAR(1234, '0999') FROM DUAL;

SELECT TO_CHAR(1234, '0999') FROM DUAL;

SELECT TO_CHAR(1234, '9999MI') FROM DUAL;
-- MI MEANS THAT -VE SIGN COMES TO THE RIGHT

SELECT TO_CHAR(-1234, '9999MI') FROM DUAL;

-- PR PARENTHESIZES NEG NUMBER
SELECT TO_CHAR(-1234, '9999PR') FROM DUAL;

SELECT TO_CHAR(1234, '9999PR') FROM DUAL;

SELECT TO_CHAR(1244, 'FM999,999,999') FROM DUAL;

-- TO_DATE
SELECT TO_DATE('11-06-2011', 'DD-MM-YYYY') FROM DUAL;

SELECT TO_DATE('11-06-2011', 'DD-MM-YYYY') FROM DUAL;

SELECT TO_DATE('11-06-2011', 'DD-MM-YYYY') FROM DUAL;

SELECT TO_DATE('17.JULY.2017', 'DD.MONTH.YYYY') FROM DUAL;

-- SPACES INSIDE DATE ARE REMOVED AUTOMATICALLY
SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('10-11-      2003', 'DD-MM-YYYY');

SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('10-11- 2003', 'FXDD-MM- YYYY');
-- PREFIXING FX, FORMAT SHOULD MATCH EXACTLY

--RECOMMENDED TO USE 'YYYY' FORMAT FOR CONSISTENCY

--------------------------------------------------
-- NVL FUNCTION

SELECT EMPLOYEE_ID, COMMISSION_PCT, NVL(COMMISSION_PCT, 0)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, JOB_ID, NVL(JOB_ID, 0)
FROM EMPLOYEES;
-- BOTH ARGUMENTS OF NVL SHOULD HAVE THE SAME DATATYPE

SELECT EMPLOYEE_ID, COMMISSION_PCT, NVL(TO_CHAR(COMMISSION_PCT), 'NO COMM.')
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, COMMISSION_PCT, NVL2(COMMISSION_PCT, COMMISSION_PCT, 0)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, COMMISSION_PCT, NVL2(COMMISSION_PCT, TO_CHAR(COMMISSION_PCT), 'NO COMM.')
FROM EMPLOYEES;
-- HERE EXPR2 AND EXPR3 SHOULD BE SAME DTYPE, EXPR1 CAN BE ANYTHING
-- MAKES SENSE BECAUSE WHATEVER COMES IN THE REPLACEMENT SHOULD BE THE SAME TYPE

-- NULLIF
-- RETURNS NULL IF EXPR1 = EXPR2, O.W RETURNS EXPR1

SELECT FIRST_NAME, NULLIF(LENGTH(FIRST_NAME), LENGTH(LAST_NAME))
FROM EMPLOYEES;

-- COALESCE = NESTED NVL. RETURNS FIRST NON-NULL VALUE
SELECT COALESCE(COMMISSION_PCT, MANAGER_ID)
FROM EMPLOYEES;
-- AGAIN ALL SHOULD BE OF SAME DATATYPE

--------------------------------------------------
-- CASE FUNCTION (CASE WHEN THEN ELSE END)
-- PROVIDES IF-THEN-ELSE FUNCTIONALITY

SELECT FIRST_NAME, JOB_ID, SALARY,
  CASE JOB_ID WHEN 'IT_PROG' THEN 2.10*SALARY
              WHEN 'ST_CLERK' THEN 3.25*SALARY
       ELSE SALARY -- ELSE IS OPTIONAL, PUTS NULL FOR NON-MATCHING CONDITIONS
       END "REVISED SALARY"
FROM EMPLOYEES;

SELECT FIRST_NAME, JOB_ID, SALARY,
  CASE  WHEN JOB_ID = 'IT_PROG' THEN 2.10*SALARY
        WHEN JOB_ID = 'ST_CLERK' THEN 3.25*SALARY
       ELSE SALARY
       END "REVISED SALARY"
FROM EMPLOYEES;

-- DECODE
-- LESS FLEXIBLE THAN CASE-WHEN
SELECT EMPLOYEE_ID, FIRST_NAME,
DECODE(JOB_ID, 'IT_PROG', 7.25*SALARY,
               'SA_REP', 2.50*SALARY,
               'SA_MAN', 2.75*SALARY,
               SALARY)
FROM EMPLOYEES;
-- SALARY IS DEFAULT VALUE HERE. NO DEFAULT - PUTS NULL

