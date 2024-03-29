-- CASE CONVERSION FUNCTIONS
SELECT EMPLOYEE_ID, FIRST_NAME, UPPER(FIRST_NAME), 
LOWER(FIRST_NAME), INITCAP(FIRST_NAME)
FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME)='PATRICK';

-- CHARACTER MANIPULATION
-- CONCAT FUNCTION ONLY TAKES 2 ARGUMENTS
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONCAT(FIRST_NAME, LAST_NAME)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, FIRST_NAME || ' ' || LAST_NAME NAME
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, SUBSTR(FIRST_NAME, 1, 3), SUBSTR(FIRST_NAME, -3)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, LENGTH(FIRST_NAME)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
INSTR(FIRST_NAME, 'nn'),
INSTR(FIRST_NAME, 'e', 2),
INSTR(FIRST_NAME, 'e', 5),
INSTR(FIRST_NAME, 'e', 1, 2)
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%nn%';

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, LPAD(SALARY, 10, '#'),
RPAD(SALARY, 10, '#')
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, REPLACE(FIRST_NAME, 'a', '*')
FROM EMPLOYEES;

SELECT * FROM DUAL;

-- CHARACTERS ARE ONLY REMOVED FROM THE BEGINNING AND THE END
SELECT TRIM (LEADING ' ' FROM '     GAMING LAPTOP      ') 
FROM DUAL;

SELECT TRIM (TRAILING ' ' FROM '      GAMING LAPTOP     ') 
FROM DUAL;

SELECT TRIM (BOTH ' ' FROM '      GAMING LAPTOP     ') 
FROM DUAL;

SELECT TRIM ('      GAMING      LAPTOP     ') 
FROM DUAL;


-- NUMERIC FUNCTIONS
SELECT ROUND(10.5) FROM DUAL;

SELECT ROUND(114.49) FROM DUAL;

SELECT ROUND(10.99, 1) FROM DUAL;

SELECT ROUND(-715.493, -3) FROM DUAL;

SELECT ROUND(-1715.493, -3) FROM DUAL;

-- TRUNC FUNCTION (REMOVES DECIMALS, SETS OTHERS TO 0)
SELECT TRUNC(10.6565) FROM DUAL;

SELECT TRUNC(910.6565, -2) FROM DUAL;

-- MOD - MODULUS
SELECT MOD(15, 2) FROM DUAL;
SELECT MOD(101, 2) FROM DUAL;

-- DATE FUNCTIONS
-- DD-MON-RR FORMAT
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES;

-- ADDING DAYS
SELECT SYSDATE, SYSDATE + 3 
FROM DUAL; 

SELECT HIRE_DATE, SYSDATE, ROUND((SYSDATE-HIRE_DATE)/7) NUMBER_WEEKS
FROM EMPLOYEES;

-- ADDING NUMBER OF HOURS
SELECT SYSDATE + 5/24
FROM DUAL;

-- USUALLY LARGER DATE FIRST
SELECT FIRST_NAME, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEES;

SELECT FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 1)
FROM EMPLOYEES;

-- NEGATIVE VALUE GOES BACKWARDS
SELECT FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, -1)
FROM EMPLOYEES;

-- 1 ='Sunday' ACC TO NLS_DATE_LANGUAGE
SELECT SYSDATE,  NEXT_DAY(SYSDATE, 1)
FROM DUAL;

-- RETURNS LAST DAY OF MONTH
SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)),
ADD_MONTHS(HIRE_DATE, 6), NEXT_DAY(HIRE_DATE, 'FRIDAY')
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
HIRE_DATE, ROUND(HIRE_DATE, 'YEAR'), TRUNC(HIRE_DATE, 'YEAR')
FROM EMPLOYEES
ORDER BY HIRE_DATE;

-- NESTING FUNCTIONS
SELECT FIRST_NAME, SUBSTR(UPPER(FIRST_NAME), 1, 3)
FROM EMPLOYEES;

-- EXTRACTING PARTS OF SENTENCE
SELECT 'EXTRACT THIS SENTENCE' FULLN,
SUBSTR('EXTRACT THIS SENTENCE', 1, INSTR('EXTRACT THIS SENTENCE', ' ',1,1)-1),
SUBSTR('EXTRACT THIS SENTENCE', INSTR('EXTRACT THIS SENTENCE', ' ',1,1)+1, 
INSTR('EXTRACT THIS SENTENCE', ' ',1,2)-INSTR('EXTRACT THIS SENTENCE', ' ',1,1)+1-1),
SUBSTR('EXTRACT THIS SENTENCE', INSTR('EXTRACT THIS SENTENCE', ' ',1,2)+1)
FROM DUAL;

--------------------------------------------------
--------------------------------------------------
-- PRACTICE 

-- SINGLE ROW FUNCTIONS - RETURN 1 RESULT PER ROW
-- MULTIPLE ROW FUNCTIONS - RETURN 1 RESULT PER SET OF ROWS

-- CASE CONVERSION FUNCTION

SELECT FIRST_NAME, UPPER(FIRST_NAME), LOWER(FIRST_NAME), INITCAP(FIRST_NAME)
FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) = UPPER('patrick');

--CAN USE WITH SELECT, WHERE AND GROUPBY

-- CONCAT FUNCTION ONLY TAKES 2 ARGUMENTS
SELECT FIRST_NAME, LAST_NAME, CONCAT(FIRST_NAME, LAST_NAME)
FROM EMPLOYEES;

-- SUBSTR FUNCTION
-- SUBSTR(COLUMN|EXPR,M,N)
-- M - STARTING CHARACTER, N CHARACTERS LONG
-- NO N VALUE - TILL END OF STRING
-- IF M NEGATIVE, COUNT STARTS FROM END
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 1, 4), SUBSTR(FIRST_NAME, -3), LENGTH(FIRST_NAME)
FROM EMPLOYEES;

--INSTRING
-- INSTR(COL, EXPR, M, N)
-- M - INDEX TO START SEARCHING
-- N - NTH OCCURENCE
-- DEFAULT M,N=1
SELECT FIRST_NAME,
INSTR(FIRST_NAME, 'e', 1,2)
FROM EMPLOYEES;

-- EMPLOYEES WHO HAVE TWO 'e' IN THEIR FIRST NAME
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE INSTR(FIRST_NAME, 'e', 1,2) != 0;

SELECT FIRST_NAME,
INSTR(FIRST_NAME, 'e'),
INSTR(FIRST_NAME, 'e', 2),
INSTR(FIRST_NAME, 'e', 5),
INSTR(FIRST_NAME, 'e', 1, 2)
FROM EMPLOYEES;

-- STARTS FROM M BUT RETURNS THE ABSOLUTE POSITION OF THE SUBSTRING

-- LEFT PADDING AND RIGHT PADDING
SELECT EMPLOYEE_ID, FIRST_NAME, LPAD(SALARY, 10, '#')
FROM EMPLOYEES;
-- TOTAL HOW MANY CHARACTERS REQUIRED, AND WHAT CHARACTER TO PAD WITH

SELECT EMPLOYEE_ID, FIRST_NAME, RPAD(SALARY, 10, '*')
FROM EMPLOYEES;

-- REPLACE
SELECT EMPLOYEE_ID, FIRST_NAME, REPLACE(FIRST_NAME, 'a', 'ae')
FROM EMPLOYEES;
-- REPLACES AS MANY OCCURENCES AS ARE PRESENT

---------------------------------------------
-- TRIM FUNCTIONS
SELECT * FROM DUAL;

SELECT 1+1+3 FROM DUAL;

-- TRIM (LEADING/TRAILING/BOTH trim_char FROM string) V FROM DUAL;

SELECT TRIM (' ' FROM ' GREEN LAND ') V FROM DUAL;

SELECT TRIM (LEADING ' ' FROM ' GREEN LAND ') V FROM DUAL;

SELECT TRIM (TRAILING ' ' FROM ' GREEN LAND ') V FROM DUAL;

SELECT TRIM (BOTH ' ' FROM ' GREEN LAND ') V FROM DUAL;

-- DOESNT REMOVE SPACES FROM THE MIDDLE

-- LEADING/TRAILING REMOVES CHARACTERS AS SPECIFIED

SELECT TRIM (' GREEN      LAND ') V FROM DUAL;

-- BY DEFAULT REMOVES SPACES FROM BEGINNING AND THE END

---------------------------------------------

-- NUMBER FUNCTIONS (ROUND, TRUNC, MOD)

-- ROUNDS VALUE TO SPECIFIC DECIMAL

SELECT ROUND(10.48), ROUND(10.51) FROM DUAL;
-- IF NO DECIMAL SPECIFIED, ROUNDS WITHOUT DECIMAL

SELECT ROUND(10.48, 1) FROM DUAL;

SELECT ROUND(10.499, 1) FROM DUAL;

SELECT ROUND(10.499, 2) FROM DUAL;

SELECT ROUND(10.493, 2) FROM DUAL;

SELECT ROUND(55.993, 1) FROM DUAL;

-- -VE N -> NUMBERS TO LEFT OF DECIMAL ARE ROUNDED
SELECT ROUND(55.993, -1) FROM DUAL;

SELECT ROUND(55.993, -2) FROM DUAL;

SELECT ROUND(555.993, -3) FROM DUAL;

SELECT ROUND(1555.993, -2) FROM DUAL;

-- TRUNC REMOVES DIGITS WITHOUT ROUNDING

SELECT TRUNC(10.6565) FROM DUAL;

SELECT TRUNC(10.6565, 2) FROM DUAL;

SELECT TRUNC(998.6565, -2) FROM DUAL;

SELECT TRUNC(9998.6565, -2) FROM DUAL;

SELECT TRUNC(998.6565, -3) FROM DUAL; -- GIVES 0

-- MOD FUNCTION
-- SAME AS MODULUS FUNCTION

SELECT MOD(100,2) FROM DUAL;

---------------------------------------------
-- SYSDATE FUNCTION

-- DEFAULT DATE FORMAT IS DD-MON-RR

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES;

-- RR FORMAT, 50-99 IS 19XX YEAR, 0-49 IS 20XX YEAR

SELECT SYSDATE FROM DUAL;
-- SERVER DATE

SELECT SYSDATE, SYSDATE+3 FROM DUAL;

SELECT SYSDATE, SYSDATE-3 FROM DUAL;

SELECT SYSDATE, ROUND(SYSDATE-HIRE_DATE )
FROM EMPLOYEES;

SELECT SYSDATE + 5/24 FROM DUAL;

-- FOR NUMBER OF WEEKS, = NUMBER OF DAYS / 7

---------------------------------------------
-- DATE FUNCTIONS

SELECT EMPLOYEE_ID, FIRST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEES;

-- IF DATE1 < DATE2, RESULT IS NEGATIVE

-- ADD MONTHS
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 4)
FROM EMPLOYEES;

-- GOES N MONTHS BACK IF NEG GIVEN
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, -2)
FROM EMPLOYEES;

-- NEXT DAY
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY')
FROM DUAL;

-- CAN ENTER NUMBER FROM 1 TO 7 ALSO
-- 1 - SUNDAY
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1)
FROM DUAL;

-- LAST_DAY OF MONTH
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- SELECT ALL EMPLOYEES WHO HAVE BEEN HIRED WITHIN PAST 15 MONTHS
SELECT * 
FROM EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) < 15;

-- ROUND, TRUNC
-- FOR ROUNDING AND TRUNCATING DATE

-- ROUND CAN BE USED TO NEAREST MONTH OR NEAREST YEAR
-- IF MONTH, DATES 1-15 GIVE FIRST DAY OF CURRENT MONTH, 16-31 FIRST DAY OF NEXT
-- MONTH. FOR YEAR,1-6 GIVE JAN 1 OF CURR YEAR, 7-12 GIVE JAN 1 OF NEXT YEAR.

SELECT EMPLOYEE_ID,
FIRST_NAME,
HIRE_DATE,
ROUND(HIRE_DATE, 'MONTH'), TRUNC(HIRE_DATE, 'MONTH')
FROM EMPLOYEES;

SELECT EMPLOYEE_ID,
FIRST_NAME,
HIRE_DATE,
ROUND(HIRE_DATE, 'YEAR'), TRUNC(HIRE_DATE, 'YEAR')
FROM EMPLOYEES;

-- TRUNC SIMPLY RESETS THE YEAR TO THE BEGINNING OF THE YEAR

---------------------------------------------
-- NESTED FUNCTIONS
SELECT FIRST_NAME,
RPAD(SUBSTR(UPPER(FIRST_NAME), 1, 3), 10, '*')
FROM EMPLOYEES;

