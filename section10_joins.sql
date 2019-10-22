-- OLD SYNTAX
-- CARTESIAN PRODUCT
SELECT EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.FIRST_NAME,
DEPARTMENTS.DEPARTMENT_ID, DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES, 
DEPARTMENTS
ORDER BY EMPLOYEE_ID;

-- EQUIJOIN / SIMPLE JOIN / INNER JOIN
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME,
DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME
FROM EMPLOYEES EMP, 
DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
AND EMP.DEPARTMENT_ID > 30
ORDER BY EMPLOYEE_ID;

SELECT
EMP.EMPLOYEE_ID, EMP.FIRST_NAME,
DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME, 
DEPT.LOCATION_ID, LOC.CITY
FROM EMPLOYEES EMP,
DEPARTMENTS DEPT,
LOCATIONS LOC
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID
AND DEPT.LOCATION_ID = LOC.LOCATION_ID
ORDER BY EMPLOYEE_ID;

-- NONEQUIJOIN
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, GRADES.GRADE_LEVEL
FROM EMPLOYEES EMP, JOB_GRADES GRADES
WHERE EMP.SALARY >= GRADES.LOWEST_SAL
AND EMP.SALARY <= GRADES.HIGHEST_SAL;

-- OUTER JOIN
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME,
DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME
FROM EMPLOYEES EMP, 
DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID(+) = DEPT.DEPARTMENT_ID;

SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME,
DEPT.DEPARTMENT_ID, DEPT.DEPARTMENT_NAME
FROM EMPLOYEES EMP, 
DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID(+);

-- SELF JOIN
SELECT WORKER.EMPLOYEE_ID, WORKER.FIRST_NAME || ' ' || WORKER.LAST_NAME,
WORKER.MANAGER_ID, MANAGER.FIRST_NAME || ' ' || MANAGER.LAST_NAME
FROM EMPLOYEES WORKER, EMPLOYEES MANAGER
WHERE WORKER.MANAGER_ID = MANAGER.EMPLOYEE_ID
ORDER BY WORKER.EMPLOYEE_ID;


SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.DEPARTMENT_ID,
DEPT.DEPARTMENT_NAME, DEPT.LOCATION_ID, LOC.CITY, CONT.COUNTRY_NAME
FROM EMPLOYEES EMP,
DEPARTMENTS DEPT,
LOCATIONS LOC,
COUNTRIES CONT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID(+)
AND DEPT.LOCATION_ID = LOC.LOCATION_ID(+)
AND LOC.COUNTRY_ID = CONT.COUNTRY_ID(+)
AND SALARY > 2500;
