-- LPROD ���̺��� ��� �÷��� �ڷ� ��ȸ
SELECT *
FROM lprod;

--buyer ���̺��� buyer_id,buyer_name �÷��� ��ȸ

SELECT buyer_id, buyer_name
FROM buyer;

-- cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ�

SELECT *
FROM cart;

-- member ���̺��� mem_id,mem_pass,mem_name �÷��� ��ȸ

SELECT mem_id, mem_pass, mem_name
FROM member;

-- users ���̺� ��ȸ
SELECT *
FROM users;

-- ���̺��� � �÷��� �ִ��� Ȯ���ϴ� ���
-- 1. SELECT * 2. TOOL�� ���(�����-TABLES)
-- 3. DESC ���̺�� (DESC-DESCRIBE)

DESC users;

-- users ���̺��� userid, usernm, rog_dt �÷��� ��ȸ�ϴ� sql�� �ۼ�
-- ��¥ ���� (reg_dt �÷��� data������ ���� �� �ִ� Ÿ��)
-- SQL ��¥ �÷� + (���ϱ� ����)
-- �������� ��Ģ������ �ƴ� �͵� (5+5)
-- String h = "hello";
-- String w = "world";
-- String hw = h+w; -- �ڹٿ����� �� ���ڿ��� ����
-- SQL���� ���ǵ� ��¥ ���� : ��¥ + ���� = ��¥���� ������ ���ڷ� ����Ͽ� ���Ѵ�. (2019/01/28 + 5 = 2019/02/01)
-- reg_dt : ������� �÷�
-- null : ���� �𸣴� ����
-- null�� ���� ���� ����� �׻� null
SELECT userid u_id, usernm, reg_dt, reg_dt + 5 AS reg_dt_after_5day
FROM users;
DESC users;
-- prod ���̺��� prod_id,prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� ( ��, prod_id -> id, prod_name -> name ���� �÷��� ��Ī �����Ͽ� ��ȸ�� ��)
SELECT prod_id id, prod_name name
FROM prod;
-- lprod ���̺��� prod_gu,prod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� ( ��, lprod_gu -> gu, lprod_nm -> nm ���� �÷��� ��Ī �����Ͽ� ��ȸ�� ��)
SELECT lprod_gu gu,lprod_nm nm
FROM lprod;
-- buyer ���̺��� buyer_id,buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� ( ��, buyer_id -> ���̾���̵�, buyer_name -> �̸� ���� �÷��� ��Ī �����Ͽ� ��ȸ�� ��)
SELECT buyer_id AS ���̾���̵�,buyer_name AS �̸�
FROM buyer;

-- ���ڿ� ����
-- �ڹ� ���� ���ڿ� ���� : + ("Hello" + "world")
-- SQL������ : || ('Hello' || 'world')
-- SQL������ : concat('Hello', 'world')
-- userid, usernm �÷��� ����, ��Ī id_name
SELECT usernm || usernm AS id_name,
        CONCAT(userid, usernm) concat_id_name
FROM users;

-- ����, ���
-- int a = 5; String msg = "Hello, World";
-- System.out.println(msg); ������ �̿��� ���
-- System.out.println("Hellog, World"); ����� �̿��� ���
-- SQL������ ������ ����(�÷��� ����� ����,pl/sql ���� ������ ����)
-- SQL������ ���ڿ� ����� �̱� �����̼����� ǥ��
-- "Hello, World" --> 'Hello, World'

-- ���ڿ� ����� �÷����� ����
-- user id : brown
-- user id : cony
SELECT 'userid : ' || userid AS "use rid"
FROM users;

SELECT 'SELECT * FROM ' || TABLE_NAME || ';' AS QUERY 
FROM USER_TABLES;

SELECT *
FROM USER_TABLES;

-- ]] --> CONCAT

SELECT CONCAT(CONCAT('SELECT * FROM ', TABLE_NAME), ';' )QUERY
FROM USER_TABLES;

-- int a = 5; // �Ҵ�, ���� ������

-- if( a == 5 ) ( a�� ���� 5���� ��)
-- sql������ ������ ������ ����(PL/SQL)
-- sql = // equal

-- users�� ���̺��� ��� �࿡ ���ؼ� ��ȸ
-- users���� 5���� �����Ͱ� ����

SELECT *
FROM users;

--WHERE �� : ���̺��� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ
--EX : userid �÷��� ���� brown�� �ุ ��ȸ
-- brown, 'brown' ����
-- �÷�, ���ڿ� ���
SELECT *
FROM users
WHERE userid = 'brown';

-- userid�� brown�� �ƴ� �ุ ��ȸ

SELECT *
FROM users
WHERE userid != 'brown';

-- emp ���̺� �����ϴ� �÷��� Ȯ�� �غ�����.

SELECT *
FROM emp;

-- emp ���̺��� ename �÷� ���� jones�� �ุ ��ȸ
-- SQL KEY WORD�� ��ҹ��ڸ� ������ ������ �÷��� ���̳� ���ڿ� ����� ��ҹ��ڸ� �����ϱ� ������ 'JONES','Jones'�� ���� �ٸ� ����̴�.

SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --emp
DESC emp;

-- 5 > 10 -- FALSE
-- 5 > 5 -- FALSE
-- 5 >= 5 -- TRUE

--emp ���̺��� deptno (�μ���ȣ)�� 30���� ũ�ų� ����鸸 ��ȸ

SELECT * 
FROM emp 
WHERE deptno >= 30;
-- ���ڿ� : '���ڿ�'
-- ���� : 50
-- ��¥ : ??? --> �Լ��� ���ڿ��� �����Ͽ� ǥ��
-- ���ڿ��� �̿��Ͽ� ǥ�� ����(�������� ����)
-- �������� ��¥ ǥ�� ���
-- �ѱ� : �⵵4�ڸ�-��2�ڸ�-����2�ڸ�
-- �̱� : ��2�ڸ�-����2�ڸ�-�⵵4�ڸ�

-- �Ի� ���ڰ� 1980�� 12�� 17�� ������ ��ȸ
SELECT * 
FROM emp 
WHERE hiredate = '80/12/17';
-- TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ�
-- TO_DATE(��¥���� ���ڿ�, ù��° ������ ����)
-- '1980/02/03' 
SELECT * 
FROM emp
WHERE hiredate = TO_DATE('19801217','YYYYMMDD');

SELECT * 
FROM emp
WHERE hiredate = TO_DATE('1980/12/17','YYYY/MM/DD');

-- ��������
-- sal �÷��� ���� 1000���� 2000������ ���
SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000;

-- ���� �����ڸ� �ε�ȣ ��ſ� BETWEEN AND �����ڷ� ��ü
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� ( �� �����ڴ� BETWEEN�� ����Ѵ�.)
SELECT ename,hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD') AND TO_DATE('1983/01/01','YYYY/MM/DD');

--emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� ( �� �����ڴ� �񱳿����ڸ� ����Ѵ�.)
SELECT ename,hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD') AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');

