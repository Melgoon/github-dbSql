--DDL
/*synonym : ���Ǿ�
1.��ü ��Ī�� �ο�
 ==> �̸��� �����ϰ� ǥ��
 
Melgoon ����ڰ� �ڽ��� ���̺� emp���̺��� ����ؼ� ���� v_emp view
hr ����ڰ� ����� �� �ְ� �� ������ �ο�

v_emp : �ΰ��� ���� sal, comm �� ������ view
hr ����� v_emp�� ����ϱ� ���� ������ ���� �ۼ�

SELECT * FROM Melgoon.v_emp; --

hr ��������
synonym Melgoon.v_emp ==> v_emp //synonym�� ����ϸ� ��ɾ ���������� ��� ���� ���̺����� �� �� ����
v_emp == Melgoon.v_emp

SELECT *
FROM v_emp;

1.sem �������� v_emp�� hr �������� ��ȸ�� �� �ֵ��� ��ȸ���� �ο�

GRANT SELECT ON v_emp TO hr; ( v_emp�� hr ����ڿ��� ��ȸ�� ������ �ο�)*/
GRANT SELECT ON v_emp TO hr;

/*2.hr ���� v_emp ��ȸ�ϴ°� ���� ( ���� 1������ �޾ұ� ������)
���� �ش� ��ü�� �����ڸ� ��� : sem.v_emp
�����Ѱ� sem.v_emp ==> v_emp ����ϰ� ���� ��Ȳ
synonym ����

CREATE SYNONYM �ó���̸�(��ü�̸�) FOR �� ��ü��;

SYNONYM ����
DROP SYNONYM �ó���̸�;

--DCL(GRANT / REVOKE)
���� ����
1.�ý��� ���� : TABLE�� ����, VIEW ���� ����... GRANT CONNECT TO Melgoon;
2.��ü ���� : Ư�� ��ü�� ���� SELECT,UPDATE,INSERT,DELETE.... GRANT SELECT ON ��ü�� TO hr;

ROLE : ������ ��Ƴ��� ����
����ں��� ���� ������ �ο��ϰ� �Ǹ� ������ �δ�
Ư�� ROLE�� ������ �ο��ϰ� �ش� ROLE ����ڿ��� �ο�
�ش� ROLE�� �����ϰ� �Ǹ� ROLE�� ���� �ִ� ��� ����ڿ��� ����

���� �ο�/ȸ��
�ý��� ���� : GRANT �����̸� TO ����� | ROLE; -- �ο�
            REVOKE �����̸� FROM ����� | ROLE; -- ȸ��
            
��ü ���� : GRANT �����̸� ON ��ü�� TO ����� | ROLE
        REVOKE �����̸� ON ��ü�� FROM ����� | ROLE;
        
        
��Ű�� : ��ü���� ����

���̺� �����̽�, ����� ����

role : ���ѵ��� ����

--DATA dictionary : ����ڰ� �������� �ʰ�, dbms�� ��ü������ �����ϴ� �ý��� ������ ���� view

data dictionary ���ξ�
1.USER : �ش� ����ڰ� ������ ��ü
2.ALL : �ش� ����ڰ� ������ ��ü + �ٸ� ����ڷ� ���� ������ �ο����� ��ü
3.DBA : ��� ������� ��ü (�Ϲ� ����ڴ� ��� �Ұ�)

*V$ Ư�� VIEW
*/
SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES;

/*
DICTIONARY ���� Ȯ�� : SYS.DICTIONARY;
*/

SELECT *
FROM DICTIONARY;

/*��ǥ���� dictionary
OBJECTS : ��ü ���� ��ȸ(���̺�, �ε���, VIEW, SYNONYM...)
TABLES : ���̺� ������ ��ȸ
TAB_COLUMNS : ���̺��� �÷� ���I ��ȸ
INDEXES : �ε��� ���� ��ȸ
IND_COLUMNS : �ε��� ���� �÷� ��ȸ
CONSTRAINTS : ���� ���� ��ȸ
CONS_COLUMNS : �������� ���� �÷� ���� ��ȸ
TAB_COMMENTS : ���̺� �ּ�
COL_COMMENTS : ���̺��� �÷� �ּ�
*/
SELECT * 
FROM USER_OBJECTS; -- ����Ŭ ��ü ����

--emp, dept ���̺��� �ε����� �ε��� �÷� ���� ��ȸ
--user_indexes, user_ind_columns join
--���̺��, �ε��� ��, �÷���

SELECT *
FROM USER_INDEXES;

select table_name, index_name, COLUMN_NAME
from user_ind_columns
ORDER BY table_name, index_name, column_position;

/*select A.INDEX_NAME,A.TABLE_NAME
from USER_INDEXES A,USER_IND_COLUMNS B
WHERE USER_INDEXES.INDEX_NAME = USER_IND_COLUMNS.INDEX_NAME;*/

--multiple insert : �ϳ��� insert �������� ���� ���̺� �����͸� �Է��ϴ� DML

SELECT *
FROM dept_test2;

SELECT *
FROM dept_test;

--������ ���� ���� ���̺� ���� �Է��ϴ� multiple insert;
INSERT ALL
    INTO dept_test
    INTO dept_test2
SELECT 98,'���','�߾ӷ�' FROM dual UNION ALL
SELECT 97,'IT','����' FROM dual;
DELETE FROM dept_test WHERE deptno = '97';
DELETE FROM dept_test2 WHERE deptno = '98';
COMMIT;

--���̺� �Է��� �÷��� �����Ͽ� mlitiple insert
ROLLBACK;
INSERT ALL
    INTO dept_test (deptno, loc) VALUES( deptno,loc)
    INTO dept_test2
SELECT 98 deptno,'���' dname,'�߾ӷ�' loc FROM dual UNION ALL
SELECT 97,'IT','����' FROM dual;

--���̺� �Է��� �����͸� ���ǿ� ���� mulitiple insert
/*CASE
    WHEN ���� ��� THEN
END;*/

ROLLBACK;
INSERT ALL--ALL�̱� ������ ���� �����Ͽ� ����
    WHEN deptno = 98 THEN -- 98���̸� ���̺� �Է��ض�
        INTO dept_test (deptno, loc) VALUES( deptno,loc)
        INTO dept_test2
    ELSE --�׿� ���� �Է�
        INTO dept_test2
SELECT 98 deptno,'���' dname,'�߾ӷ�' loc FROM dual UNION ALL
SELECT 97,'IT','����' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

d

--������ �����ϴ� ù��° insert�� �����ϴ� multiple insert

ROLLBACK;

INSERT FIRST -- FIRST�̱� ������ ������ �´� �͸� �Էµȴ�.
    WHEN deptno >= 98 THEN -- 98���� ũ�ų� ���� ��
        INTO dept_test (deptno, loc) VALUES( deptno,loc)
    WHEN deptno >= 97 THEN -- 97���� ũ�ų� ���� ��
        INTO dept_test2
    ELSE 
        INTO dept_test2
SELECT 98 deptno,'���' dname,'�߾ӷ�' loc FROM dual UNION ALL
SELECT 97,'IT','����' FROM dual;



--����Ŭ ��ü : ���̺� �������� ������ ��Ƽ������ ����
--���̺� �̸��� �����ϳ� ���� ������ ���� ����Ŭ ���������� ������ �и��� ������ �����͸� �����ϴ� ��
--dept_test ==> detp_test_20200201

ROLLBACK;

INSERT FIRST -- FIRST�̱� ������ ������ �´� �͸� �Էµȴ�.
    WHEN deptno >= 98 THEN -- 98���� ũ�ų� ���� ��
        INTO dept_test (deptno, loc) VALUES( deptno,loc)
    WHEN deptno >= 97 THEN -- 97���� ũ�ų� ���� ��
        INTO dept_test20200202
    ELSE 
        INTO dept_test2
SELECT 98 deptno,'���' dname,'�߾ӷ�' loc FROM dual UNION ALL
SELECT 97,'IT','����' FROM dual;

/*MERGE : ����
���̺� �����͸� �Է�/���� �Ϸ��� ��
1. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �����ϸ� 
    ==> ������Ʈ
2. ���� �̷��Ϸ��� �ϴ� �����Ͱ� �������� ������
    ==> INSERT
    
    1.SELECT ����
    2-1.SELECT ���� ����� 0 ROW�̸� INSERT
    2-2.SELECT ���� ����� 1 ROW�̸� UPDATE
    
MERGE ������ ����ϰ� �Ǹ� SELECT �� ���� �ʾƵ� �ڵ����� ������ ������ ���� INSERT Ȥ�� UPDATE �����Ѵ�
2���� ������ �ѹ����� �ش�.

--MERGE ����--
merge into ���̺�� [alias](��Ī)
USING (TABLE | VIEW | IN-LINE-VIEW)
ON (��������)
WHEN MATCHED THEN
    UPDATE SET col1 = �÷���, col2 = �÷���2.....
WHEN NOT MATCHED THEN
    INSERT (�÷�1, �÷�2.....)VALUES(�÷���1,�÷���2......); */
    
    SELECT *
    FROM emp_test;
    
    --DELETE emp_test;
    
    --�α׸� �ȳ����. ==> ������ �ȵȴ�. ==> �׽�Ʈ������...
    --TRUNCATE TABLE emp_test; (���� ������ �� ��! ���� �ȵ�!)
    ROLLBACK;
    SELECT *
    FROM emp_test;
    
    
    --emp���̺��� emp_test�� �����Ѵ�. (7469-SMITH)
    INSERT INTO emp_test
    SELECT empno,ename,deptno,'010'
    FROM emp
    WHERE empno=7369;
    
    --�����Ͱ� �� �Է� �Ǿ����� Ȯ��
    SELECT *
    FROM emp_test;
    
    UPDATE emp_test SET ename = 'brown'
    WHERE empno = 7369;
    
    COMMIT;
    
   /* emp���̺��� ��� ������ emp_test���̺�� ����
    emp ���̺��� ���������� emp_test���� �������� ������ insert
    emp ���̺��� �����ϰ� emp_test���� �����ϸ� ename,deptno�� update;*/
    
    --emp���̺� �����ϴ� 14���� �������� emp_test���� �����ϴ� 7369�� ������ 13���� �����Ͱ�
    --emp_test ���̺� �űԷ� �Է��� �ǰ�
    --emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp���̺� �����ϴ� �̸��� SMITH�� ����
    
    MERGE INTO emp_test a
    USING emp b
    ON (a.empno = b.empno)
    WHEN MATCHED THEN
        UPDATE SET a.ename=b.ename, a.deptno = b.deptno
    WHEN NOT MATCHED THEN
        INSERT (empno,ename,deptno) VALUES(b.empno,b.ename,b.deptno);
        
        SELECT *
        FROM emp_test;
        
    --�ش� ���̺� �����Ͱ� ������ insert, ������ update
    --emp_test���̺� ����� 9999���� ����� ������ ���Ӱ� insert ������ update
    --(9999.'brown',10,'010');
    
    INSERT INTO dept_tset VALUES (9999.'brown',10,'010');
    
    UPDATE dept_test SET ename = 'brown' deptno = 10 hp = '010' 
    WHERE empno = 9999;
    
    MERGE INTO emp_test
    USING dual
    ON (empno = 9999)
    WHEN MATCHED THEN
        UPDATE SET ename = ename || '_u',
                    deptno = 10,
                    hp = '010'
        WHEN NOT MATCHED THEN
        INSERT VALUES(9999,'brown',10,'010');
        
        SELECT *
        FROM emp_test;
        
        DESC emp_test;
        
        -- MERGE, WINDOW FUNCTION(�м��Լ�)
        
        --GROUP_AD1
        select deptno,sum(sal)
        from emp
        GROUP BY deptno
        
        UNION ALL -- �ΰ��� select�� ��ĥ �� �ִ�. ��, �÷��� ������ ���ƾ��ϰ�, �� �÷��� ������ Ÿ���� ���ƾ���
        
        select null,sum(sal)
        from emp
        ORDER BY deptno ASC;
        
        /*
        I/O
        ���� �������
        CPU CACHE > RAM >  SSD > HDD > NETWORK
        */
        
    /*REPORT GROUP FUNCTION
    ROLLUP
    CUBE
    GROUPING
    
    ROLLUP 
    ����� : GROUP BY ROLLUP (�÷�1, �÷�2....)
    SUBGROUP�� �ڵ������� ����
    SUBGROUP�� �����ϴ� ��Ģ : ROLLUP�� ����� �÷��� �����ʿ������� �ϳ��� �����ϸ鼭 SUB GROUP�� ����
                            EX : GROUP BY ROLLUP (deptno) ==> ù��° sub group : GROUP BY deptno ==> detpno ���
                                                             �ι�° sub group : GROUP BY NULL ==> ��ü ���� ���
                                                             */
    --GROUP_AD1�� GROUP BY ROLLUP ���� ����Ͽ� �ۼ�;
    SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY ROLLUP (deptno);
    
    
    SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal
    FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    /*GROUP BY job, deptno : ������, �μ��� �޿��� -- ó�� ���
    GROUP BY hob : �������� �޿��� -- �ι�° ���
    GROUP BY :��ü �޿��� -- ������ ���
            */
            
    SELECT job, deptno, GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    SELECT job, deptno,GROUPING(job), GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    --GROUP_AD2(CASE)
    SELECT CASE
        WHEN GROUPING(job) = 1 THEN '�Ѱ�'
        ELSE job
        END job, deptno, GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    --GROUP_AD2(DECODE)
    SELECT DECODE( GROUPING(job),1,'�Ѱ�',
                    0,job) job, deptno, GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    --GROUP_AD2(DECODE)
   SELECT DECODE( GROUPING(job),1,'��',
                    0,job) job,DECODE( GROUPING(deptno),1,'�Ұ�',0,deptno) deptno,
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    /* --GROUP_AD2(CASE)
   SELECT CASE
        WHEN GROUPING(job) = 1 THEN '�Ѱ�'
        ELSE job
        END job, 
        CASE
        WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
        ELSE deptno
        END deptno,
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);*/
    
    ----GROUP_AD2-1(DECODE)
    SELECT DECODE( GROUPING(job),1,'��',
                    0,job) job,DECODE( GROUPING(deptno),1,DECODE(GROUPING(job),1,'��','�Ұ�'),0,deptno) deptno,
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
            
        
        
        
        
        