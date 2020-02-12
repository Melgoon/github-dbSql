
/* 1.Table full
2. idx1 : empno
3. idx2 job */

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

/*Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER') -- JOB 컬럼으로 바로 조인*/
   
   
   CREATE INDEX idx_n_emp_03 ON emp (job, ename);
   
   EXPLAIN PLAN FOR
   SELECT *
   FROM emp
   WHERE job = 'MANAGER'
   AND ename LIKE 'C%';
   
   SELECT *
   FROM TABLE(dbms_xplan.display);
   
   /*Plan hash value: 4225125015
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')*/
       
       SELECT job, ename, rowid
       FROM emp
       ORDER BY job,ename;
       
       
    /*
    1. table full
    2. idx1 : empno
    3. idx2 : job
    4. idx3 : job + ename
    5. idx4 : ename + job
    */
    
    CREATE INDEX idx_n_emp_04 ON emp(ename,job);
    
    --3번 인덱스를 지우자
    --3,4번째 인덱스가 컬럼 구성이 동일하고 순서만 다르다
    
    DROP INDEX idx_n_emp_03;
    
    SELECT ename, job,rowid
    FROM emp
    ORDER BY ename, job;
    
    EXPLAIN PLAN FOR
    SELECT *
    FROM emp
    WHERE job = 'MANAGER'
    AND ename LIKE 'C%';
    
    SELECT *
    FROM TABLE(dbms_xplan.display);
    
    /* emp - table full, pk_emp(empno)
    dept - table full, pk_dept(deptno)
    */
    
    /*(emp-table full, dept-table full)
    (emp-table full, dept-pk_dept)
    (emp-pk_emp, dept-table full)
    (e,p-pk_emp, dept-pk_dept)*/
    
   /* 1. 순서
    ORALCE - 실시간 응답 : OLTP (ON LINE TRANSACTION PROCESSING)
    전체 처리시간 : OLAP(ON LINE ANALYSIS PROCESSING) - 복잡한 쿼리의 실행계획을 세우는데 30M-> 1H)
    2개 테이블 조인
    각각의 테이블에 인덱스 5개씩 있다면
    한 테이블에 접근 전략 : 6
    36 + 2 = 72
    ORALCE - 실시간 응답 : OLTP (ON LINE TRANSACTION PROCESSING)
    전체 처리시간 : OLAP(ON LINE ANALYSIS PROCESSING) - 복잡한 쿼리의 실행계획을 세우는데 30M-> 1H)*/
    
--emp 부터 읽을까 dept부터 읽을까???

EXPLAIN PLAN FOR
SELECT ename,dname,loc
FROM emp,dept
WHERE emp.deptno = dept.deptno
AND emp.empno=7788;


-- 4 - 3 -5 - 2 -6 -1 -0
SELECT *
FROM TABLE(dbms_xplan.display);

/*CTAS
제약조건 복사가 NOT NULL만 된다.
백업이나, 테스트용으로 사용*/

--deptno 컬럼으로 unique index
--dname 컬럼으로 non unique index
--deptno, dname 컬럼으로 non unique index


--idx1
CREATE TABLE DEPT_TEST2 AS SELECT * FROM DEPT WHERE 1= 1; -- 1= 1은 비교조건 
CREATE unique INDEX idx_u_dept_test01 ON dept_TEST2(deptno); --유니크 인덱스 생성 idx_u_dept_test2_01 u = 유니크
CREATE INDEX idx_n_dept_test02 ON dept_TEST2(dname); --논 유니크 인덱스 생성 ( 논 인덱스는 크리에이트 뒤에 적을 필요는 없음 idx_n_dept_test2_02 n = 언노운 유니크
CREATE INDEX idx3_n_dept_test03 ON dept_TEST2(deptno,dname); -- 위와 동일 idx_n_dept_test2_03

--idx2
DROP INDEX idx_u_dept_test01;
DROP INDEX idx_n_dept_test02;
DROP INDEX idx3_n_dept_test03;

--idx3
CREATE TABLE emp_TEST3 AS SELECT * FROM emp;
Select * from emp_TEST3;

/*1
empno(=)
--2
ename(=)
--3
deptno(=), empno(LIKE 직원번호%) ==> empno, deptno
--4
deptno(=), sal (BETWEEN)
--5
deptno(=) / mgr 동반하면 유리,
empno(=)
--6
deptno, hiredate가 인덱스 존재하면 유리
*/

/*1
--2
ename(=)
--3
deptno(=), empno(LIKE 직원번호%) ==> empno, deptno
--4
deptno(=), sal (BETWEEN)
--5
deptno(=) / mgr 동반하면 유리,
empno(=)
--6
deptno, hiredate가 인덱스 존재하면 유리

deptno,sal,mgr,hiredate
*/




--1
EXPLAIN PLAN FOR
SELECT *
FROM EMP_TEST3
WHERE empno = :empno;

CREATE UNIQUE INDEX idx_u_emp_test3_01 ON emp_test3(empno);

SELECT *
FROM TABLE(dbms_xplan.display);


--2
EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE ename = :ename;

CREATE INDEX idx2_n_emp_test3_02 ON emp_test3(ename);
SELECT *
FROM TABLE(dbms_xplan.display);


--3
EXPLAIN PLAN FOR
SELECT *
FROM EMP, DEPT
WHERE EMP.deptno = DEPT.deptno
AND EMP.deptno = :deptno
AND EMP.empno LIKE :empno || '%'; 

CREATE UNIQUE INDEX idx3_u_emp_test3_03 ON emp_test3(empno,deptno);


-- 4-2-3-1-0
SELECT *
FROM TABLE(dbms_xplan.display);
--CREATE INDEX idx3_u_emp01 ON emp,dept(empno,deptno)

--4
EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE sal BETWEEN : st_sal AND :ed_sal
AND deptno = :deptno;

CREATE INDEX idx4_n_emp_test3_04 ON emp_test3(sal,deptno);

SELECT *
FROM TABLE(dbms_xplan.display);

--5
EXPLAIN PLAN FOR
SELECT B.*
FROM EMP_test3 A, EMP B
WHERE A.mgr = B.empno
AND A.deptno= :deptno;

CREATE INDEX idx5_n_emp_test3_05 ON emp_test3(mgr,empno,deptno);

SELECT *
FROM TABLE(dbms_xplan.display);
-- 4 3 5 2 1 0

--6
EXPLAIN PLAN FOR
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'),
        COUNT(*) cnt
FROM emp_test3
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm');

CREATE INDEX idx6_n_emp_test3_06 ON emp_test3(deptno,hiredate);

SELECT *
FROM TABLE(dbms_xplan.display);






