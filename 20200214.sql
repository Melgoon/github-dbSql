/*group_ad2
group_ad2-1 decode 2��, case
DECODE ���� ( ����  X)
DECODE (GROUPING (job) || GROUPING(deptno) , 00 , 
                                            ,01,
                                            ,11,*/

SELECT DECODE (GROUPING (job) || GROUPING(deptno), '11','��',
                                                    '00',job,
                                                    '01',job) job,
        DECODE(GROUPING (job) || GROUPING(deptno),  '11','��',
                                                    '00',deptno,
                                                    '01','�Ұ�')deptno,
                                                    SUM(sal + NVL(comm, 0 )) sal
FROM emp
GROUP BY ROLLUP(job,deptno);

/*MERGER : SELECT�ϰ��� �����Ͱ� ��ȸ�Ǹ� UPDATE
            SELECT�ϰ��� �����Ͱ� ��ȸ���� ������ INSERT
            
SELECT + UPDATE / SELECT + INSERT ==> MERGE;

REPORT GROUP FUNCTION
1.ROLLUP
    -GROUP BY ROLLUP (�÷�1, �÷�2)
    -ROLLUP���� ����� �÷��� �����ʿ��� �ϳ��� ������ �÷����� SUBGROUP
    -GROUP BY �÷�1, �÷�2
    UNION
    GROUP BY �÷�1
    UNION
    GROUP BY
2.CUBE
3. GROUPING SETS */

--group_AD3
--(�����ʺ��� ��ȸ�Ѵ�)
--GROUP BY ROLLUP deptno,job
--GROUP BY ROLLUP deptno
--GROUP BY ROLLUP
select deptno,job,sum(sal+NVL(comm,0))sal
FROM emp
GROUP BY ROLLUP(deptno,job);

--gropup_ad4
select *
FROM emp;
select *
from dept;

select dept.dname,emp.job,sum(emp.sal)
FROM emp,dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job);



--ad4���� �ζ��� ��� �ƿ��������� ������� ��
SELECT b.dname,a.job,a.sal
FROM 
(select deptno,job,sum(sal) sal
FROM emp
GROUP BY ROLLUP(deptno,job)) a, dept b
WHERE a.deptno = b.deptno(+);

--ad5
select DECODE(GROUPING(dept.dname),1,'����',0,dept.dname) dname,emp.job,sum(emp.sal)
FROM emp,dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job);

/*
REPORT GROUP FUNCTION
1.ROLLUP
2.CUBE
3.GROUPING SETS

Ȱ�뵵
3, 1 >>>>>>>>>>>>>>>>>>>> CUBE


GROUPING SETS
������ ������� ���� �׷��� ����ڰ� ���� ����
����� : GROUP BY GROUPING SETS(col1,col2....)

GROUP BY GROUPING SETS(col1,col2) ==> GROUP BY col1 UNION ALL GROUP BY col2

GROUP BY GROUPING SETS((col1,col2) col3,col4) ==> GROUP BY col1,col2 UNION ALL GROUP BY col3 UNION ALL GROUP BY col4

GROUPING SETS�� ��� �÷� ��� ������ ����� ������ ��ġ�� �۴´�.
ROLLUP�� �÷� ��� ������ ��� ������ ��ģ��.
GROUP BY GROUPING SETS((col1,col2) => GROUP BY col1 UNION GROUP BY col2
GROUP BY GROUPING SETS((col2,col1) => GROUP BY col2 UNION GROUP BY col1
*/
GROUP BY GROUPING SETS(job,deptno)
==> GROUP BY job
UNION
GROUP BY deptno;

SELECT job,SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job,job);

/*job,deptno�� GROUP BY �Ѱ����
mgr�� GROUP BY�� ����� ��ȸ�ϴ� SQL�� GROUPING SETS�� SUM(sal) �ۼ�;*/

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS ((job,deptno), mgr);

--CUBE
������ ��� �������� �÷��� ������ sub GROUP�� �����Ѵ�.
�� ����� �÷��� ������ ��Ų��.;

EX : GROUP BY CUBE(col1,col2); -- 4���� ���� ����.
(null,col2) ==> GROUP BY col2
(null,null) ==> GROUP BY ��ü
(col1,null) ==> GROUP BY COL1
(col1,col2) ==> GROUP BY col1,col2;

���� �÷� 3���� CUBE���� ����� ��� ���� �� �ִ� ��������?? 2�辿���� �÷��� �ΰ��϶� �������� 4������ 3���� 8�� 4���� 16��

SELECT job,deptno,SUM(sal) sal
FROM emp
GROUP BY CUBE(job,deptno);

--job,deptno�� null�̸� GROUP BY ��ü
--job�� null�̸� GROUP BY DEPTNO
--deptno�� null�̸� GROUP BY job
--job,deptno���� ��� ������ GROUP BY job,deptno


--ȥ��

SELECT job,deptno,mgr,SUM(sal) sal
FROM emp
GROUP BY job, rollup(deptno),CUBE(mgr);

--�ؼ�
GROUP BY job, deptno, mgr ==  GROUP BY job, deptno, mgr
GROUP BY job, deptno == GROUP BY job, deptno
GROUP BY job, null,mgr == GROUP BY job,mgr
GROUP BY job, null,null == GROUP BY job

--�������� UPDATE
1.emp_test ���̺� drop
2.emp ���̺��� �̿��ؼ� emp_test ���̺���� (��� �࿡ ���� ctas)
3.emp_test ���̺� dname VARCHAR2(14)�÷� �߰�
4.emp_test.dname �÷��� dept ���̺��� �̿��ؼ� �μ����� ������Ʈ;

drop table emp_test;
CREATE TABLE emp_test AS 
SELECT *
FROM emp;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

DESC DEPT;

SELECT *
FROM emp_test;

UPDATE emp_test SET dname = (SELECT dname
                            FROM dept
                            WHERE dept.deptno = emp_test.deptno); --��ȣ ���� ����
                            
                            COMMIT;
                            
--sub_a1
DROP TABLE dept_test;

CREATE TABLE dept_test AS 
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT count(deptno) -- ī��Ʈ�� �μ���ȣ�� ī��Ʈ�Ͽ� ���� Ȯ��
                                FROM emp_test
                                WHERE emp_test.dname = dept_test.dname);
                                
 /*UPDATE dept_test SET empcnt = NVL(SELECT count(*) cnt -- ī��Ʈ�� �μ���ȣ�� ī��Ʈ�Ͽ� ���� Ȯ��
                                FROM emp_test
                                WHERE emp_test.dname = dept_test.dname
                                group by deptno),0);*/ �̰͵� ���;
SELECT *
FROM dept_test;

SELECT *
FROM emp_test;

sub_a2
dept_test���̺� �ִ� �μ��߿� ������ ������ ���� �μ� ������ ����
*dept_test.empcnt �÷��� ������� �ʰ� emp ���̺��� �̿��Ͽ� ����;

INSERT INTO dept_test VALUES(99,'it1','daejeon',0);
INSERT INTO dept_test VALUES(98,'it2','daejeon',0);
COMMIT;

������ ������ ���� �μ� ���� ��ȸ?
������ �ִ� ����....?
10�� �μ��� ���� �ִ� ����?;

SELECT count(*)
FROM emp
WHERE deptno=20;

SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)
            FROM emp
            WHERE deptno = dept_test.deptno);
            
/*DELETE *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)
            FROM emp
            WHERE deptno = dept_test.deptno);*/ ����;
            
sub_a3;

UPDATE emp_test A SET sal = sal + 200
WHERE sal < (SELECT AVG(SAL)
            FROM emp_test B
            WHERE A.deptno = B.deptno);
            
/*if( deptno = 10){
UPDATE emp_test A SET sal = sal + 200
WHERE sal < (SELECT AVG(SAL)
            FROM emp_test B
            WHERE A.deptno = B.deptno);
}*/

SELECT *
FROM emp_test;

WITH ��
�ϳ��� �������� �ݺ��Ǵ� SYBQUERY�� ���� ��
�ش� subquery�� ������ �����Ͽ� ����

MAIN������ ����� �� WITH ������ ���� ���� �޸𸮿� �ӽ������� ����
==> MAIN ������ ���� �Ǹ� �޸� ����

SUBQUERY �ۼ��ÿ��� �ش� SUBQUERY�� ����� ��ȸ�ϱ� ���ؼ� I/O �ݺ������� �Ͼ����

WITH���� ���� �����ϸ� �ѹ��� SUBQUERY�� ����ǰ� �� ����� �޸𸮿� ������ ���� ����

��, �ϳ��� �������� ������ SUBQUERY�� �ݺ������� ������ ���� �߸� �ۼ��� SQL�� Ȯ���� ����;

WITH ��������̸� AS (
    ��������
)

SELECT *
FROM ��������̸�;

������ �μ��� �޿� ����� ��ȸ�ϴ� ��������� WITH���� ���� ����
WITH sal_avg_dept AS(
    SELECT deptno, ROUND(AVG(sal),2) sal
    FROM emp
    GROUP BY deptno
),
    dept_empcnt AS(
    SELECT deptno, COUNT(*) empcnt
    FROM emp
    GROUP BY deptno)

SELECT *
FROM sal_avg_dept A, dept_empcnt b
WHERE a.deptno = b.deptno;

SELECT *
FROM sal_avg_dept a, sal_avg_dept b;

WITH ���� �̿��� �׽�Ʈ ���̺�

WITH temp AS(
    SELECT sysdate -1 FROM dual UNION ALL
    SELECT sysdate -2 FROM dual UNION ALL
    SELECT sysdate -3 FROM dual)
SELECT *
FROM temp;

�޷¸����;
CONNECT BY LEVEL <[=] ����
�ش� ���̺��� ���� ���� ��ŭ �����ϰ�, ������ ���� �����ϱ� ���ؼ� LEVEL�� �ο�
LEVEL�� 1���� ����;

SELECT dummy,LEVEL
FROM dual
CONNECT BY LEVEL <= 10;

SELECT dept.*,LEVEL
FROM dept
CONNECT BY LEVEL <= 5;

2020�� 2���� �޷��� ����
:dt = 202002,202003

�޷��� Ư¡
�� �� ȭ �� �� �� ��

--2���� �޷� ����
SELECT LAST_DAY(ADD_MONTHS(TO_DATE('202002','YYYYMM'),-1)) + LEVEL
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')), 'DD');

SELECT TO_DATE('202002','YYYYMM') + (LEVEL -1),
        TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL -1), 'D'),
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),1
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))s,
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),2
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))m,
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),3
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))t,
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),4
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))w,
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),5
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))t2,
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),6
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))f,
        DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1),'D'),7
                        ,TO_DATE('202002','YYYYMM') + (LEVEL-1))s2
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')), 'DD');

SELECT TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')), 'D')
FROM dual;















