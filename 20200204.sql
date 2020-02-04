--cross join ==> īƼ�� ���δ�Ʈ(Cartesian product)
--�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ��� ������ ��� ���տ� ���� ����(����)�� �õ�
--ex) dept(4��), emp(14��)�� CROSS JOIN�� ����� 4*14 = 56��

--dept ���̺�� emp ���̺��� ������ �ϱ� ���� FROM ���� �ΰ��� ���̺��� ��� WHERE���� �� ���̺��� ���� ������ ����

SELECT dept.dname,emp.empno,emp.ename
FROM dept, emp
WHERE dept.deptno=10
AND dept.deptno = emp.deptno;

SELECT *
FROM emp;

--crossjoin1
SELECT *
FROM customer CROSS JOIN product;

--SUBQUERY
--SUBQUERY : ���� �ȿ� �ٸ� ������ �� �ִ� ��� 
--SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
--SELECT �� : SCALAR SUBQUERY ( �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ���� )
--FROM �� : INLINE = VIEW (VIEW)
-- WHERE : SUBQUERY QUERY



--SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
--1.SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�.
--2.1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�.

--1.
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

--2. 1������ ���� �μ���ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno = 20;

--SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ����

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
--sub1 : ��� �޿����� ���� �޿��� �޴� ������ ��
--1. ��� �޿� ���ϱ�
--2. ���� ��� �޿����� ���� �޿��� �޴� ���
SELECT COUNT(sal)
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
--sub2 : ��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
-- ������ ������
-- IN : ���������� �������� ��ġ�ϴ� ���� ���� �� ��
-- ANY [ Ȱ�뵵�� �ټ� ������ ] : ���������� �������� �� ���̶� ������ ������ ��
-- ALL [ Ȱ�뵵�� �ټ� ������ ] : ���������� �������� ��� �࿡ ���� ������ ������ ��

--SUB3
--SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ
--SMITH�� ward ������ ���ϴ� �μ��� ��� ������ ��ȸ (20,30�� �μ� ������ ��ȸ)

--���������� ����� ���� ���� ���� = �����ڸ� ������� �� �Ѵ�.
SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename = 'SMITH' OR ename = 'WARD');
                
SELECT *
FROM emp
WHERE ename IN('SMITH', 'WARD');

SELECT *
FROM emp
WHERE deptno IN(20,30);

--SMITH, WARD ����� �޿����� �޿��� ���� ����
-- SMITH : 800 WARD : 1250 => 1250���� ���� ���
--ANY ���

SELECT *
FROM emp
WHERE sal < ANY(800,1250);



SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
            FROM emp
            WHERE ename IN ('SMITH','WARD'));
            
--SMITH, WARD ����� �޿����� �޿��� ���� ����(SMITH, WARD�� �޿� 2���� ��ο� ���� ���� ��
-- SMITH : 800 WARD : 1250 => 800���� ���� ���

SELECT *
FROM emp
WHERE sal > ALL(800,1250);

SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
--IN, NOT IN�� NULL�� ���õ� ���� ����

--������ ������ ����� 7566�̰ų� null
SELECT *
FROM emp
WHERE mgr IN(7566,null);

--������ ������ ����� 7902�̰ų�(OR) NULL
--IN �����ڴ� OR �����ڷ� ġȯ ����
SELECT *
FROM emp
WHERE mgr IN(7902,null);

--NULL�񱳴� = �����ڰ� �ƴ϶� IS NULL�� �� �ؾ������� IS �����ڴ� =�� ����Ѵ�
SELECT *
FROM emp
WHERE mgr = 7902
OR mgr = null;

--empno NOT IN (7902,NULL) ==> AND
--��� ��ȣ�� 7902�� �ƴϸ鼭 NULL�� �ƴ� ������
SELECT *
FROM emp
WHERE empno NOT IN(7902,NULL);

SELECT *
FROM emp
WHERE empno != 7902
AND empno != NULL; -- ���� �׻� ������

SELECT *
FROM emp
WHERE empno != 7902
AND empno IS NOT NULL;

--pairwis(������)
--�������� ����� ���ÿ� ���� ��ų ��
--(mgr,deptno)
--(7698,30),(7839,10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN(
SELECT mgr, deptno
FROM emp
WHERE empno IN(7499,7782));

--nonpairwis�� �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ�;
--mgr ���� 7698�̰ų� 7839 �̸鼭 deptno�� 10�̰ų� 30���� ����
--MGR,DEPTNO
--(7698,10),(7698,30)
--(7639, 10),(7839,30);
SELECT *
FROM emp
WHERE mgr IN(
            SELECT mgr
            FROM emp
            WHERE empno IN(7499,7782))
AND deptno IN(SELECT deptno
              FROM emp
              WHERE empno IN(7499,7782));

-- ��Į�� �������� : SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����
-- ��Į�� ���������� MAIN ������ �÷��� ����ϴ°� �����ϴ�.
SELECT SYSDATE
FROM dual;

SELECT  (SELECT SYSDATE FROM dual), dept.*
FROM dept;

SELECT empno, ename, deptno, 
       (SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp;

--INLINE VIEW : FROM ���� ����Ǵ� ��������

--MAIN ������ �÷��� SUBQUERY���� ��� �ϴ��� ������ ���� �з�
--��� �Ұ�� : correlated subquery(��ȣ ���� ����), ���� ������ �ܵ����� �����ϴ°� �Ұ���
--             ��������� ������ �ִ�. (main ==> sub)
-- ������� ���� ��� : non-correlated subquery(���ȣ ���� ��������), ���������� �ܵ����� �����ϴ°� ����
--              ��������� ������ ���� �ʴ�. (main ==> sub, sub ==> main)
--��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
                FROM emp);
                
--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ

SELECT AVG(sal)
FROM emp
WHERE deptno=20;

SELECT AVG(sal)
FROM emp
WHERE deptno=30;


SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
                FROM emp s
                WHERE s.deptno = m.deptno);
                
-- ���� ������ ������ �̿��ؼ� Ǯ���
--1. ���� ���̺� ����
-- emp,�μ��� �޿� ���(inline view)

SELECT emp.* --emp.ename,sal,emp.deptno,dept_sal.*
FROM emp, (SELECT deptno,ROUND(AVG(sal)) avg_sal FROM emp GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno AND emp.sal > dept_sal.avg_sal;

--sub4
--������ �߰�
--���ȣ ���� ����, ���� �̿�
INSERT INTO dept VALUES(99,'ddit','daejeon');

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
                FROM emp s
                WHERE s.deptno = m.deptno);

SELECT *
FROM dept;

SELECT *
FROM dept
WHERE deptno=30;

SELECT *
FROM emp;

SELECT *
FROM emp m (SELECT *
            FROM dept s
            WHERE s.deptno = m.empno);


--ROLLBACK Ʈ����� ���
COMMIT; --Ʈ����� Ȯ��
--sub5
