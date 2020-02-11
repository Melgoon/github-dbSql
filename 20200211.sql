/*�������� Ȯ�� ���
1. tool
2. dictionary view
�������� : USER_CONSTRAINTS
��������-�÷� : USER_CONS_COLUMNS
���������� ��� �÷��� ���õǾ� �ִ��� �� �� ���� ������ ���̺��� ������ �и��Ͽ� ����
1������
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP','DEPT','EMP_TEST','DEPT_TEST');

/*EMP, DEPT PK, FK ������ �������� ����
2.EMP : pk (empno)
3.    fk ( deptno) - dept.deptno (fk ������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� �����ؾ� �Ѵ�.)
    
1.dept : pk (deptno)*/

--2.
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

--���̺�,�÷��ּ� : CICTIONARY Ȯ�� ����
--���̺� �ּ� : USER_TAB_COMMENTS
--�÷� �ּ� : USER_COL_COMMENTS

/*
�ּ�����
���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
�÷� �ּ� : COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�'

emp : ����
dept : �μ�

*/

COMMENT ON TABLE emp is '����';
COMMENT ON TABLE dept IS '�μ�';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP','DEPT');

DEPT	DEPTNO : �μ���ȣ
DEPT	DNAME : �μ���
DEPT	LOC : �μ���ġ
EMP	EMPNO : ������ȣ
EMP	ENAME : �����̸�
EMP	JOB : ������
EMP	MGR : �Ŵ��� ������ȣ
EMP	HIREDATE : �Ի� ����
EMP	SAL : �޿�
EMP	COMM : ������
EMP	DEPTNO : �ҼӺμ���ȣ

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';

COMMENT ON COLUMN emp.empno IS '������ȣ';
COMMENT ON COLUMN emp.ename IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� ������ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';


1.
SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM cycle;
SELECT * FROM daily;


--�ּ� ����
SELECT *
FROM USER_TAB_COMMENTS,USER_COL_COMMENTS
WHERE USER_TAB_COMMENTS.TABLE_NAME = USER_COL_COMMENTS.TABLE_NAME
AND  USER_COL_COMMENTS.TABLE_NAME IN ('CUSTOMER','CYCLE','DAILY','PRODUCT');

/*VIEW = QUERY
TABLE ó�� DBMS�� �̸� �ۼ��� ��ü
==> �ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINEVIEW ==> �̸��� ���� ������ ��Ȱ���� �Ұ�
VIEW�� ���̺��̴� (X)

������
1. ���� ����(Ư�� �÷��� �����ϰ� ������ ����� �����ڿ� ����
2. INLINE-VIEW�� VIEW�� �����Ͽ� ��Ȱ��
    . ���� ���� ����
    
�������
CREATE (OR REPLACE) VIEW ���Ī [ (column1, column2.....)] AS
SUBQUERY;

emp ���̺��� 8���� �÷��� sal, comm �÷��� ������ 6���� �÷��� �����ϴ� v_emp VIEW ����*/

CREATE OR REPLACE VIEW v_emp AS
SELECT empno,ename,job,mgr,hiredate,deptno
FROM emp;

--�ý��� �������� Melgoon �������� VIEW �������� �߰�
GRANT CREATE VIEW TO Melgoon;

--���� �ζ��� ��� �ۼ���
SELECT *
FROM (SELECT empno, ename, job,mgr,hiredate,deptno
FROM emp);

--VIEW ��ü Ȱ��
SELECT *
FROM v_emp;

/*emp���̺��� �μ����� ���� ==> dept ���̺�� ������ ����ϰ� ����
���ε� ����� view�� ���� �س����� �ڵ带 �����ϰ� �ۼ��ϴ°� ����

VIEW : v_emp_dept
dname(�μ���), empno(������ȣ), ename(�����̸�), job(������), hirdate(�Ի�����)
*/
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�ζ��κ�� �ۼ���
SELECT
FROM(SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno);

--VIEW Ȱ���
SELECT *
FROM v_emp_dept;

--SMITH ���� ������ V_EMP_DEPT VIEW �Ǽ� ��ȭ�� Ȯ��

--VIEW�� �������� �����͸� ���� �ʰ�, ������ �������� ���� ����(SQL)�̱� ������
--VIEW���� �����ϴ� ���̺��� �����Ͱ� ������ �Ǹ� VIEW�� ��ȸ ����� ������ �޴´�.

/*SEQUENC : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
CREATE SEQUENCE ������ �̸�
[OPTION....]
����Ģ : SEQ_���̺��*/

--emp ���̺��� ����� ������ ����
CREATE SEQUENCE seq_emp;

/*������ ���� �Լ�
NEXTVAL : ���������� ���� ���� ������ �� ���
CURRVAL : NEXTVAL�� ����ϰ��� ���� �о� ���� ���� ��Ȯ��

������ ������
ROLLBACK�� �ϴ��� NEXTVAL�� ���� ���� ���� �������� �ʴ´�
NEXTVAL�� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����.*/

SELECT seq_emp.NEXTVAL
FROM dual;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'jamse',99,'017');

/*
DDL(INDEX)
�����س��� ���� ���� ã�ư��� ����
���̺��� �Ϻ� �÷��� �������� �����͸� ������ ��ü
���̺��� ROW�� ����Ű�� �ּҸ� ������ �ִ�.(ROWID)
--ROWID�� ���̺��� �ּ�
*/
SELECT ROWID, emp.*
FROM emp;
-- �ּҸ� �˸� �ٷ� ���� ����
SELECT *
FROM EMP
WHERE ROWID = 'AAAE5dAAFAAAACLAAD';
--���ĵ� �ε����� �������� �ش� ROW�� ��ġ�� ������ �˻��Ͽ� ���̺��� ���ϴ� �࿡ ������ ����
--���̺� �����͸� �Է��ϸ� �ε��� ������ ���ŵȴ�.

--�ε����� ������ EMPNO ������ ��ȸ �ϴ� ���
-- emp ���̺��� pk_emp ���������� �����Ͽ� empno�÷����� �ε����� �������� �ʴ� ȯ���� ����

ALTER TABLE emp DROP CONSTRAINT pk_emp;

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/*emp ���̺��� empno �÷����� PK ������ �����ϰ� ������ SQL�� ����
PK : UNIQUE + NOT NULL
    (UNIQUE �ε����� �������ش�)
==> empno �÷����� unique �ε����� ������

�ε����� SQL�� �����ϰ� �Ǹ� �ε����� �������� ��� �ٸ��� �������� Ȯ��
*/

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno); -- �ε��� ����

SELECT rowid, emp.*
FROM emp; -- ���̺��� ������ ����

SELECT empno, rowid
FROM emp
ORDER BY empno;

explain plan for
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/*SELECT ��ȸ�÷��� ���̺� ���ٿ� ��ġ�� ����
SELECT * FROM emp WHERE empno =7782
==>
SELECT * FROM emp WHERE empno = 7782
*/

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/*UNIQUE VS NON-UNIQUE �ε����� ���� Ȯ��
1.PK_EMP ����
2.EMPNO �÷����� NON-UNIQUE �ε��� ����
3.�����ȹ Ȯ��
*/
ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_n_emp_01 ON emp (empno);

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/* emp ���̺� job �÷��� �������� �ϴ� ���ο� non-unique �ε����� ����*/
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

/*���ð����� ����
1. emp ���̺��� ��ü �б�
2. idx_n_emp_01(empno) �ε��� Ȱ��
3. idx_n_emp_02(job) �ε��� Ȱ��*/

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);









    