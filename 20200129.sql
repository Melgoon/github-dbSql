--fn1
    SELECT SYSDATE - 29 LASTDAY, SYSDATE -34 LASTDAY_BEFORE5, SYSDATE NOW , SYSDATE -3  FROM dual;
    SELECT TO_Date('2019/12/31','yyyy/mm/dd') LASTDAY,TO_Date('2019/12/31','yyyy/mm/dd') -5 LASTDAY_BEFORES,SYSDATE NOW, SYSDATE -3 FROM dual;
    
--DATE : TO_DATE 문자열 -> 날짜(DATE)
--       TO_CHAR 날짜 -> 문자열(날짜 포멧 지정)
-- JAVA에서는 날짜 포맷의 대소문자를 가린다 (MM / mm -> 월,분)
-- 주간일자(1~7) D : 일요일 1, 월요일 2 ....... 토요일 7
-- 주차 IW : ISO표준 - 해당 주의 목요일을 기준으로 주차를 산정
--          2019/12/31 화요일 --> 2020/01/02(목요일) -> 그렇기 때문에 1주차로 산정
SELECT TO_CHAR (SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE,'D'),   -- 오늘은 2020/01/29 (수) ---> 4
       TO_CHAR(SYSDATE, 'IW'),
       TO_CHAR(TO_DATE('2019/12/31','YYYY/MM/DD'), 'IW')
FROM dual;


-- emp 테이블의 hiredate(입사일자) 컬럼의 년월일 시:분:초
SELECT ename,hiredate,
        TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS'),
        TO_CHAR(hiredate + 1, 'YYYY/MM/DD HH24:MI:SS'),
        TO_CHAR(hiredate + 1/24, 'YYYY/MM/DD HH24:MI:SS'),
        --hiredate에 30분을 더하여 TO_CHAR로 표현
        TO_CHAR(hiredate + (1/24/60)*30, 'YYYY/MM/DD HH24:MI:SS')
From emp;

--fn2

SELECT TO_CHAR(SYSDATE , 'YYYY-MM-DD' ) DT_DASH,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
        TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--MONTHS_BETWEEN(DATE, DATE)
--인자로 들어온 두 날짜 사이의 개월수를 리턴
SELECT ename,hiredate,
        MONTHS_BETWEEN(sysdate, hiredate),
        MONTHS_BETWEEN(TO_DATE('2020-01-17','YYYY-MM-DD'), hiredate),469/12
FROM emp
WHERE ename='SMITH';


--ADD_MONTHS(DATE, 정수-가감할 개월수(더하거나 뺄 개월수))
SELECT ADD_MONTHS(SYSDATE, 5), --2020/01/29 --> 2020/06/29
        ADD_MONTHS(SYSDATE, -5) --2020/01/29 --> 2020/08/29
FROM dual;

-- NEXT_DAT(DATE, 주간일자), ex: NEXT_DAY(SYSDATE, 5) --> SYSDATE 이후 처음 등장하는 주간일자 5(목)에 해당하는 일자
--                          sysdate 2020/01/29(수) 이후 처음 등장하는 5(목)요일 -> 2020/010/30(목)

SELECT NEXT_DAY(SYSDATE,5)
FROM dual;

--LAST_DAT(DATE) DATE가 속한 월의 마지막 일자를 리턴
SELECT LAST_DAY(SYSDATE) -- SYSDATE 2020/01/29 ---> 2020/01/31
FROM dual;

-- LAST_DAY를 통해 인자로 들어온 date의 속한 월의 마지막 일자를 구할 수 있는데
-- date의 첫번째 일자는 어떻게 구할까?

SELECT SYSDATE,
        LAST_DAY(SYSDATE),LAST_DAY(ADD_MONTHS(SYSDATE, -1))+1,TO_DATE('01','DD'),TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM dual;

--hiredate 값을 이용하여 해당 월의 첫번째 일자로 표현
SELECT ename, hiredate,TO_DATE(TO_CHAR(hiredate, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM emp;

-- empno는 NUMBER 타입, 인자는 문자열
-- 타입이 맞지 않기 때문에 묵시적 형변환이 일어남
-- 테이블 컬럼의 타입에 맞게 올바른 인자 값을 주는게 중요
SELECT *
FROM emp
WHERE empno='7369';

--hiredate의 경우 DATE 타입, 인자는 문자열로 주어졌기 때문에 묵시적 형변환이 발생
-- 날짜 문자열 보다 날짜 타입으로 명시적 기술하는 것이 좋음
SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7369';

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno)='7369';


-- 오퍼레이션에서 자식 오퍼레이션(ID 1번)이 있을 경우 자식 오퍼레이션부터 읽고 자식 오퍼레이션이 없을 시엔 위에서부터 아래로 읽는다.
SELECT *
FROM table(dbms_xplan.display);

--숫자를 문자열로 변경하는 경우 : 포맷
-- 천단위 구분자
-- 1000 이라는 숫자를
-- 한국 : 1,000.50
-- 독일 : 1.000,50

--emp sal 컬럼(NUMBER 타입)을 포맷팅
-- 9 : 숫자
-- 0 : 강제 자리 맞춤(0으로 표기)
-- L : 통화 단위
SELECT ename, sal, TO_CHAR(sal,'l0,999')
FROM emp;

--NULL에 대한 연산의 결과는 항상 NULL
-- emp 테이블의 sql 칼럼에는 null 데이터가 존재하지 않음 (14건의 데이터에 대해서)
-- emp 테이블의 채ㅡㅡ 칼럼에는 null 데이터가 존재하지 않음 (14건의 데이터에 대해서)
-- sal + comm --> comm인 null인 행에 대해서는 결과 null로 나온다
--요구사항이 comm이 null이면 sal 컬럼의 값만 조회
-- 요구사항이 충족시키지 못한다. -> SW에서는 [결함]

--NVL(타겟,대체값)
-- 타겟의 값이 NULL이면 대체값을 반환하고 타겟의 값이 NULL이 아니면 타겟 값을 반환
-- if( xkrpt == null)
--  return 대체값;
-- else
--  return 타겟;
SELECT ename, sal, NVL(comm, 0), sal+NVL(comm, 0), NVL(sal+comm, 0)
FROM emp;

--NVL2(expr1, expr2, expr3)
--if(expr1 != null)
--         return expr2;
--else
--         resturn expr3;
SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;

--NULLIF(expr1, expr2)
--if(expr1 == expr2)
--      return null;
-- else
--      return exp1;

SELECT ename, sal, comm, NULLIF(sal, 1250) -- sal 1250인 사원은 null을 리턴, 1250이 아닌 사람은 sai를 리턴
FROM emp;

--가변인자
-- COALESCE 인자중에 가장 처음으로 등장하는 NULL이 아닌 인자를 반환
--COALESCE(expr1, expr2....)
--if(expr1 != null)
--      return expr1;
--else
-- return COALESCE(expr2, expr3.....);

--COALESCE(comm, sal) : comm이 null이 아니면 comm
--                      comm이 null이면 sal(단, sal 칼럼의 값이 NULL이 아닐때)
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

--fn4
SELECT empno, ename,mgr, NVL(mgr, 9999) mgr_n,NVL2(mgr,mgr,9999)mgr_n2,COALESCE(mgr,9999)mgr_n3
FROM emp;

--fn5
SELECT userid,usernm,reg_dt,NVL(reg_dt, sysdate)
FROM users
WHERE usernm NOT IN('브라운');

--CONDITION : 조건절
--CASE : JAVA의 if - else if - else
-- CASE
--      WHEN 조건 THEN 리턴값1
--      WHEN 조건2 THEN 리턴값2
--      ELSE 기본값
-- END
-- emp 테이블에서 job 컬럼의 값이 SALESMAN SAL * 1.05 리턴
--                             MANAGER 이면 sal * 1.1 리턴
--                              PRESIDENT이면 SAL * 1.2 리턴
--                              그 밖의 사람들은 SAL을 리턴

SELECT ename, job, sal,
        CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.1
            WHEN job = 'PRESIDENT' THEN sal * 1.2
            ELSE sal
        END bonus_sal
FROM emp;

--DECODE 함수 : CASE절과 유사
--(다른점 CASE 절 : WHEN 절에 조건비교가 자유롭다
--          DECODE 함수 : 하나의 값에 대해서 = 비교만 허용
-- DECODE 함수 : 가변인자(인자의 개수가 상황에 따라서 늘어날 수가 있음)
--DECODE(col|expr, 첫번째 인자와 비교할 값1, 첫번째 인자와 두번째 인자가 같을경우 반환 값, 
--                 첫번째 인자와 비교할 값2, 첫번째 인자와 네번째 인자가 같을 경우 반환 값.....
--option - else 최종적으로 반환할 기본값

SELECT ename, job ,sal,
DECODE(job, 'SALESMAN',SAL*1.05,
            'MANAGAER',SAL*1.1,
            'PRESIDENT',SAL * 1.2, sal) bonus_sal
FROM emp;

-- emp 테이블에서 job 컬럼의 값이 SALESMAN 이면서 SAL가 1400보다 크면 SAL * 1.05 리턴
--                             MANAGER 이면서 SAL가 1400보다 작으면 sal * 1.1 리턴
--                             MANAGER 이면 SAL * 1.1리턴
--                              PRESIDENT이면 SAL * 1.2 리턴
--                              그 밖의 사람들은 SAL을 리턴


--decode, case를 혼용하여 다음 요구사항을 만족하는 쿼리 작성
-- emp 테이블에서 job 컬럼의 값이 SALMESMAN 이면서 sal가 1400보다 크면 SAL * 1.05 리턴
--                             SALMESMAN 이면서 sal가 1400보다 작으면 SAL * 1.1 리턴                                                           
--                             MANAGER 이면 SAL * 1.1 리턴
--                             PRESIDENT이면 SAL * 1.2 리턴
--                             그밖의 사람들은 SAL을 리턴

--- 1.CASE만 이용해서
SELECT ename, job, sal,
        CASE
            WHEN job = 'SALESMAN' OR sal > 1400 THEN sal * 1.05
            WHEN job = 'MANAGER' OR sal < 1400 THEN sal * 1.1
            WHEN job = 'MANAGER' THEN sal * 1.1
            WHEN job = 'PRESIDENT' THEN sal * 1.2
            ELSE sal
        END bonus_sal
FROM emp;

--2.decode를 사용해서
SELECT ename, job ,sal,
DECODE(job, 'SALESMAN',SAL*1.05,
            'MANAGAER',SAL*1.1,
            'PRESIDENT',SAL * 1.2, sal) bonus_sal
FROM emp;
