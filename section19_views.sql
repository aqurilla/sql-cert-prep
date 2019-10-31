-- VIEWS ARE LIKE SUBSETS OR COMBINATIONS OF DATA, STORED SELECT STATEMENTS

/* ADVANTAGES-
RESTRICT ACCESS TO DATA
SIMPLIFY COMPLEX QUERIES
PROVIDE DATA INDEPENDENCE
TO PRESENT DIFFERENT VIEWS OF THE SAME DATA

SUBQUERY EMBEDDED IN THE CREATE VIEW COMMAND
*/

-- SIMPLE VIEWS
DROP VIEW EMP_V1;

CREATE VIEW EMP_V1
AS
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
FROM EMPLOYEES;

SELECT * FROM EMP_V1;

SELECT * FROM USER_VIEWS
WHERE VIEW_NAME = 'EMP_V1';

DESC EMP_V1;

-- DML OPERATION SAME AS TABLE
INSERT INTO EMP_V1 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES             (355, 'STEPHEN', 'KING', 'SKLING', SYSDATE, 'IT_PROG');

SELECT * FROM EMP_V1
WHERE EMPLOYEE_ID = 355;

SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 355;

-- COLUMNS HEADING OF VIEW SAME AS THAT OF ORIGINAL TABLE, UNLESS WE GIVE AN ALIAS

CREATE VIEW EMP_V2
AS
SELECT EMPLOYEE_ID EMP_ID, FIRST_NAME FNAME, LAST_NAME LNAME, EMAIL, HIRE_DATE, JOB_ID
FROM EMPLOYEES;

SELECT * FROM EMP_V2;

-- NOW FOR DML, HAVE TO USE THE NEW COLUMN NAMES FROM THE VIEW
-- ON INSERTING INTO VIEW, THE COLUMNS IN ORIGINAL TABLE THAT ARE NOT ADDRESSED, GET NULL

-- ANOTHER WAY TO CREATE
CREATE VIEW EMP_V3 (EMPID, FNAME, LNAME, EMAIL, HIREDATE, JOBS)
AS
  SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
  FROM EMPLOYEES;
  
---------------------------------------------------------------
-- COMPLEX VIEWS

-- ROWNUM - PSEUDOCOLUMN
SELECT ROWNUM, FIRST_NAME
FROM EMPLOYEES;

CREATE VIEW EMP_DEPT_ANALYSIS
AS
  SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) EMP_COUNT,
  MAX(SALARY) MAX_SAL,
  MIN(SALARY) MIN_SAL
  FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID;
  
SELECT * 
FROM EMP_DEPT_ANALYSIS;

-- CANNOT MAKE ANY DML STATEMENTS OR UPDATES, SINCE THESE ARE GROUPED

-- TO UPDATE THE VIEW USE OR REPLACE
CREATE OR REPLACE VIEW EMP_DEPT_ANALYSIS
AS
  SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) EMP_COUNT,
  MAX(SALARY) MAX_SAL,
  MIN(SALARY) MIN_SAL,
  AVG(SALARY) AS AVG_SAL
  FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID;
  
SELECT * 
FROM EMP_DEPT_ANALYSIS;

---------------------------------------------------------------
-- CREATING COMPLEX VIEWS WITH DATA FROM MORE THAN ONE TABLE
CREATE OR REPLACE VIEW EMP_DEPT_V
AS
  SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME NAME,
  SALARY, NVL(DEPARTMENT_NAME, 'NO DEPT') DEPT_NAME
  FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D
  ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

-- NECESSARY TO HAVE ALIAS NAME FOR COMPLEX COLUMNS

SELECT * FROM EMP_DEPT_V;

---------------------------------------------------------------
-- READ ONLY / CHECK OPTION
-- ONLY QUERY, NO INSERT, UPDATE, DELETE
CREATE OR REPLACE VIEW EMP_V_READ
AS
  SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 90
  WITH READ ONLY;

SELECT * FROM EMP_V_READ;

-- ERROR: cannot perform a DML operation on a read-only view
DELETE FROM EMP_V_READ;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP_V_READ';
-- CONSTRAINT_TYPE O MEANS THAT READONLY

-- CHECK OPTION
CREATE OR REPLACE VIEW EMP_V_CHQ_CONST
AS
  SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 90
  WITH CHECK OPTION;
  
SELECT * FROM EMP_V_CHQ_CONST;

-- CONSTRAINT TYPE V - MEANS A VIEW WITH CHECK OPTION

-- ONYL DML CAN BE DONE INTO DEPT 90, FOR THIS EXAMPLE
-- ANY DML OUTSIDE THIS RANGE GIVES ERROR

-- ERROR: view WITH CHECK OPTION where-clause violation
INSERT INTO EMP_V_CHQ_CONST (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES                      (447, 'MICKEY', 'MOUSE', 'MICK.MOUSE', SYSDATE, 007);

-- FORCE VIEW
-- USED TO CREATE OBJECT WHICH DOES NOT YET EXIST IN THE DATABASE
CREATE OR REPLACE FORCE VIEW FORCE_V
AS
  SELECT ENO, ENAME
  FROM JRX;

-- THIS WILL GIVE ERROR, UNTIL THE ABOVE OBJECTS ARE ACTUALLY CREATED
SELECT * FROM FORCE_V;

SELECT * FROM USER_VIEWS
WHERE VIEW_NAME = 'FORCE_V';