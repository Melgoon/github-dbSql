1.leaf ���(��)�� � ���������� Ȯ��
2. LEVEL ==> ����Ž���� �׷��� ���� ���� �ʿ��� ��;
3. leaf ������ ���� Ž��, ROWNUM
SELECT LPAD(' ',(LEVEL-1) * 4) || org_cd, total
FROM
(SELECT org_cd, parent_org_cd, SUM(total) total
FROM
(SELECT org_cd, parent_org_cd,no_emp, 
        SUM(no_emp) OVER (PARTITION BY gno ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) total
FROM
(SELECT org_cd, parent_org_cd,lv, ROWNUM rn, lv+ROWNUM gno, no_emp/COUNT(*) OVER (PARTITION BY org_cd) no_emp
FROM
(SELECT no_emp.*, LEVEL lv, CONNECT_BY_ISLEAF leaf
FROM no_emp
    START WITH parent_org_cd IS NULL
        CONNECT BY PRIOR org_cd = parent_org_cd)
    START WITH leaf = 1
        CONNECT BY PRIOR parent_org_cd = org_cd))
    GROUP BY org_cd, parent_org_cd)
    START WITH parent_org_cd IS NULL
        CONNECT BY PRIOR org_cd = parent_org_cd;
        
SELECT *
FROM H_SUM;


DROP TABLE gis_dt;

CTAS
CREATE TABLE gis_dt AS
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-30, 30)) dt,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v1
FROM dual
CONNECT BY LEVEL <= 1000000;

CREATE INDEX idx_n_gis_dt_01 ON gis_dt (dt, v1);

SELECT DROP TABLE gis_dt;
CREATE TABLE gis_dt AS
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-30, 30)) dt,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v1
FROM dual
CONNECT BY LEVEL <= 1000000;

CREATE INDEX idx_n_gis_dt_01 ON gis_dt (dt, v1);

gis_dt�� dt �÷����� 2020�� 2���� �ش��ϴ� ��¥�� �ߺ����� �ʰ� ���Ѵ�. : �ִ� 29���� ��

2020/02/01
2020/02/02
2020/02/03
...
2020/02/29


2020/02/03 ==> 2020/02/03
2020/02/03
2020/02/03

CREATE TABLE gis_dt AS
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-30, 30)) dt,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v1
FROM dual
CONNECT BY LEVEL <= 1000000;

select TO_CHAR(dt, 'YYYY-MM-DD'), COUNT(*) cnt
from gis_dt
WHERE dt BETWEEN TO_DATE('20200201','YYYYMMDD') AND TO_DATE('20200229 23:59:59','YYYYMMDD hh24:mi:ss')
GROUP BY TO_CHAR(dt, 'YYYY-MM-DD')
ORDER BY TO_CHAR(dt, 'YYYY-MM-DD');

SELECT *
FROM
(SELECT TO_DATE('20200201','YYYYMMDD') + (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= 29)a --EXISTS�� ����� �� �ְԲ� �����ۼ�
WHERE EXISTS ( SELECT 'X' FROM gis_dt 
WHERE gis_dt.dt BETWEEN dt AND TO_DATE(To_CHAR(dt, 'YYYYMMDD')|| '235959', 'YYYYMMDDHH24MISS')); --�º��� �������� ����.

PL/SQL ��� ����
DECLARE : ����, ��� ���� (������ �����ϴ�.)
BEGIN : ���� ��� [���� �Ұ�] -���ǹ�, �ݺ���
EXCEPTION : ����ó��(���� ����)
DBMS_OUTPUT.PUT_LINE(msg) : JAVA�� �ý��ƿ��� ���� ������ �Ѵ�.
END;
/

PL/SQL ������
�ߺ� �Ǵ� ������ ���� Ư����
���Կ����ڰ� �Ϲ����� ���α׷��� ���� �ٸ���.
JAVA = 
PL/SQL :=

PL/SQL ��������
JAVA : Ÿ�� ������ ( String str );
PL/SQL : ������ Ÿ�� (deptno NUMBER(2); )

PL/SQL �ڵ� ������ ���� ����� JAVA�� �����ϰ� �����ݷ��� ����Ѵ�.
������� 
JAVA : String str;
PL/SQL : deptno NUMBER(2);

PL/SQL ����� ���� ǥ���ϴ� ���ڿ� : /
SQL�� ���� ���ڿ� : ;
;

Hello World ���;

SET SERVEROUTPUT ON;

DECLARE
    msg VARCHAR2(50);
BEGIN
    msg := 'Hello, World!';
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/

�μ� ���̺��� 10�� �μ��� �μ���ȣ��, �μ��̸��� PL/SQL ������ �����ϰ�
������ ���;
desc dept;

DECLARE 
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' ||  v_dname);
END;
/

;
PL/SQL ���� Ÿ��
�μ� ���̺��� �μ���ȣ, �μ����� ��ȸ�Ͽ� ������ ��� ����
�μ���ȣ, �μ����� Ÿ���� �μ� ���̺� ���ǰ� �Ǿ�����

NUMBER, VARCHAR2 Ÿ���� ���� ����ϴ°� �ƴ϶� �ش� ���̺��� �÷��� Ÿ���� �����ϵ���
���� Ÿ���� ������ �� �ִ�.
v_deptno NUMBER(2) ==> dept.deptno%TYPE;

DECLARE 
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' ||  v_dname);
END;
/

���ν��� ��� ����
�͸� ��(�̸��� ���� ��)
. ������ �Ұ��� �ϴ�.(IN-LINE VIEW VS VIEW)
���ν��� (�̸��� �ִ� ��)
.���� �����ϴ�.
.�̸��� �ִ�.
.���ν����� ������ �� �Լ�ó�� ���ڸ� ���� �� �ִ�.

�Լ� (�̸��� �ִ� ��)
.������ �����ϴ�.
.�̸��� �ִ�.
.���ν����� �ٸ� ���� ���� ���� �ִ�.

���ν��� ����
CREATE OR REPLACE PROCEDURE ���ν����̸� is (IN param, OUT param, IN OUT PARAM)
    ����� (DECLARE���� ������ ����.)
    BEGIN
    EXCEPTION (�ɼ�)
 END;
 /
 
 �μ� ���̺��� 10�� �μ��� �μ���ȣ�� �μ��̸��� PL/SQL ������ �����ϰ�
 DBMS_OUTPUT.PUT_LINE �Լ��� �̿��Ͽ� ȭ�鿡 ����ϴ� printdept ���ν����� ����;
 
 CREATE OR REPLACE PROCEDURE printdept IS
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    BEGIN
        SELECT deptno, dname INTO v_deptno, v_dname
        FROM dept
        WHERE deptno=10;
        
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    END;
/

���ν��� ���� ���
exec ���ν�����(����...);
exec printdept;

printdetp_p ���ڷ� �μ���ȣ�� �޾Ƽ� �ش� �μ���ȣ�� �ش��ϴ� �μ��̸��� ���������� �ֿܼ� ����ϴ� ���ν���;

create or replace PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE) IS
    v_dname dept.dname%TYPE;
    v_loc   dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = p_deptno;

    DBMS_OUTPUT.PUT_LINE(v_dname || ' , ' || v_loc);
END;
/

exec printdept_p(40); 
--() : ���ڿ� ���� �Է������ ���������� ����� �ȴ�.

select *
from emp;

select *
from dept;

CREATE OR REPLACE PROCEDURE printemp(p_empno IN EMP.DEPTNO%TYPE p_deptno IN dept.deptno%TYPE) IS
    v_ename emp.ename%TYPE;
    v_dname dept.DNAME%TYPE;
    
BEGIN
    SELECT ename, dname INTO v_ename, v_dname
    FROM emp,dept
    WHERE deptno = p_deptno AND empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || ' , ' || v_loc);
END;
/

    