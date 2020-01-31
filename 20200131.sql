-- cond3
    SELECT userid,usernm,alias,reg_dt,
    DECODE(MOD(TO_NUMBER(TO_CHAR(reg_dt,'YYYY')),2), MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2), '건강검진 대상자','건강검진 비대상자') con4
    FROM users;
    
--JOIN
--RDBMS는 중복을 최소화 하는 형태의 데이터 베이스
-- 다른 테이블과 결합하여데이터를 조회

SELECT ename,deptno
FROM emp;

SELECT *
FROM dept;

--테이블에 중복된 데이터가 있다면
--emp 테이블에 부서명이 존재
--조직 개편에 따라 SALES 부서의 이름이 MARKET SALES로 변경 된다면?
--SALES 부서 개수 만큼의 업데이트가 필요(6회)

--JOIN 두 테이블을 연결하는 작업
--JOIN 문법
--1. ANSI 문법
--2. ORACLE 문법

--Natural Join
-- 두 테이블간 컬럼명이 같을 때 해당 컬럼으로 연결(조인)
-- emp, dept 테이블에는 deptno 라는 컬럼이 존재
SELECT *
FROM emp NATURAL JOIN dept;

-- Natural Join에 사용된 조인 컬럼(deptno)는 한정자(ex: 테이블명, 테이블 명칭)을 사용하지 않고 컬럼명만 기술한다 ( dept.deptno --> deptno)

SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

-- 테이블에 대한 별칭도 사용가능
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM 절에 조인할 테이블 목록을 ,로 구분하여 나열한다.
-- 조인할 테이블의 연결 조건을 WHERE절에 기술한다.
-- emp, dept 테이블에 존재하는 deptno 컬럼이 (같을 때) 조인
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

-- 오라클 조인의 테이블 별칭
SELECT e.empno,e.ename,d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING
-- 조인하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만 하나의 컬럼으로만 조인을 하고자 할 때 조인하려는 기준 컬럼을 기술
-- emp, dept 테이블의 공통 컬럼 : deptno
SELECT emp.ename,dept.dname, deptno
FROM emp JOIN dept USING(deptno);

--JOIN WITH USING을 ORACLE로 표현하면?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--조인 하려고하는 테이블의 컬럼의 이름이 서로 다를 때

SELECT emp.ename, dept.dname, emp.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON --> ORACLE

SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- SELF JOIN : 같은 테이블간의 조인
-- 예 : emp 테이블에서 관리되는 사원의 관리자 사번을 이용하여 관리자 이름을 조회할 때
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--오라클 문법으로 작성
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e,emp m
WHERE e.mgr = m.empno;

--equal 조인 : =
--non-euqal 조인 : !=,ㅋ>,<, BETWWEN AAN

--사원의 급여 정보와 급여 등급 테이블을 이용하여 해당 사원의 급여 등급을 구해보자;
SELECT ename,sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

-- ANSI 문법을 이용하여 위의 조인 문을 작성
SELECT e.ename, e.sal, s.grade
FROM emp e JOIN salgrade s ON ( E.SAL BETWEEN S.LOSAL AND S.HISAL);

--join0
--오라클
SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY dname ASC;

--join0_1
SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno !=20
ORDER BY dname ASC;

SELECT e.empno,e.ename,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno  = d.deptno;

--join0_2
SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.sal >= 2500
ORDER BY dname ASC;

--join0_3
SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.sal >= 2500 and e.empno >=7600
ORDER BY dname ASC;

--join0_4
SELECT e.empno,e.ename,e.sal,d.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.sal >= 2500 and e.empno >=7600 and d.dname = 'RESEARCH'
ORDER BY ename;


--join1
--PROD : PROD_LGU
--LPROD : LPROD_GU;
SELECT l.lprod_gu,l.lprod_nm,p.prod_id,p.prod_name
FROM prod p, lprod l
WHERE p.prod_lgu = l.lprod_gu;

--join2
--PROD : PROD_LGU
--BUYER : BUYER_ID
select buyer.buyer_id,buyer.buyer_name,prod.prod_id,prod.prod_name
from prod,buyer
where prod_lgu = buyer_lgu
ORDER BY buyer_id;
