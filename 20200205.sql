--sub4
--������ �߰�
--���ȣ ���� ����, ���� �̿�
--dept ���̺��� 5���� �����Ͱ� ����
--emp ���̺��� 14���� ������ �ְ�, ������ �ϳ��� �μ� ���� �ִ�.(deptno)
--�μ��� ������ ���� ���� ���� �μ� ������ ��ȸ�϶�.

--������������ �������� ������ �´��� Ȯ���� ������ �ϴ� �������� �ۼ�

INSERT INTO dept VALUES(99,'ddit','daejeon');

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp
                    GROUP BY deptno);

--ROLLBACK Ʈ����� ���
COMMIT; --Ʈ����� Ȯ��

--sub5
--��� ��ǰ�� ���� 4����

SELECT *
FROM product;

--cid=1�� ���� �����ϴ� ��ǰ

SELECT pid
FROM cycle
WHERE cid = 1;

SELECT *
FROM product
WHERE pid NOT IN(100,400);

SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
FROM cycle
WHERE cid = 1);



SELECT *
FROM product
WHERE PID NOT IN (SELECT PID
                    FROM cycle
                    WHERE PID IN(100,400));

--sub6
--cid=2�� ���� �����ϴ� ��ǰ�� cid=1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϴ� ���� �ۼ�

--cid=1�� ���� ���� ���� ( 100��,400�� ��ǰ�� ������)
SELECT *
FROM cycle
WHERE cid = 1;

--cid=2�� ���� ���� ����(100,200�� ��ǰ�� ������)
SELECT *
FROM cycle
WHERE cid = 2;

--cid = 1, cid=2�� ���� ���ÿ� �����ϴ� ��ǰ�� 100��

SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);

SELECT *
FROM cycle

WHERE cid IN(SELECT cid
                FROM cycle
                WHERE cid = 1 OR cid = 2 AND PID = 100);
--sub7
SELECT a.cid,customer.cnm,a.pid,product.pnm, a.day, a.cnt
FROM
(SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)) a,customer,product
            WHERE a.cid = customer.cid AND a.pid = product.PID;
            
            
SELECT cycle.cid,customer.cnm,cycle.pid,product.pnm,cycle.day,cycle.cnt
FROM cycle, customer, PRODUCT
WHERE cycle.cid = 1 AND cycle.pid IN(SELECT pid
                        FROM cycle
                        WHERE cid = 2)
                        AND cycle.cid = customer.cid AND cycle.pid = product.pid;
                        
SELECT cycle.cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm, --�����ϴ� ����� �ƴ�, ������� �ʾƾ��� ���
        cycle.pid, (SELECT pnm FROM product WHERE pid = cycle.pid) pnm,
        cycle.day, cycle.cnt
FROM cycle
WHERE cid = 1 AND pid IN(SELECT cid
                FROM cycle
                WHERE cid = 2);
                
--�Ŵ����� �����ϴ� ������ ��ȸ(KING�� ������ 13���� �����Ͱ� ��ȸ)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXSITS ���ǿ� �����ϴ� ���� ���� �ϴ��� Ȯ���ϴ� ������
--�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴ´�.
 -- WHERE empno = 7369
 -- WHERE EXISTS (SELECT 'X'
 --                 FROM ......);
 
 -- �Ŵ����� �����ϴ� ������ EXISTS �����ڸ� ���� ��ȸ
 -- �Ŵ����� ����
 SELECT *
 FROM emp e
 WHERE EXISTS (SELECT 'X'
                FROM emp m
                WHERE e.mgr = m.empno);
                
--sub9
--1�� ���� �����ϴ� ��ǰ;

SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
FROM cycle
WHERE cid = 1);

select *
from cycle;
select *
from product;

SELECT *
FROM product e 
WHERE EXISTS (SELECT 'X'
                FROM cycle m
                WHERE m.cid = 1 AND m.pid = e.pid);
                
--sub10

SELECT *
FROM product e 
WHERE NOT EXISTS (SELECT 'X'
                FROM cycle m
                WHERE m.cid = 1 AND m.pid = e.pid);
--���տ���
--������ : UNION -�ߺ�����(���հ���) / UNION ALL - �ߺ��� �������� ����(�ӵ� ���)
--������ : INTERSECT (���հ���)
--������ : MINUS (���հ���)
--���տ����� ������
--�� ������ �÷��� ����, Ÿ���� ��ġ �ؾ� �Ѵ�

--������ ������ �����ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�.
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--UNION ALL�����ڴ� UNION �����ڿ� �ٸ��� �ߺ��� ����Ѵ�.

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--INTERSECT(������) : ��, �Ʒ� ���տ��� ���� ���� �ุ ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

-- MINUS(������) : �� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����;

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--������ ��� ������ ������ ���� ���տ�����
-- A UNION B  B UNION A ==> ����
-- A UNION ALL B B UNION ALL A ==> ����(����)
-- A INTERSECT B B INTERSECT A ==> ����
-- A MINUS B B MINUS A ==> �ٸ�

--���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������.
SELECT 'X' fir,'B' sec
FROM dual

UNION

SELECT 'Y','A'
FROM dual;

--����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ���
SELECT deptno, dname, loc
    FROM dept
    WHERE DEPTNO IN(10,20)
    --ORDER BY deptno 


UNION

SELECT deptno,dname,loc
FROM dept
WHERE DEPTNO IN(30,40)
ORDER BY DEPTNO;


SELECT deptno, dname,loc
FROM(SELECT deptno, dname, loc
    FROM dept
    WHERE DEPTNO IN(10,20)
    ORDER BY deptno)


UNION

SELECT deptno,dname,loc
FROM dept
WHERE DEPTNO IN(30,40)
ORDER BY DEPTNO;

SELECT *
FROM fastfood;

-- �������� ==> (kfc���� + ����ŷ ���� + �Ƶ����� ����) / �Ե����� ����
--�õ�,�ñ���,��������
--�������� ���� ���� ���ð� ���� �������� ����

SELECT count(GB) count_GB
FROM fastfood;

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = '�Ե�����'; --�Ե����� 912��

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = '����ŷ'; --������ġ 282��

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = 'KFC'; -- KFC 111��

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = '�Ƶ�����'; -- �Ƶ����� 468��

-- ������ġ+KFC+�Ƶ����� / �Ե�����

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB IN('����ŷ','KFC','�Ƶ�����')--861�� / 912��

MINUS

SELECT SIDO,SIGUNGU,GB
FROM fastFOOD
where GB IN('�Ե�����'); --912��

-- ����� �������� :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('����������') AND SIGUNGU IN('�����') ORDER BY GB DESC; --�Ƶ����� 3�� �Ե����� 7��

-- �߱� �������� : 
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('����������') AND SIGUNGU IN('�߱�') ORDER BY GB DESC; -- �Ƶ����� 4��, ����ŷ 2�� KFC  1�� �Ե����� 6��
-- ���� �������� :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('����������') AND SIGUNGU IN('����') ORDER BY GB DESC;  -- ����ŷ 6�� �Ƶ����� 7�� KFC 4�� �Ե����� 12��
-- ������ �������� :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('����������') AND SIGUNGU IN('������') ORDER BY GB DESC; -- ����ŷ 1�� �Ƶ����� 3�� �Ե����� 8��
-- ���� �������� :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('����������') AND SIGUNGU IN('����') ORDER BY GB DESC; -- ����ŷ 2�� �Ƶ����� 2�� �Ե����� 8��
