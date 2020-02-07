/*TRUNCATE �׽�Ʈ
1. REDO�α׸� �������� �ʱ� ������ ������ ������ ������ �Ұ��ϴ�
2. DML(SELECT, INSERT, UPDATE, DELETE)�� �ƴ϶� DDL�� �з�(ROLLBACK�� �Ұ�)

�׽�Ʈ �ó�����
EMP ���̺� ���縦 �Ͽ� EMP_COPY��� �̸����� ���̺� ����
EMP_COPY ���̺��� ������� TRUNCATE TABLE EMP_COPY ����

EMP_COPY ���̺��� �����Ͱ� �����ϴ��� (���������� ������ �Ǿ�����) Ȯ��

EMP_COPY ���̺� ����
*/
-- CREATE ==> DDL (ROLLBACK�� �ȵȴ�.)
CREATE TABLE EMP_COPY AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

TRUNCATE TABLE emp_copy;

/*TRUNCATE TABLE ���ɾ�� DDL �̱� ������ ROLLBACK �� �Ұ��ϴ�
ROLLBACK �� SELECT�� �غ��� �����Ͱ� ���� ���� ���� ���� �� �� �ִ�.*/

ROLLBACK;

-- ����ȭ ����

/*DDL : Data Definition Language - ������ ���Ǿ�; 
��ü�� ����, ����, ������ ���
ROLLBACK �Ұ�
�ڵ� COMMIT*/

/* ���̺� ���� 
CREATE TABLE [��Ű����.]���̺���(
    �÷��� �÷�Ÿ�� [DEFAULT �⺻��],�÷���2 �÷�Ÿ��2 [�⺻ �� ����],....
)*/

CREATE TABLE ranger(ranger_no NUMBER,
                    ranger_nm VARCHAR2(50),
                    reg_dt DATE DEFAULT SYSDATE);
                    
INSERT INTO ranger (ranger_no,ranger_nm) VALUES(1, 'brown');

SELECT *
FROM ranger;
COMMIT;
/*���̺� ����
DROP TABLE ���̺���;
ranger ���̺� ����(drop)*/

DROP TABLE ranger;

SELECT *
FROM ranger;

--DDL�� �ѹ� �Ұ�
ROLLBACK;

--���̺��� �ѹ���� ���� ���� Ȯ�� �� �� �ִ�.
SELECT *
FROM ranger;


/* ������ Ÿ��
���ڿ�(varchar2���, char Ÿ�� ��� ����)
varchar2(10) : �������� ���ڿ� 1~4000byte
                �ԷµǴ� ���� �÷� ������� �۾Ƶ� ���� ������ �������� ä���� �ʴ´�.
char(10) : �������� ���ڿ� 1~2000byte
�ش� �÷��� ���ڿ��� 5byte�� �����ϸ� ������ 5byte �������� ä������
            test ==> 'test      '
             'test' != 'test    '
             
����
NUMBER(p,s) : p-��ü�ڸ��� (38) , s-�Ҽ��� �ڸ���
INTEGER ==> NUMBER(38,0)
ranger_no NUMBER => NUMBER(38,0)

��¥
DATE - ���ڿ� �ð� ������ ����
        7BYTE
        
��¥ - DATE
        VARCHAR(8) '20200207'
        �� �ΰ��� Ÿ���� �ϳ��� �����ʹ� 1BYTE�� ����� ���̰� ���� ������ ���� ���� ���� �Ǹ� ������ �� ���� �������, ����� Ÿ�Կ� ���� ������ �ʿ��ϴ�.
        
LOB(Large OBject) - �ִ� 4GB
CLOB - Character Large OBject
        VARCHAR2�� ���� �� ���� �������� ���ڿ�(4000byt �ʰ� ���ڿ�)
        ex) �� �����Ϳ� ������ html �ڵ�
        
BLOB - Byte Large OBject
        ������ �����ͺ��̽��� ���̺����� ������ ��
        
        �Ϲ������� �Խñ� ÷�������� ���̺��� ���� �������� �ʰ� ���� ÷�������� ��ũ�� Ư�� ������ �����ϰ�, �ش� [���]�� ���ڿ��� ����
        
        ������ �ſ� �߿��� ��� : ���� ������� ���Ǽ� - [����]�� ���̺��� ����
        
�������� : �����Ͱ� ���Ἲ�� ��Ű���� �ϱ� ���� ����
1.UNIQUE ���� ����
    �ش� �÷��� ���� �ٸ� ���� �����Ϳ� �ߺ����� �ʵ��� ����
    EX : ����� ���� ����� ���� ���� ����.
    
2.NOT NULL �������� (CHECK ��������)
    �ش� �÷��� ���� �ݵ�� �����ؾ��ϴ� ����
    EX : ��� �÷��� NULL�� ����� ������ ���� ����
        ȸ������ �� �ʼ� �Է»��� (GITHUB - �̸���,�̸�)
        
3.PRIMARY KEY ���� ����
    UNIQUE + NOT NULL
    EX : ����� ���� ����� ���� ���� ����, ����� ���� ����� ���� ���� ����.
    PRIMARY KEY ���� ������ ������ ��� �ش� �÷� UNIQUE INDEX�� �����ȴ�.
    
4.FOREIGN KEY ���� ���� (�������Ἲ)
    �ش� �÷��� �����ϴ� �ٸ� ���̺��� ���� �����ϴ� ���� �־�� �Ѵ�.
    EMP ���̺��� DEPTNO�÷��� DEPT���̺��� DEPTNO�÷��� ����(����)
    EMP ���̺��� DEPTNO �÷����� DEPT ���̺��� �������� �ʴ� �μ���ȣ�� �Էµ� �� ����.
    EX : ���࿡ DEPT ���̺��� �μ���ȣ�� 10,20,30,40���� ���� �� ��� EMP ���̺��� 
            ���ο� ���� �߰� �ϸ鼭 �μ���ȣ ���� 99������ ����� ��� �� �߰��� �����Ѵ�.
            
5.CHECK �������� (���� üũ)
    NOT NULL ���� ���ǵ� CHECK ���࿡ ����
    EMP ���̺��� JOB �÷��� ���� �� �ִ� ���� 'SALESMAN','PRESTDENT','CLRARK'
    
�������� ���� ���
1. ���̺��� �����ϸ鼭 �÷��� ���
2. ���̺��� �����ϸ鼭 �÷� ��� ���Ŀ� ������ ���������� ���
3. ���̺� ������ ������ �߰������� ���������� �߰�

CREATE TABLE ���̺���(
    �÷�1 �÷� Ÿ�� [1.��������],
    �÷�1 �÷� Ÿ�� [1.��������],
    
    [2.TABLE_CONSTRAINT]
);

3. ALTER TABLE emp......*/

-- PRIMARY KEY ���������� �÷� ������ ����(1)
-- dept ���̺��� �����Ͽ� dept_test ���̺��� PRIMARY KEY �������ǰ� �Բ� ����
--�� �� ����� ���̺��� KEY �÷��� �����÷��� ��� ���� �÷��� �Ұ�, ���� �÷��� ���� ����

DESC dept;

CREATE TABLE dept_test(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

INSERT INTO dept_test (deptno) VALUES (99); --���������� ����
INSERT INTO dept_test (deptno) VALUES (99);  -- �ٷ� ���� ������ ���� ���� ���� �����Ͱ� �̹� �����

--�������� �츮�� ���ݱ��� ������ ����� dept ���̺��� deptno �÷����� UNIQUE �����̳� PRIMARY KEY ���� ������ ������ ������
--�Ʒ� �ΰ��� INSERT ������ ���������� ����ȴ�.
INSERT INTO dept (deptno) VALUES (99);
INSERT INTO dept (deptno) VALUES (99);
rollback;

/* �������� Ȯ�� ���
1. TOOL�� ���� Ȯ�� Ȯ���ϰ��� �ϴ� ���̺��� ����
2. dictionary�� ���� Ȯ��(USER_TABLES, USER_CONSTRAINTS)
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT_TEST';

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME='SYS_C007089';

/*
3. �𵨸�(EX: EXERD)���� Ȯ��
�������� ���� ������� ���� ��� ����Ŭ���� ���������̸��� ���Ƿ� �ο� (EX : SYS_C007089)
�������� �������� ������ ���� ��Ģ�� ������ �����ϴ°� ����, � ������ ����
PRIMARY KEY �������� : PK_���̺���
FOREIGNKEY  �������� : FK_������̺���_�������̺���
*/

DROP TABLE dept_test;

select * 
from dept_test;

--�÷� ������ ���������� �����ϸ鼭 �������� �̸��� �ο� CONSTRAINT �������Ǹ� ��������Ÿ��(PRIMARY KEY)

CREATE TABLE dept_test(
    DEPTNO NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

SELECT *
FROM dept_test;

INSERT INTO dept_test (deptno) VALUES(99);
INSERT INTO dept_test (deptno) VALUES(99);

--ORA-00001: unique constraint (MELGOON.SYS_C007089) violated
--ORA-00001: unique constraint (MELGOON.PK_DEPT_TEST) violated

/*
2.���̺� ������ �÷� ��� ���� ������ �������� ���

*/
DROP TABLE dept_test;
CREATE TABLE dept_test(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);
/*NOT NULL �������� �����ϱ�
1.�÷��� ����ϱ�(O)
    �� �÷��� ����ϸ鼭 �������� �̸��� �ο��ϴ°� �Ұ�
*/

DROP TABLE dept_test;

CREATE TABLE dept_test(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14) NOT NULL,
    LOC VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);

/*NOT NULL �������� Ȯ��*/
INSERT INTO dept_test (deptno,dname) VALUES(99,NULL);

--2.���̺� ������ �÷� ��� ���Ŀ� ���� �����߰�

DROP TABLE dept_test;

CREATE TABLE dept_test(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13),
    
    CONSTRAINT NM_dept_test_dname CHECK (deptno IS NOT NULL)
);

/* UNIQUE ���� : �ش� �÷��� �ߺ��Ǵ� ���� ������ ���� ����, �� NULL�� �Է��� �����ϴ�. 
PRIMARY KEY = UNIQUE + NOT NULL 
*/ 
--1. ���̺� ������ �÷� ���� UNIQUE ��������
--dname �÷��� UNIQUE ��������
DROP TABLE dept_test;

CREATE TABLE dept_test(
    DEPTNO NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    DNAME VARCHAR2(14) UNIQUE,
    LOC VARCHAR2(13)
);

--dept_test ���̺��� dname �÷��� ������ unique ���������� Ȯ��
INSERT INTO dept_test VALUES(98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--2. ���̺� ������ �÷��� �������� ���, �������� �̸� �ο�

DROP TABLE dept_test;

CREATE TABLE dept_test(
    DEPTNO NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    DNAME VARCHAR2(14) CONSTRAINT UK_dept_test_dname UNIQUE,
    LOC VARCHAR2(13)
);

--dept_test ���̺��� dname �÷��� ������ unique ���������� Ȯ��
INSERT INTO dept_test VALUES(98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

/*ORA-00001: unique constraint (MELGOON.SYS_C007089) violated
ORA-00001: unique constraint (MELGOON.UK_DEPT_TEST_DNAME) violated*/

--2.���̺� ������ �÷� ��� ���� �������� ���� - ���� �÷�(deptno-dname) (unique)
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT UK_dept_test_deptno_dname UNIQUE (deptno, dname)
    );
    
--���� �÷��� ���� UNIQUE ���� Ȯ�� ( DEPTNO, DNAME);
INSERT INTO dept_test VALUES(98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(98, 'ddit', '����');

/*FOREIGN KEY ��������
�����ϴ� ���̺��� �÷��� �����ϴ� ���� ��� ���̺��� �÷��� �Է��� �� �ֵ��� ����
    EX : emp ���̺��� deptno �÷��� ���� �Է��� ��, dept ���̺��� deptno �÷����� �����ϴ� �μ���ȣ�� �Է��� �� �ֵ��� ����
        �������� �ʴ� �μ���ȣ�� emp ���̺����� ������� ���ϰԲ� ���� */
        
/*  1.dept_test ���̺� ����
    2. emp_test ���̺� ����
        . emp_test ���̺� ������ deptno �÷����� dept.deptno �÷��� �����ϵ��� FK�� ���� */
        
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)
);

DROP TABLE emp_test;

DESC emp;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno) ,
    
    CONSTRAINT PK_EMP_TEST PRIMARY KEY (empno)
);

/* ������ �Է¼���
emp_test ���̺��� �����͸� �Է��ϴ°� �����Ѱ�??
    .���ݻ�Ȳ(dept_test, emp_test ���̺��� ��� ����-�����Ͱ� �������� ������)
*/
INSERT INTO emp_tset VALUES(9999,'brown', NULL); --FK�� ������ �÷��� NULL�� ���
INSERT INTO emp_test VALUES(9998, 'sally',10);  --10�� �μ��� DEPT_TEST ���̺��� �������� �ʾƼ� ����

--dept_test ���̺��� �����͸� �غ�
INSERT INTO dept_test VALUES (99, 'ddit','daejeon');
INSERT INTO emp_test VALUES(9998,'sally',10); -- 10�� �μ��� dept_test�� �������� �����Ƿ� ����
INSERT INTO emp_test VALUES(9998,'sally',99); -- 99�� �μ��� dept_test �� �����ϹǷ� ���� ����

--���̺��� ������ �÷� ��� ����, FOREIGN KEY �������� ����

DROP TABLE emp_test; -- ������ �ϰ� �ִ� ���̺����� ������ �ؾ� ������ ��
DROP TABLE dept_test; -- ������ ���ϰ� �ֱ� ������ ������ �ϰ� �ִ� ���̺����� �����ؾ� ������ ����

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)
);

INSERT INTO dept_test VALUES(99,'ddit','daejeon');

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
);

INSERT INTO emp_test VALUES(9999, 'brown', 10); -- dept_test ���̺��� 10�� �μ��� �������� �ʾ� ����
INSERT INTO emp_test VALUES(9999, 'brown', 99); -- dept_test ���̺��� 99�� �μ��� �����ϹǷ� ���� ����
    
    --exRED Űǥ�ð� �ִ� ���� �� Űǥ�ð� ���� ���� �� 