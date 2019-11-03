-- ADDING & MANAGING CONSTRAINTS

DROP TABLE EMP2;

CREATE TABLE EMP2
AS
  SELECT * FROM EMPLOYEES;

CREATE TABLE DEPT3
AS
  SELECT * FROM DEPARTMENTS;
  
-- ONLY NOT NULL CONSTRAINTS COPIED
DESC EMP2;

-----------------------------------------------
-- ADDING PRIMARY KEY
SELECT *
FROM EMP2;

ALTER TABLE EMP2
MODIFY EMPLOYEE_ID PRIMARY KEY;

-- CAN SEE THE ADDED CONSTRAINT, TYPE P
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP2';

-- REMOVE LAST ADDED CONSTRAINT
ALTER TABLE EMP2
DROP CONSTRAINT &CONS;

-- ADD WITH NAME
ALTER TABLE EMP2
ADD CONSTRAINT EMP2_PK PRIMARY KEY (EMPLOYEE_ID);

ALTER TABLE DEPT3
ADD CONSTRAINT DEPT3_PK PRIMARY KEY (DEPARTMENT_ID);

-----------------------------------------------
-- ADDING FOREIGN KEY
-- METHOD 1
ALTER TABLE EMP2
MODIFY DEPARTMENT_ID REFERENCES DEPT3 (DEPARTMENT_ID);

-- METHOD 2
ALTER TABLE EMP2
ADD CONSTRAINT EMP_FK_DEPT FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPT3 (DEPARTMENT_ID);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP2';

-----------------------------------------------
-- ADDING NOT NULL CONSTRAINTS
-- ONLY POSSIBLE IF TABLE IS EMPTY OR SPECIFIED COLUMN HAS VALUE FOR ALL ROWS
ALTER TABLE EMP2
MODIFY FIRST_NAME NOT NULL;

DESC EMP2;

-- CANNOT DELETE MASTER RECORD BECAUSE THERE IS DEPENDENT TABLE
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2', 'DEPT2')
AND CONSTRAINT_TYPE IN ('P', 'R')
ORDER BY TABLE_NAME;

ALTER TABLE DEPT3
DROP PRIMARY KEY; -- CANNOT DELETE DUE TO FOREIGN KEY

-- CAN CASCADE DROP IT
ALTER TABLE DEPT3
DROP PRIMARY KEY CASCADE;
-- BOTH PRIMARY AND FOREIGN KEY REMOVED
-----------------------------------------------

ALTER TABLE DEPT3
DROP COLUMN DEPARTMENT_ID;
-- CANNOT DROP BECAUSE IT IS A PARENT KEY COLUMN

-- CAN DROP USING CASCADED CONSTRAINTS
ALTER TABLE DEPT3
DROP COLUMN DEPARTMENT_ID CASCADE CONSTRAINTS;
-- BOTH CONSTRAINTS REMOVED

-----------------------------------------------
-- RENAME COLUMN AND CONSTRAINT
SELECT * FROM EMP2;

SELECT * FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'EMP2';

ALTER TABLE EMP2
RENAME COLUMN FIRST_NAME TO FNAME;

SELECT * FROM EMP2;

SELECT * FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'EMP2';
-- CONSTRAINT REFERENCES THE NEW NAME FOR THE COLUMN AUTOMATICALLY

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2', 'DEPT3')
AND CONSTRAINT_TYPE IN ('P', 'R')
ORDER BY TABLE_NAME;

-- CHANGE CONSTRAINT NAME
ALTER TABLE EMP2
RENAME CONSTRAINT EMP2_PK TO NEW_EMP2_PK;

-----------------------------------------------
-- ENABLE/DISABLE CONSTRAINTS
-- CONSTRAINTS ARE USUALLY DISABLED DURING DATA MIGRATION
DROP TABLE EMP2;

DROP TABLE DEPT2;

CREATE TABLE EMP2
AS SELECT * FROM EMPLOYEES;

CREATE TABLE DEPT2
AS SELECT * FROM DEPARTMENTS;

SELECT * FROM EMP2;

SELECT * FROM DEPT2;

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_PK PRIMARY KEY (DEPARTMENT_ID);

ALTER TABLE EMP2
ADD CONSTRAINT EMP2_PK PRIMARY KEY (EMPLOYEE_ID);

ALTER TABLE EMP2
ADD CONSTRAINT EMP2_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPT2 (DEPARTMENT_ID);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2', 'DEPT2');

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP2';

ALTER TABLE EMP2
DISABLE CONSTRAINT EMP2_PK;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2', 'DEPT2')
AND CONSTRAINT_TYPE IN ('P', 'R')
ORDER BY TABLE_NAME;

-- ORACLE DROPS THE UNIQUE INDEX, WHEN THE CONSTRAINT WAS DISABLED
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP2';

ALTER TABLE EMP2
ENABLE CONSTRAINT EMP2_PK;
-- ORACLE CREATES THE UNIQUE INDEX AGAIN

ALTER TABLE DEPT2
DISABLE CONSTRAINT DEPT2_PK;
-- ERROR - cannot disable constraint (HR.DEPT2_PK) - dependencies exist
-- BECAUSE OF FOREIGN KEY

-- WORKS WITH CASCADE
ALTER TABLE DEPT2
DISABLE CONSTRAINT DEPT2_PK CASCADE;

-- BOTH PRIMARY AND FOREIGN KEY ARE DISABLED
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2', 'DEPT2')
AND CONSTRAINT_TYPE IN ('P', 'R')
ORDER BY TABLE_NAME;

ALTER TABLE DEPT2
ENABLE CONSTRAINT DEPT2_PK;

-- BUT AFTER ENABLING IT, THE FOREIGN KEY IS STILL DISABLED(!)
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2', 'DEPT2')
AND CONSTRAINT_TYPE IN ('P', 'R')
ORDER BY TABLE_NAME;
-- CANNOT ENABLE IT IN CASCADE