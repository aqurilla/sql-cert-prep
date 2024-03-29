SELECT * FROM SESSION_PRIVS;
-- CONTAINS ALL PRIVILEGES WHETHER DIRECTLY OR FROM ROLE

SELECT * FROM USER_SYS_PRIVS;
-- CONTAINS ONLY DIRECTLY GRANTED SYS PRIVS

SELECT * FROM USER_ROLE_PRIVS;

SELECT * FROM ROLE_SYS_PRIVS;

SELECT * FROM ROLE_TAB_PRIVS;

CREATE TABLE STUDENT
( STUDENT_ID NUMBER,
  STUDENT_NAME VARCHAR2(100)
);

GRANT SELECT
ON STUDENT
TO PUBLIC;

-- BECAUSE OF QONLY ROLE
SELECT *
FROM HR.LOCATIONS;

SELECT * FROM DEMO.EMP;

-- BECAUSE OF IUD_EMP
UPDATE HR.EMPLOYEES
SET SALARY = SALARY+10
WHERE EMPLOYEE_ID = 100;

----------------------------------------------------
-- WITH GRANT OPTION
CREATE TABLE COURSE
( COURSE_ID NUMBER,
  COURSE_NAME VARCHAR2(100)
);

GRANT SELECT
ON COURSE
TO HR
WITH GRANT OPTION;
-- GIVES GRANT PRIVILEGES TO HR

-- TO REMOVE PRIVILEGES
REVOKE SELECT
ON COURSE
FROM HR;
-- NOW BOTH HR AND DEMO CANNOT SELECT
-- CASCADED REVOKE OCCURS



