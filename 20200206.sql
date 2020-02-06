--sub7

select *
from customer;


select *
from cycle;

SELECT a.cid,customer.cnm,a.pid,product.pnm, a.day, a.cnt
FROM
(SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)) a,customer,product
            WHERE a.cid = customer.cid AND a.pid = product.PID;
            
--�����ÿ� �ִ� 5���� �� �ܹ�������
--(kfc + ����ŷ + �Ƶ�����) / �Ե�����;

SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%����%'
GROUP BY sido;

--����(KFC,����ŷ,�Ƶ�����)

--����������	�߱�	7
--����������	����	4
--����������	������	4
--����������	����	17
--����������	�����	2

SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '����������' AND GB IN ('KFC','����ŷ','�Ƶ�����')
GROUP BY sido, sigungu;


--�Ե�����
--����������	�߱�	6
--����������	����	8
--����������	����	12
--����������	������	8
--����������	�����	7
SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '����������' AND GB IN ('�Ե�����')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2,2) hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*) c1
FROM fastfood
WHERE /*sido = '����������' AND*/ GB IN ('KFC','����ŷ','�Ƶ�����')
GROUP BY sido, sigungu) a,


(SELECT sido, sigungu, COUNT(*) c2
FROM fastfood
WHERE /*sido = '����������' AND*/ GB IN ('�Ե�����')
GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;

--fastfood ���̺��� �ѹ��� �д� ������� �ۼ��ϱ�
SELECT ROWNUM, sido, sigungu, ROUND((kfc+burgerking+mac) / lot, 2) burger_score
FROM
(SELECT sido, sigungu,
        NVL(SUM(DECODE(gb,'KFC', 1)),0) kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)),0) burgerking,
        NVL(SUM(DECODE(gb, '�Ƶ�����', 1)),0) mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)),1)lot
        
FROM fastfood
WHERE gb IN('KFC','����ŷ','�Ƶ�����','�Ե�����')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;


SELECT *
FROM fastfood
WHERE sido = '��⵵'
AND sigungu = '������';

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

--�ܹ��� ����, ���κ� �ٷμҵ� �ݾ� ������ ���� �õ����� [����] ����, ���κ� �ٷμҵ� �ݾ����� ���� �� ROWNUM�� ���� ������ �ο� ���� ������ �ೢ�� ����
--�ܹ������� �õ�, �ܹ��� ���� �ñ���, �ܹ�������, ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ��

/*--ROWNUM ���� ����
1. SELECT ==> ORDER BY
    ���ĵ� ����� ROWNUM�� �����ϱ� ���켭�� INLINE-VIRW
2.1������ ���������� ��ȸ�� �Ǵ� ���� ���ؼ��� WHERE ������ ����� ����
    ROWNUM = 1 (O)
    ROWNUM = 2 (X)
    ROWNUM < 10 (O)
    ROWNUM > 10 (X)*/
    
/*ROWNUM - ORDER BY
ROUND
GROUP BY SUM
JOIN
DECODE
NVL
IN*/

-- �̰� �� ������ ��
 SELECT b.sido, b.sigungu, b.burger_score, a.sido, a.sigungu, a.pri_sal
FROM 
(SELECT ROWNUM rn, a.*
FROM 
(SELECT sido, sigungu, ROUND(sal/people) pri_sal
 FROM tax
 ORDER BY pri_sal DESC) a) a,

(SELECT ROWNUM rn, b.*
FROM
(SELECT sido, sigungu, ROUND((kfc + BURGERKING + mac) / lot, 2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC', 1)), 0) kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)), 0) BURGERKING,
       NVL(SUM(DECODE(gb, '�Ƶ�����', 1)), 0) mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)), 1) lot       
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC) b ) b
WHERE a.rn = b.rn;

--DML

--empno �÷��� NOT NULL ���� ������ �ִ�. - INSERT �� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�
--empno �÷��� ������ ������ �÷��� NULLABLE �̴�. (NULL ���� ����� �� �ִ�.)
INSERT INTO emp(empno,ename,job)
VALUES (9999,'brown',NULL);

select *
from emp;

INSERT INTO emp (ename,job)
VALUES ('sally','SALESMAN');

--���ڿ� : '���ڿ�'(�̱������̼�) ==> "���ڿ�"(JAVA���� �̷���)
-- ���� : 10
-- ��¥ : TO_DATE('20200206','YYYYMMDD')

--emp ���̺��� hiredate �÷��� date Ÿ��

--emp���̺��� 8���� �÷��� ���� �Է�;
DESC emp ;

INSERT INTO emp VALUES (9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99);
ROLLBACK;

--�������� �����͸� �ѹ��� INSERT :
--INSERT INTO ���̺�� (�÷���1, �÷���2...)
--SELECT ...
--FROM ;

INSERT INTO emp
SELECT 9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99
FROM dual

    UNION ALL
    
SELECT 9999,'brown','CLERK',NULL, TO_DATE('20200205','YYYYMMDD'),1100,NULL,99
FROM dual;

SELECT *
FROM emp;

--UPDATE ����
--UPDATE ���̺�� SET �÷���1 = ������ �÷� ��1, �÷��� 2 = ������ �÷� ��2,.....
--WHERE �� ���� ����
--������Ʈ ���� �ۼ��� WHERE ���� �������� ������ �ش� ���̺��� ��� ���� ������� ������Ʈ�� �Ͼ��.
--UPDATE, DELETE ���� WHERE���� ������ �ǵ��Ѱ� �´��� �ٽ��ѹ� Ȯ���Ѵ�.
--WHERE���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT�ϴ� ������ �ۼ��Ͽ� �����ϸ� UPDATE ��� ���� ��ȸ�� �� �����Ƿ� Ȯ���ϰ� �����ϴ� �͵�
-- ��� �߻� ������ ������ �ȴ�.

--99�� �μ���ȣ�� ���� �μ� ������ DEPT���̺� �ִ� ��Ȳ
--INSERT INTO dept VALUES (99,'ddit','desjeon');
SELECT *
FROM dept;
--99�� �μ���ȣ�� ���� �μ��� DNAME �÷��� ���� '���IT', loc �÷��� ���� '���κ���'���� ������Ʈ
UPDATE dept SET DNAME = '���IT', loc = '���κ���'
where deptno = 99;

SELECT *
FROM DEPT;

--�Ǽ��� WHERE���� ������� �ʾ��� ���;
UPDATE dept SET dnme = '���IT', loc = '���κ���'
ROLLBACK;

--�����-�ý��� ��ȣ�� �ؾ���� ==> �Ѵ޿� �ѹ��� ��� ������� ������� ���� �ֹι�ȣ ���ڸ��� ��й�ȣ�� ������Ʈ
-- �ý��� ����� : �����(12,000), ������(550), ����(1300)
--UPDATE ����� set ��й�ȣ = �ֹι�ȣ���ڸ�
--WHERE ����ڱ��� = '�����'

-- 10 ==> SUBQUERY 
-- SMITH, WARD�� ���� �μ��� �Ҽӵ� ���� ����
SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN ('SMITH','WARD'));
--UPDATE�ÿ��� ���� ���� ����� ����;
INSERT INTO emp(empno, ename) VALUES (9999,'brown');

select *
from emp;

--9999�� ��� deptno, job ������ SMITH ����� ���� �μ�����, �������� ������Ʈ

UPDATE emp SET deptno = (SELECT deptno
                            FROM emp
                            WHERE ename = 'SMITH'),job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

select *
from emp;

ROLLBACK;

--DELETE
--DELETE SQL : Ư�� ���� ����
--DELETE [FROM] ���̺�� WHERE �� ���� ����
--DELETE[FROM] table [WHERE condition]; // �� ������ ���� �ʿ�� ����

SELECT *
FROM dept;

--99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����

DELETE dept WHERE deptno = 99;

SELECT *
FROM dept;
COMMIT;


--SUBQUERY�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE;
--�Ŵ����� 7698 ����� ������ ���� �ϴ� ������ �ۼ�

DELETE emp
WHERE empno IN (7499,7521,7654,7844,7900); -- �ϵ��ڵ�

DELETE emp
WHERE empno IN(SELECT empno
                FROM emp
                WHERE mgr = 7698); --���� ������ ����� DELETE
                
SELECT *
FROM emp;
                
ROLLBACK; -- Ŀ���ϱ� ���� ������ ��ũ��Ʈ�� �ǵ�����. 

SELECT *
FROM emp;

--Ʈ����� : ���� �ܰ��� ������ �ϳ��� �۾� ������ ���� ����





