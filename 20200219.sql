SELECT *
    FROM 
    (SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <= 14) a,
 
    (SELECT deptno, COUNT(*) cnt,
    FROM emp
    GROUP BY deptno) b
    WHERE b.cnt >= a.lv
    ORDER BY b.deptno, a.lv; 

���� ������ �м��Լ��� ����ؼ� ǥ���ϸ�....
�μ��� �޿� ��ŷ;

SELECT ename,sal,deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

SELECT ename,sal,deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

���� ���� ��� 11��
����¡ ó��(�������� 10���� �Խñ�)
1������ : 1~10
2������ : 11~20
���ε� ���� : page, :pageSize;

SELECT *
FROM
    (SELECT a.*,ROWNUM rn
    FROM
        (SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
        FROM board_test
            START WITH parent_seq IS NULL
            CONNECT BY PRIOR seq = parent_seq
            ORDER SIBLINGS BY root DESC, seq ASC) a)
            WHERE rn BETWEEN (:page - 1)*:pageSize + 1 AND :page * :pageSize;


rownum���� ����¡ �����;

SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename FROM emp)
    WHERE rn >=11 AND rn <= 14;
    
    SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename FROM emp)
    WHERE rn BETWEEN  11 AND 20;
    
    
�м��Լ�/window �Լ�;

�м��Լ� ����
�м��Լ���([����]) OVER([PARTITION BY �÷�] [ORDER BY �÷�] [WINDOWING])
PARTITION BY �÷� : �ش� �÷��� ���� ROW���� �ϳ��� �׷����� ���´�.
ORDER BY �÷� : PARTITION BY�� ���� ���� �׷� ������ ORDER BY �÷����� ����

ROW_NUMBER(0 OVER (PARTITION BY deptno ORDER BY sal DESC) rank;

���� ���� �м��Լ�
RANK() : ���� ���� ���� �� �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����
            2���� 2���̸� 3���� ���� 4����� �ļ����� �����ȴ�.
DENSE_RANK() : ���� ���� ���� �� �ߺ� ������ ����, �ļ����� �ߺ������� �������� ����
                2���� 2���̴��� �ļ����� 3����� ����
ROW_NUMBER() : ROWNUM�� ����, �ߺ��� ���� ������� ����;

�μ���, �޿� ������ 3���� ��ŷ �����Լ��� ����;
SELECT ename,sal,deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;

mo_ana1 ��� ��ü �޿� ������ ���ϼ���.;
�м��Լ� ���� �׷� : RAPTITION BY  ==> ������� ������ ��ü�÷����� ��ȸ
SELECT COUNT(*)
FROM emp;

SELECT a.*
FROM
(SELECT emp.*,
        RANK() OVER (ORDER BY sal,empno) rank,
        DENSE_RANK() OVER ( ORDER BY sal,empno) sal_dense_rank,
        ROW_NUMBER() OVER ( ORDER BY sal,empno) sal_row_number
FROM emp)a;

no_ana2;

select *
from emp;

select count(*)
from emp;

SELECT empno,ename,emp.deptno,cnt
from emp,
(SELECT deptno, COUNT(*) cnt
    FROM emp
     GROUP BY deptno) dept_cnt
WHERE emp.deptno = dept_cnt.deptno;

������ �м��Լ� (GROUP �Լ����� �����ϴ� �Լ� ������ ����)
SUM(�÷�)
COUNT(*), COUNT(�÷�)
MIN(�÷�)
MAX(�÷�)
AVG(�÷�)

no_ana2�� �м��Լ��� ����ؼ� �ۼ�;

SELECT empno, ename, deptno,COUNT (*) OVER (PARTITION BY deptno) cnt
FROM emp;

ana2 window function�� ����Ͽ� ��� ����� ���� �����ȣ,����̸�,���� �޿�,�μ���ȣ�� �ش� ����� ���� �μ��� �޿� ����� ��ȸ�ϴ� ������ �ۼ�;
SELECT empno, ename,sal, deptno,ROUND(AVG(sal) OVER(PARTITION BY deptno),2) avg_sal
FROM emp;

ana3�� �м��Լ��� ����ؼ� �ۼ�;
SELECT empno, ename,sal, deptno,MAX(sal) OVER(PARTITION BY deptno) MAX_sal
FROM emp;

ana4�� �м��Լ��� ����ؼ� �ۼ�;
SELECT empno, ename,sal, deptno,MIN(sal) OVER(PARTITION BY deptno) MIN_sal
FROM emp;

�޿��� �������� �����ϰ�, �޿��� ���� ���� �Ի����ڰ� ��������� ���� �켱������ �ǵ��� �����Ͽ�
���� ���� ���� ��(LEAD)�� sal �÷��� ���ϴ� ������ �ۼ�;

SELECT empno,ename,hiredate,sal,LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

ana5;

SELECT empno,ename,hiredate,sal,LAG(sal) OVER(ORDER BY sal DESC, hiredate) LAG_sal
FROM emp;

ana6 ��� ����� ����, �������� �޿� ������ 1�ܰ� ���� ���(�޿��� ���� ��� �Ի����� ��������� ���� ����);
select empno,ename,hiredate,job,sal, LAG(sal) OVER(PARTITION BY job ORDER BY SAL DESC) LAG_sal
from emp;

�м��Լ�/window�Լ� (�ǽ� no_ana3);
select *
from
(select a.*,ROWNUM rn
from
(SELECT empno,ename,sal
FROM EMP
ORDER BY sal)a),

(SELECT sum(sal)
    FROM emp) b
    WHERE emp.sal = emp.sal; 
    
no_ana3�� �м��Լ��� �̿��Ͽ� SQL �ۼ�;

SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) comm_sal
FROM emp;

���� ���� �������� ���� ������� ���� ������� �� 3������ sal �հ� ���ϱ�;

SELECT empno, ename, deptno, sal,
    SUM(sal) OVER(ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

ana7
ORDER BY ��� �� WINDOWING ���� ������� ���� ��� ���� WINDOWING�� �⺻ ������ ���� �ȴ�.
RANGE UNBOUNDED PRECEDING (����Ʈ��)
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW;

SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno) c_sum
FROM emp;


WINDOWING�� RANGE, ROWS��
RANGE : ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
ROWS : �������� ���� ����;

SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal range UNBOUNDED PRECEDING) range_,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal) default_
FROM emp;

������ �Լ� �ǽ�
 .no_ana2~3, ana0~7

������ �Լ�
 . ���� ����
 . �׷� �Լ� 
 .windowing





