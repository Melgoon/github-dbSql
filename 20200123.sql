--emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� ( �� �����ڴ� �񱳿����ڸ� ����Ѵ�.)
-- WHERE ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
-- SQL�� ������ ������ ���� �ִ�.(���� ������ ����.)
-- ���� : Ű�� 185cm �̻��̰� �����԰� 70kg �̻��� ������� ����
--    --> �����԰� 70kg �̻��̰� Ű�� 185cm �̻��� ������� ����
-- ������ Ư¡ : ���տ��� ������ ����.
-- (1, 5, 10) --> (10, 5, 1) : �� ������ ���� �����ϴ�.
-- ���̺��� ������ ������� ����
-- SELECT ����� ������ �ٸ����� ���� �����ϸ� �������� ����
-- > ���ı�� ����(ORDER BY)
--      �߻��� ����� ���� --> ����x
SELECT ename,hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD') AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');

SELECT ename,hiredate
FROM emp
WHERE hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD') AND hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD');



--IN ������
-- Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ��
-- �μ���ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ
SELECT empno, ename, deptno
FROM emp
WHERE deptno >= 10 AND deptno <= 20; -- �μ���ȣ

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10,20);

--IN �����ڸ� ������� �ʰ� OR ������ ���
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR    deptno = 20;


-- AND / OR
-- ���� ��� ( ' ' �̱� �����̼��� ����� ���ڿ��� �ν���)

SELECT *
FROM users
WHERE 2 = 2;

-- emp���̺��� ����̸��� SMITH, JONES �� ������ ��ȸ (empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'JONES';

SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH','JONES');

-- users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ �Ͻÿ�. (IN ������ ���)
SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN ('brown','cony','sally');

SELECT *
FROM users;

--���ڿ� ��Ī ������ : LIKE, %, _
-- ������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
-- �̸��� BR�� �����ϴ� ����� ��ȸ
-- �̸��� R ���ڿ��� ���� ����� ��ȸ

-- ��� �̸��� S�� �����ϴ� ��� ��ȸ
-- SMNITH, SMILE, SKC
-- % � ���ڿ�(�ѱ���, ���ڰ� ���� ���� �ְ�, ���� ���ڿ��� �� ���� �ִ�.)

SELECT *
FROM emp
WHERE ename LIKE 'S%';

-- ���� ���� ������ ���� ��Ī
-- _(�����) ��Ȯ�� �ѹ���
SELECT *
FROM emp
WHERE ename LIKE 'S____';

-- emp ���̺��� ��� �̸��� S�� ���� ��� ��ȸ
-- ename LIKE '%S%'

SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where4
-- member ���̺��� ȸ���� ���� [��]���� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.

SELECT *
FROM member;

SELECT mem_id,mem_name
FROM member
WHERE mem_name LIKE '��%';

-- member ���̺��� ȸ���� �̸��� ����[��]�� ���� ��� ����� MEM_ID, MEM_NAME�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.

SELECT mem_id,mem_name
FROM member
WHERE mem_name LIKE '%��%';

-- null �� ���� (IS)
-- comm �÷��� ���� null�� �����͸� ��ȸ WHERE comm = null)
SELECT *
FROM emp
WHERE comm = null;

SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;

-- emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�.

SELECT *
FROM emp
WHERE comm >=0; -- 0���� ũ�ų� ���� ���� ��ȸ

SELECT *
FROM emp
WHERE comm IS NOT null; -- NOT�� ����Ͽ� �ΰ��� ���� �ڷḦ ��ȸ

-- ����� �����ڰ� 7698, 7839 �׸��� null�� �ƴ� ������ ��ȸ
-- NOT IN �����ڿ����� NULL ���� ���� ��Ű�� �ȵȴ�.
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,NULL);

-- --> �ùٸ� ���ǹ�
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839)
AND mgr IS NOT NULL;

-- where7
SELECT *
FROM emp
WHERE job IN 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

-- where8
SELECT *
FROM emp
WHERE deptno > 10 AND deptno <= 30 AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

-- where9
SELECT *
FROM emp
WHERE deptno NOT IN(10) AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

-- where10
SELECT *
FROM emp
WHERE deptno IN(20,30) AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

-- where11
SELECT *
FROM emp
WHERE JOB IN('SALESMAN') OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');

-- where12
SELECT *
FROM emp
WHERE JOB IN('SALESMAN') OR  empno LIKE '78__';

-- where13
SELECT *
FROM emp
WHERE JOB IN('SALESMAN') OR empno >= 7800 and empno <= 7899;

--������ �켱����
-- *,/ �����ڰ� +,- ���� �켱������ ����.
-- 1+5*2 = 11 -> (1+5)*2 x  5�� ���� 2�� ���ϰ� ������ +1�� �ؾ���
-- �켱���� ���� : ()
-- AND > OR OR�� �켱������ �� ����

-- emp ���̺��� ��� �̸��� SMITH �̰ų� ��� �̸��� ALLEN �̸鼭 �������� SALESMAN�� ��� ��ȸ

SELECT *
FROM emp
WHERE ename Like 'SMITH' OR ename Like 'ALLEN' AND JOB IN('SALESMAN');

SELECT *
FROM emp
WHERE ename Like 'SMITH' OR (ename Like 'ALLEN' AND JOB IN('SALESMAN'));

-- ��� �̸��� SMITH �̰ų� ALLEN �̸鼭 �������� SALESMAN�� ��� ��ȸ

SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';


SELECT *
FROM emp
WHERE ename IN ('SMITH','ALLEN') AND JOB IN('SALESMAN');


-- where14

SELECT *
FROM emp
WHERE JOB IN('SALESMAN') OR empno >= 7800 and empno <= 7899 AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD') ;

--����
-- SELECT *
-- FROM table
-- [WHERE]
-- ORDER BY {Į��|��Ī|�÷��ε��� [ASC | DESC], ....}

-- emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ �ϼ���.

SELECT *
FROM emp
ORDER BY ename ASC;

-- emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ �ϼ���.

SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE (�����ϴ�)
--ORDER BY ename DESC; -- DESC : DESCRNDING (����)

-- emp ���̺��� ��� ������ ename�÷����� ��������, ename ���� ���� ��� mgr Į������ �������� �����ϴ� ������ �ۼ��ϼ���.
SELECT *
FROM emp
ORDER BY ename DESC, mgr ASC;

--���Ľ� ��Ī�� ���
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;
--�÷� �ε����� ����
-- java array(�迭) index[0]���� ���� SQL�� ��� colomn index : 1���� ����
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;

--order by 1 �ǽ�
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY LOC DESC;

--order by 2 �ǽ�
SELECT *
FROM emp
WHERE comm IS NOT null AND comm != 0;

SELECT *
FROM emp
WHERE comm > 0 ORDER BY comm DESC, empno ASC;

--order by 3 �ǽ�
SELECT *
FROM emp
WHERE job NOT IN ('PRESIDENT')
ORDER BY job, empno DESC;