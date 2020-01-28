--ORDER BY 4
SELECT *
FROM emp
WHERE DEPTNO IN(10,30) AND sal > 1500
ORDER BY ENAME DESC;

-- ROWNOM :행번호를 나타내는 컬럼
SELECT ROWNUM, empno, ename
FROM emp
WHERE deptno IN(10,30)
AND sal > 1500;

-- ROWNUM을 WHERE절에서도 사용가능
-- 동작하는 것 : = ROWNUM = 1, ROWNUM <= 2 -- ROWNUM, ROWNUM <= N
-- 동작하지 않는 것 : ROWNUM =2, ROWNUM >= 2 --> ROWNUM N(N은 1이 아닌 정수), ROWNUM >= N(N은 1이 아닌 정수)
-- ROWNUM 이미 읽은 데이터에다가 순서를 부여
-- **유의점1. 읽지 않은 상태의 값들(ROWNUM이 부여되지 않은 행)은 조회할 수 없다.
-- **유의점2. ORDER BY 절은 SELECT 절 이후에 실행
-- 사용용도 : 페이징 처리
-- 테이블에 있는 모든 행을 조회하는 것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회를 한다.
-- 페이징 처리시 고려사항 : 1페이지당 건수, 정렬 기준
-- EMP테이블의 총 ROW 건수 : 14
-- 페이징당 5건의 데이터를 조회
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
SELECT ROWNUM rn, empno, ename 
FROM emp
ORDER BY ename;

-- 정렬된 결과에 ROWNUM을 부여 하기 위해서는 IN-LINE VIEW를 사용한다.
-- 요점정리 : 1.정렬, 2.ROWNUM 부여

-- SELECT *를 기술할 경우 다른 EXPRESSION을 표기하기 위해서 테이블명.* 테이블명칭.*로 표현해야한다.
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

--ROWNUM > rn
-- *page size : 5, 정렬기준은 ename
-- 1page : rn 1~5
-- 2page : rn 6~10
-- 3page : rn 11~15
-- n page : rn (page-1)*pageSize + 1 ~ page * pageSize // page = 페이지 숫자

SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a)
    WHERE rn BETWEEN 6 AND 10;
    
    SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a)
    WHERE rn >= 1 AND rn <= 5;
    
    SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a)
    WHERE rn BETWEEN (1 - 1)* 5 AND 1 * 5;
    
    -- row_1
    SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename
    FROM emp)
    WHERE rn >= 1 AND rn <= 10;
    
    
    SELECT ROWNUM rn, empno, ename
    FROM emp
    WHERE ROWNUM BETWEEN 1 AND 10;
    
    SELECT ROWNUM rn, empno, ename
    FROM emp
    WHERE ROWNUM <= 10;
    
    --row_2
    
    SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename FROM emp)
    WHERE rn >=11 AND rn <= 14;
    
    SELECT *
    FROM
    (SELECT ROWNUM rn, empno, ename FROM emp)
    WHERE rn BETWEEN  11 AND 20;
    
    --row_3
    SELECT *
    FROM
    (SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename 
    FROM emp
    ORDER BY ename) a)
    WHERE rn BETWEEN 11 AND 20; -- WHERE rn BETWEEN (1-1)*10 + 1 AND 1*10;
    
    SELECT *
    FROM
    (SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename 
    FROM emp
    ORDER BY ename) a)
    WHERE rn BETWEEN (:page-1) * :pageSize + 1  AND :page * :pageSize;
    
    --DUAL 테이블 : 데이터와 관계 없이, 함수를 테스트 해볼 목적으로 사용
    --문자열 대소문자 : LOWER,UPPER,INITCAP
    
    SELECT LOWER('Hello, World!'), UPPER('Hello, World!'), INITCAP('Hello, World!') -- 소문자,대문자,앞글자만 대문자 나머지는 소문자
    FROM dual;
    
    SELECT LOWER('Hello, World!'), UPPER('Hello, World!'), INITCAP('Hello, World!') -- 테이블의 건수만큼 듀얼테이블에서 조회된 것처럼 조회됨
    FROM emp;
    
    SELECT LOWER(ename), UPPER(ename), INITCAP(ename) -- 테이블의 건수만큼 듀얼테이블에서 조회된 것처럼 조회됨
    FROM emp;
    
    --함수는 where 절 에서도 사용 가능
    -- 사원 이름이 SMITH인 사원만 조회
    
    SELECT *
    FROM emp
    WHERE ename = 'SMITH';
    
    SELECT *
    FROM emp
    WHERE ename = :ename;
    
    SELECT *
    FROM emp
    WHERE ename = UPPER(:ename);
    
    --SQL작성 시 아래 형태는 지양 해야한다.
    --테이블의 컬럼을 가공하지 않는 형태로 SQL을 작성한다.
    SELECT *
    FROM emp
    WHERE LOWER(ename) = :ename;
    
    SELECT *
    FROM  dual;
    
    SELECT LENGTH('TEST') -- 문자열의 길이
    FROM dual;
    
    --
    SELECT CONCAT('Hello',', world') CONCAT,
           SUBSTR('Hello, World',1 ,5) sub, -- 1-5
           LENGTH('Hello, World') len,
           INSTR('Hello, World', 'o') ins,
           INSTR('Hello, World', 'o', 6) ins2,
           LPAD('Hello, World', 15, '*') LP,
           RPAD('Hello, World', 15, '*') RP,
           REPLACE('Hello, World', 'H','T') REP, -- 문자를 변경 ex) H->T
           TRIM('    Hello, World     ') TR, -- 공백을 제거
           TRIM('d' FROM 'Hello, World') TR2 -- 공백이 아닌 소문자 d 제거
    FROM dual;
    
    --숫자 함수
    -- ROUND : 반올림(10.6을 소수점 첫번째 자리에서 반올림 --> 11)
    -- TRUNC : 절식(버림)(10.6을 소수점 첫번째 자리에서 절삭 --> 10)
    -- ROUND, TRUNC : 몇번째 자리에서 반올림 혹은 절삭
    -- MOD : 나머지 (몫이 아니라 나누기 연산을 한 나머지 값) ( 13/5 -> 몫:2, 나머지:3)
    
    
    --ROUND(대상 숫자, 최종 결과 자리)
    SELECT ROUND(105.54, 1), -- 반올림 결과가 소수점 첫번째 자리까지 나오도록 --> 두번째 자리에서 반올림
           ROUND(105.55, 1), -- 반올림 결과가 소수점 첫번째 자리까지 나오도록 --> 두번째 자리에서 반올림
           ROUND(105.55, 0), -- 반올림 결과가 정수부만 --> 소수점 첫번째 자리에서 반올림
           ROUND(105.55,-1), -- 반올림 결과가 십의 자리까지 --> 임의 자리에서 반올림
           ROUND(105.55)        -- 두번째 인자를 입력하지 않을 경우 0이 적용
    FROM dual;
    
    SELECT TRUNC(105.54, 1), -- 절삭의 결과가 소수점 첫번째 자리까지 나오도록 --> 소수점 두번째 자리에서 절삭
           TRUNC(105.55, 1), -- 절삭의 결과가 소수점 첫번째 자리까지 나오도록 --> 소수점 두번째 자리에서 절삭
           TRUNC(105.55, 0), -- 절삭의 결과가 정수부(일의 자리)까지 나오도록 --> 소수점 첫번째 자리에서 절삭
           TRUNC(105.55, -1), -- 절삭의 결과가 10의 자리까지 나오도록 --> 일의 자리에서 절삭
           TRUNC(105.55)  -- 두번째 인자를 입력하지 않은 경우 0이 적용
    FROM dual;
    
    -- EMP 테이블에서 사원의 급여(SAL)를 1000으로 나눴을 때 몫
    
    SELECT ename, sal, 
           TRUNC(sal/1000, 0), --몫을 구해보세요
           MOD(sal, 1000) --MOD의 결과는 divisor보다 항상 작다. -- 0~999
    FROM emp;
    
    DESC emp;
    
    --년도2자리/월2자리/일자2자리
    SELECT ename, hiredate
    FROM emp;
    
    -- SYSDATE : 현재 오라클 서버의 시분초가 포함된 날짜 정보를 리턴해주는 특수 함수
    -- 함수명(인자, 인자2)
    -- data + 정수 = 일자 연산
    --2020/01/28 + 5 1= 하루, 1시간 = 1/24
    -- 숫자 표기 : 숫자
    -- 문자 표기 : 싱글 쿼테이션 + 문자열 + 싱글 쿼테이션 --> '문자열'
    -- 날짜 표기 : TO_DATE('문자열 날짜 값','문자열 날짜 값의 표기 형식') --> TO_DATE('2020-01-28', 'YYYY-MM-DD')
    SELECT SYSDATE + 5, SYSDATE + 1/24
    FROM dual;
    
    
    
    
    
    
    
    
    
