-- SEQUENCES
-- CAN AUTOMATICALLY GENERATE UNIQUE NUMBERS
-- IS A SHAREABLE OBJECT

-- USING DEFAULTS
CREATE SEQUENCE DEPT_SEQ;

CREATE SEQUENCE DEPT_S;

-- CHECK DETAILS
SELECT * 
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S';

-- TO USE THE SEQUENCE
CREATE TABLE DEPT_TEST_S
( DEPNO NUMBER PRIMARY KEY,
  DNAME VARCHAR2(100)
);

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'SALES');

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'OPERATIONS');

SELECT * FROM DEPT_TEST_S;

SELECT DEPT_S.CURRVAL FROM DUAL;

-- IF NEXTVAL USED, IT SHOWS AND SKIPS TO NEXT
SELECT DEPT_S.NEXTVAL FROM DUAL;

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'IT');

-- IT SHOWS A SKIP IN THE SEQUENCE
SELECT * FROM DEPT_TEST_S;

-- TO DROP SEQUENCE
DROP SEQUENCE DEPT_S1;

-----------------------
CREATE SEQUENCE DEPT_S1
START WITH 10
INCREMENT BY 20;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S1';

DELETE FROM DEPT_TEST_S;

INSERT INTO DEPT_TEST_S(DEPNO, DNAME)
VALUES (DEPT_S1.NEXTVAL, 'MARKETING');

INSERT INTO DEPT_TEST_S(DEPNO, DNAME)
VALUES (DEPT_S1.NEXTVAL, 'HELP DESK');

SELECT * FROM DEPT_TEST_S;

-----------------------
DELETE FROM DEPT_TEST_S;

CREATE SEQUENCE DEPT_S2
INCREMENT BY -5;

-- MAX VALUE -1, AND MIN VALUE -999.. (28 9 NINES)
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S2';

INSERT INTO DEPT_TEST_S(DEPNO, DNAME)
VALUES (DEPT_S2.NEXTVAL, 'MARKETING');

INSERT INTO DEPT_TEST_S(DEPNO, DNAME)
VALUES (DEPT_S2.NEXTVAL, 'HELP DESK');

SELECT * FROM DEPT_TEST_S;

-----------------------
-- CAN ALSO USE IN UPDATE STATEMENT
UPDATE DEPT_TEST_S
SET DEPNO = DEPT_S2.NEXTVAL;

SELECT * FROM DEPT_TEST_S
ORDER BY 1;

-----------------------
-- WE CAN CREATE DEFAULT VALUE AS SEQUENCE IN CREATE TABLE
CREATE SEQUENCE EMP_S;

CREATE TABLE EMP_USESEQ
( EMPID NUMBER DEFAULT EMP_S.NEXTVAL PRIMARY KEY,
  NAME VARCHAR2(100),
  DEPTNO NUMBER
);

INSERT INTO EMP_USESEQ (NAME)
VALUES ('JAMES');

INSERT INTO EMP_USESEQ (NAME)
VALUES ('THOMAS');

SELECT * FROM EMP_USESEQ;

-----------------------
-- USING NEXTVAL AND CURRVAL TOGETHER
DELETE FROM DEPT_TEST_S;
DELETE FROM EMP_USESEQ;

DROP SEQUENCE DEPT_S;

CREATE SEQUENCE DEPT_S;

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'SUPPORT');

INSERT INTO EMP_USESEQ (NAME, DEPTNO)
VALUES ('ADAM', DEPT_S.CURRVAL);
INSERT INTO EMP_USESEQ (NAME, DEPTNO)
VALUES ('SAM', DEPT_S.CURRVAL);
INSERT INTO EMP_USESEQ (NAME, DEPTNO)
VALUES ('TOM', DEPT_S.CURRVAL);

SELECT * FROM DEPT_TEST_S;

SELECT * FROM EMP_USESEQ;

-----------------------
-- ALTERING THE SEQUENCE
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S';

ALTER SEQUENCE DEPT_S
INCREMENT BY 100;

ALTER SEQUENCE DEPT_S
CACHE 30;

ALTER SEQUENCE DEPT_S
MAXVALUE 9999;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S';

-- CANNOT ALTER STARTING SEQUENCE NUMBER
ALTER SEQUENCE DEPT_S
START WITH 170;

-----------------------

CREATE SEQUENCE S_CYCLE
START WITH 1
INCREMENT BY 1
MAXVALUE 5
NOCACHE 
CYCLE;

SELECT S_CYCLE.NEXTVAL FROM DUAL;
SELECT S_CYCLE.NEXTVAL FROM DUAL;
SELECT S_CYCLE.NEXTVAL FROM DUAL;
SELECT S_CYCLE.NEXTVAL FROM DUAL;
SELECT S_CYCLE.NEXTVAL FROM DUAL;

SELECT S_CYCLE.NEXTVAL FROM DUAL;
-- REPEATS FROM 1
-- CYCLE SHOULD NOT BE USED IF THE SEQUENCE IS USED FOR PRIMARY KEY

-- NEW MAXVALUE LESS THAN CURRENT VALUE CANNOT BE SET

-- SYNONYMS
-- PRIVATE AND PUBLIC SYNONYMS, ALTERNATIVE NAME FOR OBJECT
DROP SYNONYM E;

CREATE SYNONYM E
FOR EMPLOYEES;

SELECT * FROM E;

SELECT *
FROM USER_SYNONYMS;

-- ANOTHER USER HAS TO TYPE HR.EMP
-- IF PUBLIC SYNONYM CREATED, THEN CAN USE SYNONYM DIRECTLY
CREATE PUBLIC SYNONYM EMPL FOR HR.EMPLOYEES; --INSUFFICIENT ACCESS

-----------------------
-- INDEXES, POINTER TO A DATABASE
-- USED TO SPEED UP ROW RETRIEVAL
-- DEPENDENT ON THE TABLE THAT IT INDEXES
-- WHEN A TABLE DROPPED, CORRESPONDING INDEXES ALSO DROPPED
-- INDEX NAME IS SAME AS CONSTRAINT, IF FROM CONSTRAINT

CREATE TABLE EMP_ID
( EMPNO NUMBER CONSTRAINT EMP_IND_PK PRIMARY KEY,
  ENAME VARCHAR2(100) UNIQUE,
  NICKNAME VARCHAR2(100),
  EMAIL VARCHAR2(100)
);

INSERT INTO EMP_ID (EMPNO, ENAME, NICKNAME, EMAIL)
VALUES ('1', 'TOM SMITH', 'TOM.SMITH', 'TOMSMITH@GMAIL.COM');
INSERT INTO EMP_ID (EMPNO, ENAME, NICKNAME, EMAIL)
VALUES ('2', 'JIM SMITH', 'JIM.SMITH', 'JIMSMITH@GMAIL.COM');
INSERT INTO EMP_ID (EMPNO, ENAME, NICKNAME, EMAIL)
VALUES ('3', 'JANE EYRE', 'JANE.EYRE', 'JANEEYRE@GMAIL.COM');
INSERT INTO EMP_ID (EMPNO, ENAME, NICKNAME, EMAIL)
VALUES ('4', 'MARY KIM', 'MARY.KIM', 'MARYKIM@GMAIL.COM');
COMMIT;

SELECT * FROM EMP_ID;

-- DATA DICTIONARY THAT STORES INDEX INFO IS USER_INDEXES AND USER_IND_COLUMNS
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP_ID';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP_ID';

-- COLUMN POSITION WILL BE 1 AND 2 FOR COMPOSITE KEYS

SELECT *
FROM EMP_ID
WHERE EMPNO = 1; -- CHECK EXPLAIN PLAN

SELECT * FROM EMP_ID
WHERE ENAME = 'TOM SMITH'; -- ALSO VERY FAST, SINCE ORACLE USES INDEX

SELECT *
FROM EMP_ID
WHERE NICKNAME = 'TOM.SMITH'; -- ORACLE MAKES FULL SCAN BECAUSE THERE IS NO INDEX

CREATE INDEX EMP_ID_NICKNAME ON EMP_ID (NICKNAME); --NON-UNIQUE INDEX

-- NOW QUERY WILL BE FASTER, MORE NOTICEABLE FOR LARGER DBS

CREATE UNIQUE INDEX EMP_ID_EMAIL ON EMP_ID (EMAIL);
-- THIS ACTS LIKE A UNIQUE CONSTRAINT NOW

-- CAN USE FUNCTIONS
CREATE INDEX EMP_ID_UP_ENAME ON EMP_ID (UPPER(ENAME));

SELECT * FROM USER_IND_EXPRESSIONS -- FUNCTION INFO STORED HERE
WHERE TABLE_NAME = 'EMP_ID';

-----------------------
-- NAMING INDEX WHILE CREATING TABLE

CREATE TABLE EMP_IND1
( EMPNO NUMER CONSTRAINT EMP_IND1_PK PRIMARY KEY USING INDEX 
                    (CREATE INDEX EMP_IND1_IND ON EMP_IND1 (EMPNO))
);

-- COMPOSITE INDEX CAN ALSO BE CREATED
CREATE INDEX EMP_IND1_COMP ON EMP_IND1 (FNAME, LNAME);

-- BITMAP USED TO POINT TO A GROUP OF ROWS, POINTS TO DISTINCT VALUES
CREATE BITMAP INDEX EMP_IND_B ON EMP_IND1 (GENDER);

--DROP
DROP INDEX EMP_IND_B;

-----------------------------------------------
-----------------------------------------------
-- PRACTICE

DROP SEQUENCE DEPT_S;

CREATE SEQUENCE DEPT_S;

-- THE DICTIONARY USER_SEQUENCES CONTAINS INFORMATION ABOUT SEQUENCES
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S';

DROP TABLE DEPT_TEST_S;

CREATE TABLE DEPT_TEST_S
(
  DEPNO NUMBER PRIMARY KEY,
  DNAME VARCHAR2(100)
);

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'SALES');

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'OPERATIONS');

SELECT * FROM DEPT_TEST_S;

SELECT DEPT_S.CURRVAL FROM DUAL;

SELECT DEPT_S.NEXTVAL FROM DUAL;

SELECT DEPT_S.CURRVAL FROM DUAL;

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'DATA ENGINEERING');

-- CURRVAL SHOWS CURRENT VALUE WITHOUT PROCEEDING THE POINTER. 
-- NEXTVAL INCREMENTS AND THEN SHOWS THE NUMBER.

-- IF A ROLLBACK IS DONE, EVEN THEN THE NUMBERS PASSED IN THE SEQUENCE ARE NOT
-- RETRIEVED

-----------------------------------------------
-- NON-DEFAULT OPTIONS

DROP SEQUENCE DEPT_S1;

CREATE SEQUENCE DEPT_S1
START WITH 10
INCREMENT BY 20;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S1';

DELETE FROM DEPT_TEST_S;

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S1.NEXTVAL, 'MKTNG');

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S1.NEXTVAL, 'HELPDSK');

SELECT * FROM DEPT_TEST_S;

-----------------------------------------------

DELETE FROM DEPT_TEST_S;

DROP SEQUENCE DEPT_S2;

CREATE SEQUENCE DEPT_S2
INCREMENT BY -5;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S2';

SELECT DEPT_S2.NEXTVAL FROM DUAL;

-----------------------------------------------

DROP SEQUENCE EMP_S;

CREATE SEQUENCE EMP_S;

DROP TABLE EM;

CREATE TABLE EM
(
  EMPID NUMBER DEFAULT EMP_S.NEXTVAL PRIMARY KEY,
  NAME VARCHAR2(100),
  DEPTNO NUMBER
);

INSERT INTO EM (NAME)
VALUES ('FRIM');

INSERT INTO EM (NAME)
VALUES ('JONMAS');

SELECT *
FROM EM;

-----------------------------------------------

DELETE FROM DEPT_TEST_S;

DELETE FROM EM;

DROP SEQUENCE DEPT_S;

CREATE SEQUENCE DEPT_S;

-- NEXTVAL AND CURRVAL SHOULD BE USED TOGETHER

INSERT INTO DEPT_TEST_S (DEPNO, DNAME)
VALUES (DEPT_S.NEXTVAL, 'PROGRAMMING');

INSERT INTO EM (NAME, DEPTNO) VALUES ('SAN JOSE', DEPT_S.CURRVAL);
INSERT INTO EM (NAME, DEPTNO) VALUES ('SAN DIEGO', DEPT_S.CURRVAL);
INSERT INTO EM (NAME, DEPTNO) VALUES ('SAN FRANCISCO', DEPT_S.CURRVAL);

SELECT * FROM EM;

SELECT * FROM DEPT_TEST_S;

-----------------------------------------------
-- ALTER SEQUENCE

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_S';

ALTER SEQUENCE DEPT_S
INCREMENT BY 100;

ALTER SEQUENCE DEPT_S
CACHE 30;

ALTER SEQUENCE DEPT_S
MAXVALUE 9999;

-- CANNOT ALTER STARTING NUMBER
ALTER SEQUENCE DEPT_S
START WITH 170;

-- ADDING CYCLE CLAUSE CAUSES SEQUENCE TO RESTART FROM FIRST NUMBER, AFTER IT
-- REACHES ITS MAXIMUM

-----------------------------------------------
-- SYNONYMS - ALIASES FOR OBJECTS

DROP SYNONYM E;

CREATE SYNONYM E
FOR EMPLOYEES;

SELECT *
FROM E;

SELECT * FROM USER_SYNONYMS;

CREATE PUBLIC SYNONYM EMPLOYEES
FOR HR.EMPLOYEES;
-- ABOVE STATEMENT NEEDS PUBLIC SYNONYM CREATION PRIVILEGE

-- ANY DB USER CAN USE A PUBLIC SYNONYM
-- CAN USE EMPLOYEES INSTEAD OF HR.EMPLOYEES

-----------------------------------------------
-- INDEXES
-- INDEXES ARE PRIVATE AREAS IN MEMORY TO SPEED UP QUERIES

-- WHEN A TABLE IS DROPPED, CORRESPONDING INDEXES ARE DROPPED

DROP TABLE EMP_IND;

CREATE TABLE EMP_IND
(
  EMPNO NUMBER CONSTRAINT EMP_IND_PK2 PRIMARY KEY,
  ENAME VARCHAR2(100) UNIQUE,
  NICKNAME VARCHAR2(100),
  EMAIL VARCHAR2(100)
);
-- INDEXES ARE AUTOMATICALLY CREATED FOR PK AND UNIQUE COLUMN
-- NAME OF INDEX IS SAME AS CONSTRAINT NAME

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP_IND';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP_IND';

-- ORACLE USES THE INDEX TO IMPROVE QUERY SPEEDS
SELECT *
FROM EMP_IND
WHERE EMPNO=1;

-- TO CREATE MANUALLY
CREATE INDEX EMP_IND_NICKNAME
ON EMP_IND (NICKNAME);

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP_IND';

-- THIS NEW INDEX IS NON-UNIQUE

-- CREATING A UNIQUE INDEX ON A COLUMN ALSO FORCES A UNIQUE CONSTRAINT ON THE 
-- COLUMN, AND NO DUPLICATE RECORDS CAN EXIST OR BE ENTERED

CREATE UNIQUE INDEX EMP_IND_EMAIL
ON EMP_IND (EMAIL);

-- INDEXES CAN BE CREATED ON EXPRESSIONS
CREATE INDEX EMP_IND_UP_ENAME
ON EMP_IND (UPPER(ENAME));

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP_IND';

-- SINCE IT IS AN EXPRESSION, ANOTHER DICTIONARY USED
SELECT * FROM USER_IND_EXPRESSIONS
WHERE TABLE_NAME = 'EMP_IND';


/*
TO NAME AN INDEX WHILE CREATING THE TABLE, USE THE 'USING INDEX' CLAUSE
EMPNO NUMBER CONSTRAINT EMP_IND1_PK PRIMARY KEY USING INDEX 
(CREATE INDEX EMP_IND1_IND ON EMP_IND1 (EMPNO))
*/

-- USING MULTIPLE COLUMNS
CREATE INDEX EMP_IND1_COMP ON EMP_IND1 (FNAME, LNAME);

-- ANOTHER OPTION IS BITMAP INDEXES
CREATE BITMAP INDEX EMP_IND_BITM ON EMP_IND1 (GENDER);

-- INDEX CAN BE DROPPED

DROP INDEX EMP_IND_BITM;