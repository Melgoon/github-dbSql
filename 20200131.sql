-- cond3
    SELECT userid,usernm,alias,reg_dt,
    DECODE(MOD(TO_NUMBER(TO_CHAR(reg_dt,'YYYY')),2), MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2), '�ǰ����� �����','�ǰ����� ������') con4
    FROM users;
    
--JOIN
--RDBMS�� �ߺ��� �ּ�ȭ �ϴ� ������ ������ ���̽�
-- �ٸ� ���̺�� �����Ͽ������͸� ��ȸ

SELECT ename,deptno
FROM emp;

SELECT *
FROM dept;

--���̺� �ߺ��� �����Ͱ� �ִٸ�
--emp ���̺� �μ����� ����
--���� ���� ���� SALES �μ��� �̸��� MARKET SALES�� ���� �ȴٸ�?
--SALES �μ� ���� ��ŭ�� ������Ʈ�� �ʿ�(6ȸ)

--JOIN �� ���̺��� �����ϴ� �۾�
--JOIN ����
--1. ANSI ����
--2. ORACLE ����

--Natural Join
-- �� ���̺� �÷����� ���� �� �ش� �÷����� ����(����)
-- emp, dept ���̺��� deptno ��� �÷��� ����
SELECT *
FROM emp NATURAL JOIN dept;

-- Natural Join�� ���� ���� �÷�(deptno)�� ������(ex: ���̺��, ���̺� ��Ī)�� ������� �ʰ� �÷��� ����Ѵ� ( dept.deptno --> deptno)

SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

-- ���̺� ���� ��Ī�� ��밡��
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM ���� ������ ���̺� ����� ,�� �����Ͽ� �����Ѵ�.
-- ������ ���̺��� ���� ������ WHERE���� ����Ѵ�.
-- emp, dept ���̺� �����ϴ� deptno �÷��� (���� ��) ����
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

-- ����Ŭ ������ ���̺� ��Ī
SELECT e.empno,e.ename,d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING
-- �����Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ������� �ϳ��� �÷����θ� ������ �ϰ��� �� �� �����Ϸ��� ���� �÷��� ���
-- emp, dept ���̺��� ���� �÷� : deptno
SELECT emp.ename,dept.dname, deptno
FROM emp JOIN dept USING(deptno);

--JOIN WITH USING�� ORACLE�� ǥ���ϸ�?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--���� �Ϸ����ϴ� ���̺��� �÷��� �̸��� ���� �ٸ� ��

SELECT emp.ename, dept.dname, emp.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON --> ORACLE

SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- SELF JOIN : ���� ���̺��� ����
-- �� : emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� ������ �̸��� ��ȸ�� ��
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--����Ŭ �������� �ۼ�
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e,emp m
WHERE e.mgr = m.empno;

--equal ���� : =
--non-euqal ���� : !=,��>,<, BETWWEN AAN

--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش� ����� �޿� ����� ���غ���;
SELECT ename,sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

-- ANSI ������ �̿��Ͽ� ���� ���� ���� �ۼ�
SELECT e.ename, e.sal, s.grade
FROM emp e JOIN salgrade s ON ( E.SAL BETWEEN S.LOSAL AND S.HISAL);

--join0
--����Ŭ
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
