SELECT *
FROM CUSTOMER;

SELECT *
FROM PRODUCT;

SELECT *
FROM CYCLE; -- �Ͽ��� 1 ����� 7


--�Ǹ��� : 200~250
-- ���� 2.5�� ��ǰ
-- �Ϸ� : 500~750
-- �Ѵ� : 15000~17500


SELECT *
FROM daily;

SELECT *
FROM batch;

-- join4 : join�� �ϸ鼭 ROW�� �����ϴ� ������ ����
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

--join6 : join�� �ϸ鼭(3�� ���̺�) ROW�� �����ϴ� ������ ����, �׷��Լ� ����
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

-- SYSTEM ������ ���� HR ���� Ȱ��ȭ
-- �ش� ����Ŭ ������ ��ϵ� �����(����)��ȸ
SELECT *
FROM dba_users;

--HR ������ ��й�ȣ�� JAVA�� �ʱ�ȭ
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;

--OUTER JOIN
-- �� ���̺��� ������ �� ���� ������ ���� ��Ű�� ���ϴ� �����͸� �������� ������ ���̺��� �����͸��̶� ��ȸ �ǰԲ� �ϴ� ���� ���

--�������� : e.mgr = m.empno : KING�� MGR NULL�̱� ������ ���ο� �����Ѵ�.
-- EMP ���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 13���� �ȴ�. (1���� ���ν���)
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--ANSI OUTER
-- 1. ���ο� �����ϴ��� ��ȸ�� �� ���̺��� ���� (�Ŵ��� ������ ��� ��������� �����Բ�);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;
--RIGHT OUTER�� ����
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;

--ORACLE OUTER JOIN
--�����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+)��ȣ�� �ٿ��ش�.
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--���� SQL�� ANSI SQL(OUTER JOIN)���� �����غ�����.

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

--���� SQL�� ANSI SQL(OUTER JOIN)���� �����غ�����.
-- �Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);

�Ʒ� LEFT OUTER ������ ���������� OUTER ������ �ƴϴ�
�Ʒ� INNER ���ΰ� ����� �����ϴ�.
SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;

--����Ŭ outer join
-- ����Ŭ OUTER JOIN�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ��� �������� OUUTER JOIN���� �����Ѵ�.
-- �� �÷��̶� (+)�� �����ϸ� INNER �������� ����
SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename,e.mgr,m.ename,m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--��� - �Ŵ����� RIGHT OUTER JOIN
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename
FROM  emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, e.ename
FROM emp e RIGHT OUTER JOIN emp e ON(m.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ� ����;
-- LEFT OUTER : 14��, RIGHT OUTER : 22�Ǥ�
SELECT e.empno, e.ename, e.mgr, m.empno, e.ename
FROM emp e FULL OUTER JOIN emp m ON ( e.mgr = m.empno);


--outer join1
--����Ŭ OUTER JOIN������ (+)��ȣ�� �̿��Ͽ� FULL OUTER ������ �������� �ʴ´�.
SELECT *
FROM prod;

SELECT *
FROM buyprod;

--����Ŭ ����
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');

--�Ƚ� ����
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

