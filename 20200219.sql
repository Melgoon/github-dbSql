SELECT *
    FROM 
    (SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <= 14) a,
 
    (SELECT deptno, COUNT(*) cnt,
    FROM emp
    GROUP BY deptno) b
    WHERE b.cnt >= a.lv
    ORDER BY b.deptno, a.lv; 

위의 쿼리를 분석함수를 사용해서 표현하면....
부서별 급여 랭킹;

SELECT ename,sal,deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

SELECT ename,sal,deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

쿼리 실행 결과 11건
페이징 처리(페이지당 10건의 게시글)
1페이지 : 1~10
2페이지 : 11~20
바인드 변수 : page, :pageSize;

SELECT *
FROM
    (SELECT a.*,ROWNUM rn
    FROM
        (SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
        FROM board_test
            START WITH parent_seq IS NULL
            CONNECT BY PRIOR seq = parent_seq
            ORDER SIBLINGS BY root DESC, seq ASC) a)
            WHERE rn BETWEEN (:page - 1)*:pageSize + 1 AND :page * :pageSize;


rownum으로 페이징 사용함;

SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename FROM emp)
    WHERE rn >=11 AND rn <= 14;
    
    SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename FROM emp)
    WHERE rn BETWEEN  11 AND 20;
    
    
분석함수/window 함수;

분석함수 문법
분석함수명([인자]) OVER([PARTITION BY 컬럼] [ORDER BY 컬럼] [WINDOWING])
PARTITION BY 컬럼 : 해당 컬럼이 같은 ROW끼리 하나의 그룹으로 묶는다.
ORDER BY 컬럼 : PARTITION BY에 의해 묶은 그룹 내에서 ORDER BY 컬럼으로 정렬

ROW_NUMBER(0 OVER (PARTITION BY deptno ORDER BY sal DESC) rank;

순위 관련 분석함수
RANK() : 같은 값을 가질 때 중복 순위를 인정, 후순위는 중복 값만큼 떨어진 값부터 시작
            2등이 2명이면 3등은 없고 4등부터 후순위가 생성된다.
DENSE_RANK() : 같은 값을 가질 때 중복 순위를 인정, 후순위는 중복순위는 다음부터 시작
                2등이 2명이더라도 후순위는 3등부터 시작
ROW_NUMBER() : ROWNUM과 유사, 중복된 값을 허용하지 않음;

부서별, 급여 순위를 3개의 랭킹 관련함수를 적용;
SELECT ename,sal,deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;

mo_ana1 사원 전체 급여 순위를 구하세요.;
분석함수 에서 그룹 : RAPTITION BY  ==> 기술하지 않으면 전체컬럼으로 조회
SELECT COUNT(*)
FROM emp;

SELECT a.*
FROM
(SELECT emp.*,
        RANK() OVER (ORDER BY sal,empno) rank,
        DENSE_RANK() OVER ( ORDER BY sal,empno) sal_dense_rank,
        ROW_NUMBER() OVER ( ORDER BY sal,empno) sal_row_number
FROM emp)a;

no_ana2;

select *
from emp;

select count(*)
from emp;

SELECT empno,ename,emp.deptno,cnt
from emp,
(SELECT deptno, COUNT(*) cnt
    FROM emp
     GROUP BY deptno) dept_cnt
WHERE emp.deptno = dept_cnt.deptno;

통계관련 분석함수 (GROUP 함수에서 제공하는 함수 종류와 동일)
SUM(컬럼)
COUNT(*), COUNT(컬럼)
MIN(컬럼)
MAX(컬럼)
AVG(컬럼)

no_ana2를 분석함수를 사용해서 작성;

SELECT empno, ename, deptno,COUNT (*) OVER (PARTITION BY deptno) cnt
FROM emp;

ana2 window function을 사용하여 모든 사원에 대한 사원번호,사원이름,본인 급여,부서번호와 해당 사원이 속한 부서의 급여 평균을 조회하는 쿼리를 작성;
SELECT empno, ename,sal, deptno,ROUND(AVG(sal) OVER(PARTITION BY deptno),2) avg_sal
FROM emp;

ana3를 분석함수를 사용해서 작성;
SELECT empno, ename,sal, deptno,MAX(sal) OVER(PARTITION BY deptno) MAX_sal
FROM emp;

ana4를 분석함수를 사용해서 작성;
SELECT empno, ename,sal, deptno,MIN(sal) OVER(PARTITION BY deptno) MIN_sal
FROM emp;

급여를 내림차순 정렬하고, 급여가 같을 때는 입사일자가 빠른사람이 높은 우선순위가 되도록 정렬하여
현재 행의 다음 행(LEAD)의 sal 컬럼을 구하는 쿼리를 작성;

SELECT empno,ename,hiredate,sal,LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

ana5;

SELECT empno,ename,hiredate,sal,LAG(sal) OVER(ORDER BY sal DESC, hiredate) LAG_sal
FROM emp;

ana6 모든 사원에 대해, 담당업무별 급여 순위가 1단계 높은 사람(급여가 같을 경우 입사일이 빠른사람이 높은 순위);
select empno,ename,hiredate,job,sal, LAG(sal) OVER(PARTITION BY job ORDER BY SAL DESC) LAG_sal
from emp;

분석함수/window함수 (실습 no_ana3);
select *
from
(select a.*,ROWNUM rn
from
(SELECT empno,ename,sal
FROM EMP
ORDER BY sal)a),

(SELECT sum(sal)
    FROM emp) b
    WHERE emp.sal = emp.sal; 
    
no_ana3을 분석함수를 이용하여 SQL 작성;

SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) comm_sal
FROM emp;

현재 행을 기준으로 이전 한행부터 이후 한행까지 총 3개행의 sal 합계 구하기;

SELECT empno, ename, deptno, sal,
    SUM(sal) OVER(ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

ana7
ORDER BY 기술 후 WINDOWING 절을 기술하지 않을 경우 다음 WINDOWING이 기본 값으로 적용 된다.
RANGE UNBOUNDED PRECEDING (디폴트값)
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW;

SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno) c_sum
FROM emp;


WINDOWING의 RANGE, ROWS비교
RANGE : 논리적인 행의 단위, 같은 값을 가지는 컬럼까지 자신의 행으로 취급
ROWS : 물리적인 행의 단위;

SELECT empno,ename,deptno,sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal range UNBOUNDED PRECEDING) range_,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal) default_
FROM emp;

윈도우 함수 실습
 .no_ana2~3, ana0~7

윈도우 함수
 . 순위 관련
 . 그룹 함수 
 .windowing





