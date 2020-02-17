--달력만들기

:dt ==> 202002;

/*SELECT dt
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'DD'))

;*/

원본쿼리 1일~말일자;
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
 

1일자가 속한 주의 일요일구하기
마지막일자가 속한 주의 토요일구하기
일수 구하기; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1일자, 말일자가 속한 주차까지 표현한 달력
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
-- 달력
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
        TO_CHAR(TO_DATE(:dt, 'yyyymm') + (LEVEL-1), 'D') d, -- 일수
        TO_CHAR(TO_DATE(:dt, 'yyyymm') + (LEVEL-1), 'iw') iw -- 주차
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'DD'))
GROUP BY DECODE(d,1,iw+1,iw)
ORDER BY iw;

--------------------------------------------------------------------------------------------------------------
1일자가 속한 주의 일요일 구하기
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

기존 : 시작일자 1일, 마지막 날짜 : 해당 월의 마지막 일자;
SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 29;

변경 : 시작일자 : 해당월의 1일자가 속한 주의 일요일
마지막날짜 : 해당 월의 마지막 일자가 속한 주의 토요일
SELECT TO_DATE('20200126','YYYYMMDD') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;


SELECT SYSDATE,LEVEL FROM dual
CONNECT BY LEVEL <= 10;

1.dt (일자) ==> 월, 월단위별 sum(sales) == 월의 수만큼 행이 그룹핑 된다.
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

--계층쿼리
create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

select *
from dept_h;

오라클 계층형 쿼리 문법
SELECT ...
FROM ...
WHERE 
START WITH 조건 : 어떤 행을 시작점으로 삼을지

CONNECT BY 행과 행을 연결하는 기준
            PRIOR : 이미 읽은 행
            " " : 앞으로 읽을 행;
            
하향식 : 상위에서 자식노드로 연결 ( 위 -> 아래);

XX회사(최상위 조직)에서 시작하여 하위 부서로 내려가는 계층 쿼리;

--계층쿼리 실습 h1
SELECT dept_h.*, level , lpad(' ',(level-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
--START WITH deptnm='XX회사'
--START WITN p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;;

--계층쿼리 실습 h2
SELECT LEVEL,deptcd, lpad(' ',(level-1)*4, ' ') || deptnm deptnm,P_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LPAD(' ', 4, '*')
FROM dual;

행과 행의 연결 조건 (PRIOR XX회사 - 3가지 부(디자인부, 정보기획부, 정보시스템부))
PRIOR XX회사.deptcd = 디자인부.p_deptcd
PRIOR 디자인부.deptcd = 디자인팀.p_deptcd
PRIOR XX회사.DEPTCD = 정보기획부.p.deptcd
PRIOR 정보기획부.deptcd = 기획팀.p.deptcd
PRIOR 기획팀.deptcd = 기획파트.p.deptcd
PRIOR XX회사.deptcd = 정보시스템부.p_deptcd (개발 1팀, 개발 2팀)
PRIOR 정보시스템부.p_deptcd = 개발 1팀.p_deptcd
PRIOR 정보시스템부.p_deptcd = 개발 2팀.p_deptcd;

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

/* 오류 괄호 하나 안쳐서 그런거같은데.. 괄호를 다 붙여봐도 오류가 나온다 ㅈㅈ
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
    








