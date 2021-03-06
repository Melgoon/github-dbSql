SELECT *
FROM CUSTOMER;

SELECT *
FROM PRODUCT;

SELECT *
FROM CYCLE; -- 일요일 1 토요일 7


--판매점 : 200~250
-- 고객당 2.5개 제품
-- 하루 : 500~750
-- 한달 : 15000~17500


SELECT *
FROM daily;

SELECT *
FROM batch;

-- join4 : join을 하면서 ROW를 제한하는 조건을 결합
SELECT *
FROM customer,cycle;

SELECT customer.CID,customer.CNM,cycle.PID,cycle.DAY,cycle.CNT
FROM customer,cycle
WHERE customer.CID = cycle.CID AND customer.cnm IN('brown','sally');

-- join5
SELECT customer.CID,customer.CNM,cycle.PID,product.PNM,cycle.DAY,cycle.CNT
FROM customer,cycle,product
WHERE customer.CID = cycle.CID
AND cycle.pid = product.pid
AND customer.cnm IN('brown','sally');

--join6 : join을 하면서(3개 테이블) ROW를 제한하는 조건을 결합, 그룹함수 적용
SELECT customer.CID,customer.CNM,cycle.PID,product.PNM,SUM(cycle.CNT)
FROM customer,cycle,product
WHERE customer.CID = cycle.CID
AND cycle.pid = product.pid
GROUP BY customer.CID,customer.CNM,cycle.PID,product.PNM;

--join7 
SELECT cycle.PID,product.PNM,SUM(cycle.CNT)
FROM cycle,product
WHERE cycle.pid = product.pid
GROUP BY cycle.PID,product.PNM;

-- SYSTEM 계정을 통한 HR 계정 활성화
-- 해당 오라클 서버에 등록된 사용자(계정)조회
SELECT *
FROM dba_users;

--HR 계정의 비밀번호를 JAVA로 초기화
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;

--OUTER JOIN
-- 두 테이블을 조인할 때 연결 조건을 만족 시키지 못하는 데이터를 기준으로 지정한 테이블의 데이터만이라도 조회 되게끔 하는 조인 방식

--연결조건 : e.mgr = m.empno : KING의 MGR NULL이기 때문에 조인에 실패한다.
-- EMP 테이블의 데이터는 총 14건이지만 아래와 같은 쿼리에서는 결과가 13건이 된다. (1건이 조인실패)
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--ANSI OUTER
-- 1. 조인에 실패하더라도 조회가 될 테이블을 선정 (매니저 정보가 없어도 사원정보는 나오게끔);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;
--RIGHT OUTER로 변경
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;

--ORACLE OUTER JOIN
--데이터가 없는 쪽의 테이블 컬럼 뒤에 (+)기호를 붙여준다.
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--위의 SQL을 ANSI SQL(OUTER JOIN)으로 변경해보세요.

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

--위의 SQL을 ANSI SQL(OUTER JOIN)으로 변경해보세요.
-- 매니저의 부서버호가 10번인 직원만 조회

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);

아래 LEFT OUTER 조인은 실질적으로 OUTER 조인이 아니다
아래 INNER 조인과 결과가 동일하다.
SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;

--오라클 outer join
-- 오라클 OUTER JOIN시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)를 붙여야 정상적인 OUUTER JOIN으로 동작한다.
-- 한 컬럼이라도 (+)를 누락하면 INNER 조인으로 동작
SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--사원 - 매니저간 RIGHT OUTER JOIN
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename
FROM  emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, e.ename
FROM emp e RIGHT OUTER JOIN emp e ON(m.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복 제거;
-- LEFT OUTER : 14건, RIGHT OUTER : 22건ㅇ
SELECT e.empno, e.ename, e.mgr, m.empno, e.ename
FROM emp e FULL OUTER JOIN emp m ON ( e.mgr = m.empno);


--outer join1
--오라클 OUTER JOIN에서는 (+)기호를 이용하여 FULL OUTER 문법을 지원하지 않는다.
SELECT *
FROM prod;

SELECT *
FROM buyprod;

--오라클 문법
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');

--안시 문법
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod LEFT OUTER JOIN buyprod ON (prod.prod_id = buyprod.buy_prod AND buyprod.puy_date = TO_DATE('20050125','YYYYMMDD');

SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM prod p, buyprod b
WHERE p.prod_id = b.buy_prod(+)
AND b.buy_date(+) = '2005/01/25';

--outer join2
SELECT NVL(buyprod.buy_date, TO_DATE('20050125','YYYYMMDD'))buy_date ,buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');

