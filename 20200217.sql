--�޷¸����

:dt ==> 202002;

/*SELECT dt
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'DD'))

;*/

�������� 1��~������;
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  TO_CHAR(last_day(to_date(:dt,'yyyymm')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 

1���ڰ� ���� ���� �Ͽ��ϱ��ϱ�
���������ڰ� ���� ���� ����ϱ��ϱ�
�ϼ� ���ϱ�; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1����, �����ڰ� ���� �������� ǥ���� �޷�
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
----------------------------------------------------------------------------------------------------
-- �޷�
SELECT DECODE(d,1,iw+1,iw)iw,
        MIN(DECODE(d, 1, dt)) sun,
        MIN(DECODE(d, 2, dt)) mon,
        MIN(DECODE(d, 3, dt)) tue,
        MIN(DECODE(d, 4, dt)) wed,
        MIN(DECODE(d, 5, dt)) tur,
        MIN(DECODE(d, 6, dt)) fri,
        MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (LEVEL-1) dt, 
        TO_CHAR(TO_DATE(:dt, 'yyyymm') + (LEVEL-1), 'D') d, -- �ϼ�
        TO_CHAR(TO_DATE(:dt, 'yyyymm') + (LEVEL-1), 'iw') iw -- ����
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'DD'))
GROUP BY DECODE(d,1,iw+1,iw)
ORDER BY iw;

--------------------------------------------------------------------------------------------------------------
1���ڰ� ���� ���� �Ͽ��� ���ϱ�
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);

--------------------------------------------------------------------------------------------------
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);

--------------------------------------------------------------------------------------------------

SELECT TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7 - TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + ( 7 - TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
        -( TO_DATE(:dt, 'yyyymm') - (TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;

--------------------------------------------------------------------------------------------------------------
SELECT 
    dt - (d-1),
    NEXT_DAY(dt2, 7)
FROM
(SELECT TO_DATE(:dt || '01', 'YYYYMM') dt,
        TO_CHAR(TO_DATE(:dt || '01', 'YYYYMM'), 'D') d,
        
        LAST_DAY(TO_DATE(:dt, 'YYYMM')) dt2,
        TO_CHAR(LAST_DAY(TO_DATE(:dt, 'YYYYMM')), 'D') d2
FROM dual);

���� : �������� 1��, ������ ��¥ : �ش� ���� ������ ����;
SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 29;

���� : �������� : �ش���� 1���ڰ� ���� ���� �Ͽ���
��������¥ : �ش� ���� ������ ���ڰ� ���� ���� �����
SELECT TO_DATE('20200126','YYYYMMDD') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;


SELECT SYSDATE,LEVEL FROM dual
CONNECT BY LEVEL <= 10;

1.dt (����) ==> ��, �������� sum(sales) == ���� ����ŭ ���� �׷��� �ȴ�.
SELECT NVL(SUM(jan), 0) jan, NVL(SUM(feb), 0) feb, NVL(SUM(mar), 0) mar,
        NVL(SUM(apr), 0 )apr, NVL(SUM(may), 0) may, NVL(SUM(jun), 0 )jun
FROM
(SELECT DECODE(TO_CHAR(dt, 'MM'), '01', SUM(SALES)) JAN,
        DECODE(TO_CHAR(dt, 'MM'), '02', SUM(SALES)) FEB,
        DECODE(TO_CHAR(dt, 'MM'), '03', SUM(SALES)) MAR,
        DECODE(TO_CHAR(dt, 'MM'), '04', SUM(SALES)) APR,
        DECODE(TO_CHAR(dt, 'MM'), '05', SUM(SALES)) MAY,
        DECODE(TO_CHAR(dt, 'MM'), '06', SUM(SALES)) JUN
FROM sales
GROUP BY TO_CHAR(dt, 'MM'));

--��������
create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

select *
from dept_h;

����Ŭ ������ ���� ����
SELECT ...
FROM ...
WHERE 
START WITH ���� : � ���� ���������� ������

CONNECT BY ��� ���� �����ϴ� ����
            PRIOR : �̹� ���� ��
            " " : ������ ���� ��;
            
����� : �������� �ڽĳ��� ���� ( �� -> �Ʒ�);

XXȸ��(�ֻ��� ����)���� �����Ͽ� ���� �μ��� �������� ���� ����;

--�������� �ǽ� h1
SELECT dept_h.*, level , lpad(' ',(level-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
--START WITH deptnm='XXȸ��'
--START WITN p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;;

--�������� �ǽ� h2
SELECT LEVEL,deptcd, lpad(' ',(level-1)*4, ' ') || deptnm deptnm,P_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LPAD(' ', 4, '*')
FROM dual;

��� ���� ���� ���� (PRIOR XXȸ�� - 3���� ��(�����κ�, ������ȹ��, �����ý��ۺ�))
PRIOR XXȸ��.deptcd = �����κ�.p_deptcd
PRIOR �����κ�.deptcd = ��������.p_deptcd
PRIOR XXȸ��.DEPTCD = ������ȹ��.p.deptcd
PRIOR ������ȹ��.deptcd = ��ȹ��.p.deptcd
PRIOR ��ȹ��.deptcd = ��ȹ��Ʈ.p.deptcd
PRIOR XXȸ��.deptcd = �����ý��ۺ�.p_deptcd (���� 1��, ���� 2��)
PRIOR �����ý��ۺ�.p_deptcd = ���� 1��.p_deptcd
PRIOR �����ý��ۺ�.p_deptcd = ���� 2��.p_deptcd;

SELECT SYSDATE, LEVEL FROM dual CONNECT BY LEVEL <= 10;
SELECT SYSDATE + LEVEL dt FROM dual CONNECT BY LEVEL <= 10;

SELECT To_date('20200201','yyyymmdd') + LEVEL - 1 dt,
        To_char(To_date('20200201','yyyymmdd') + LEVEL - 1, 'day') day,
        To_char(To_date('20200201','yyyymmdd') + LEVEL - 1, 'w') w,
        To_char(To_date('20200201','yyyymmdd') + LEVEL - 1, 'ww') ww,
        To_char(To_date('20200201','yyyymmdd') + LEVEL - 1, 'iw') iw
        FROM dual
        CONNECT BY LEVEL <= 20;
        
SELECT To_date('20200101','yyyymmdd') + LEVEL -1 dt,
        To_char(To_date('20190101','yyyymmdd') + LEVEL - 1, 'day') day,
        To_char(To_date('20190101','yyyymmdd') + LEVEL -1, 'd') d
        FROM dual
        CONNECT BY LEVEL <= 20;
        
SELECT To_date('201905','yyyymm') + ( LEVEL -1) dt
FROM dual
CONNECT BY LEVEL <= Last_day(To_date('201905','yyyymm')) - To_date('201905','yyyymm') + 1;

/* ���� ��ȣ �ϳ� ���ļ� �׷��Ű�����.. ��ȣ�� �� �ٿ����� ������ ���´� ����
SELECT dt,To_char(dt, 'iw') w,To_char(dt, 'd') d,To_char(dt, 'day') day
FROM (SELECT To_date('201905', 'yyyymm') + (LEVEL - 1 ) dt
        FROM dual
        CONNECT BY LEVEL <= Last_day(To_date('201905', 'yyyymm') To_date('201905','yyyymm')+ 1)); */
        
SELECT dt, w, DECODE(d,2,dt,'') mon,DECODE(d,3,dt,'') tue,DECODE(d,4,dt,'') wed,
                DECODE(d,5,dt,'') thu,DECODE(d,6,dt,'') fri,DECODE(d,7,dt,'') sat,DECODE(d,1,dt,'') sun
        FROM (
        SELECT dt, to_char(dt, 'iw') w,to_char(dt, 'd') d
        FROM(SELECT to_date('201905','yyyymm') + (LEVEL-1) dt 
        FROM dual CONNECT BY LEVEL 
        <= Last_day(to_date('201905','yyyymm')) - to_date('201905','yyyymm') + 1));
        
        
        SELECT Min(Decode(d, 1, dt)) SUN,Min(Decode(d, 2, dt)) MON,Min(Decode(d, 3, dt)) TUE,
                Min(Decode(d, 4, dt)) WED,Min(Decode(d, 5, dt)) THU,Min(Decode(d, 6, dt)) FRI,
                Min(Decode(d, 7, dt)) SAT
        FROM (SELECT To_date(:YYYYMM, 'YYYYMM') + (LEVEL - 1) dt,
                    To_char(To_date(:YYYYMM, 'YYYYMM') + (LEVEL - 1), 'd') d,
                    To_date(:YYYYMM, 'YYYYMM') + (LEVEL - 1 ) - To_char(
                    To_date(:YYYYMM, 'YYYYMM') + (LEVEL - 1), 'd') + 1 f_sun
                    FROM dual
                    CONNECT BY LEVEL <= To_char(Last_day(To_date(:YYYYMM, 'YYYYMM')), 'DD'))
                    GROUP BY f_sun
                    ORDER BY f_sun;
    








