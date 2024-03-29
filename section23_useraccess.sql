-----------------------------------------------
-- DATABASE SECURITY
-- SYSTEM PRIVILEGES
SELECT *
FROM SESSION_PRIVS;

-- CREATE SESSION IS A BASIC PRIVILEGE REQUIRED
-- ROLE IS A NAMED GROUP OF PRIVILEGES

-- OBJECT PRIVILEGES
-- OWNER HAS ALL PRIVILEGES ON THE OBJECT
-----------------------------------------------
-- CONNECT AS SYSDBA
SHOW CON_NAME;

ALTER SESSION SET CONTAINER = ORCLPDB;

SHOW CON_NAME;

-- SEE ALL USERS
SELECT * FROM ALL_USERS;

-- SEE PRIVILEGE MAP
SELECT * FROM SYSTEM_PRIVILEGE_MAP;

-- CREATE NEW USER
CREATE USER DEMO IDENTIFIED BY DEMO1234;

GRANT CREATE SESSION, CREATE TABLE
TO DEMO;

-- GIVES UNLIMITED SPACE TO DEMO
GRANT UNLIMITED TABLESPACE TO DEMO;

GRANT CREATE SEQUENCE, CREATE VIEW, CREATE SYNONYM
TO DEMO;

-- NOW OBJECT PRIVILEGES
GRANT SELECT
ON HR.EMPLOYEES
TO DEMO;

GRANT DELETE
ON HR.EMPLOYEES
TO DEMO;

GRANT UPDATE (SALARY)
ON HR.EMPLOYEES
TO DEMO;

GRANT ALL
ON HR.LOCATIONS
TO DEMO;

GRANT SELECT, INSERT
ON HR.JOBS
TO DEMO;

GRANT SELECT
ON HR.COUNTRIES
TO PUBLIC;

-----------------------------------------------
-- CREATING ROLES
SHOW CON_NAME;

CREATE ROLE MANAGER;

GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE
TO MANAGER;

-- ROLE_SYS_PRIVS CONTAINS SYSTEM PRIVILEGES
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'MANAGER';

CREATE USER GOOG IDENTIFIED BY GOOG1234;

GRANT CREATE SESSION TO GOOG;

GRANT UNLIMITED TABLESPACE TO GOOG;

GRANT MANAGER TO GOOG;

-----------------------------------------------

CREATE ROLE QONLY;

GRANT SELECT ANY TABLE TO QONLY;

GRANT QONLY TO GOOG;

CREATE ROLE IUD_EMP;

GRANT INSERT, UPDATE, DELETE
ON HR.EMPLOYEES
TO IUD_EMP;

GRANT IUD_EMP TO GOOG;

SELECT * FROM ROLE_TAB_PRIVS
WHERE ROLE = 'IUD_EMP';

-----------------------------------------------
-- DROPPING USER (NOT RECOMMENDED)
SHOW CON_NAME;

DROP USER DEMO; -- DOES NOT DROP A CONNECTED USER

-- CASCADE HAS TO BE SPECIFIED
DROP USER DEMO CASCADE;
-- USING CASCADE WILL REMOVE ALL TABLES ETC THAT THE USER HAS CREATED


-----------------------------------------------------
-----------------------------------------------------
-- PRACTICE

SELECT * FROM SESSION_PRIVS;

-- EVERY USER SHOULD HAVE CREATE SESSION, BECAUSE WITHOUT IT
-- THE USER CANNOT CONNECT TO THE DB

-- FOLLOWING ARE RUN AS SYSDBA
SELECT * FROM ALL_USERS;

SELECT * FROM SYSTEM_PRIVILEGE_MAP;

-- CREATING USERS
CREATE USER DEMO
IDENTIFIED BY DEMO1234;

GRANT CREATE SESSION, CREATE TABLE
TO DEMO;

/*
OTHER SYS PRIVILEGES - 
CREATE SEQUENCE, CREATE VIEW, CREATE SYNONYM
*/

-- OBJECT PRIVS
GRANT SELECT
ON HR.EMPLOYEES
TO DEMO;

GRANT UPDATE (SALARY)
ON HR.EMPLOYEES
TO DEMO;

GRANT ALL
ON HR.LOCATIONS
TO DEMO;

GRANT SELECT
ON HR.COUNTRIES
TO PUBLIC
-- PUBLIC IMPLIES ALL USERS

-- FOLLOWING ARE RUN AS USER 'DEMO'
SELECT * 
FROM SESSION_PRIVS;

SELECT * FROM EMP;

SELECT * FROM ALL_SYNONYMS
WHERE TABLE_NAME = 'EMPLOYEES';

-- CAN UPDATE SALARY BECAUSE OF THE EXISTING PRIVILEGE
UPDATE HR.EMPLOYEES
SET SALARY = 500
WHERE EMPLOYEE_ID = 1;

SELECT * FROM USER_SYS_PRIVS;

SELECT * FROM USER_TAB_PRIVS_RECD
ORDER BY 2;

SELECT * FROM USER_COL_PRIVS_RECD;

GRANT SELECT ON EMP TO HR;

SELECT * FROM USER_TAB_PRIVS_MADE;

GRANT UPDATE (ENAME) ON EMP TO HR;

SELECT * FROM USER_COL_PRIVS_MADE;

-- CREATING ROLES
-- FOLLOWING ARE RUN AS SYS
SHOW CON_NAME;

ALTER SESSION SET CONTAINER = ORCLPDB;

CREATE ROLE MANAGER;

GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE
TO MANAGER;

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'MANAGER';

-----------------------------------------

CREATE ROLE QONLY;

GRANT SELECT ANY TABLE TO QONLY;

GRANT QONLY TO DEMO;

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'QONLY';

CREATE ROLE IUD_EMP;

GRANT INSERT, UPDATE, DELETE
ON HR.EMPLOYEES
TO IUD_EMP;

GRANT IUD_EMP TO DEMO;

SELECT * FROM ROLE_TAB_PRIVS
WHERE ROLE = 'IUD_EMP';

-- FOLLOWING RUN AS USER 'DEMO'
SELECT * FROM SESSION_PRIVS;

-- USER_SYS_PRIVS ONLY SHOWS PRIVILEGES THAT WERE GRANTED DIRECTLY
SELECT * FROM USER_SYS_PRIVS;

SELECT * FROM USER_ROLE_PRIVS;
-- SHOWS ALL ROLES ASSIGNED TO USER

SELECT * FROM ROLE_SYS_PRIVS;

-- TABLE PRIVILEGES ARE IN ROLE_TAB_PRIVS
SELECT * FROM ROLE_TAB_PRIVS;

/*
WITH GRANT OPTION CAN BE USED TO ALLOW GRANTEES TO FURTHER GRANT
PRIVILEGES TO OTHER USERS

IF THE ORIGINAL GRANTOR REVOKES THE PRIVILEGE, THEN ALL USERS THAT 
HAVE THE PRIVILEGE DIRECTLY OR INDIRECTLY HAVE THESE PRIVILEGES REMOVED

DELETING USERS
--------------
DROP USER USERNAME CASCADE;

A CONNECTED USER CANNOT BE DROPPED. CASCADE SPECIFIES THAT ALL USER-OWNED
TABLES, VIEWS ETC ARE ALSO DELETED.
*/

















