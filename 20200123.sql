--emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오 ( 단 연산자는 비교연산자를 사용한다.)
-- WHERE 절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
-- SQL은 집합의 개념을 갖고 있다.(절차 개념이 없다.)
-- 집합 : 키가 185cm 이상이고 몸무게가 70kg 이상인 사람들의 모임
--    --> 몸무게가 70kg 이상이고 키가 185cm 이상인 사람들의 모임
-- 집합의 특징 : 집합에는 순서가 없다.
-- (1, 5, 10) --> (10, 5, 1) : 두 집합은 서로 동일하다.
-- 테이블에는 순서가 보장되지 않음
-- SELECT 결과가 순서가 다르더라도 값이 동일하면 정답으로 간주
-- > 정렬기능 제공(ORDER BY)
--      잘생긴 사람의 모임 --> 집합x
SELECT ename,hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD') AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');

SELECT ename,hiredate
FROM emp
WHERE hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD') AND hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD');



--IN 연산자
-- 특정 집합에 포함되는지 여부를 확인
-- 부서번호가 10번 혹은 20번에 속하는 직원 조회
SELECT empno, ename, deptno
FROM emp
WHERE deptno >= 10 AND deptno <= 20; -- 부서번호

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10,20);

--IN 연산자를 사용하지 않고 OR 연산자 사용
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR    deptno = 20;


-- AND / OR
-- 문자 상수 ( ' ' 싱글 컨테이션을 써줘야 문자열로 인식함)

SELECT *
FROM users
WHERE 2 = 2;

-- emp테이블에서 사원이름이 SMITH, JONES 인 직원만 조회 (empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'JONES';

SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH','JONES');

-- users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회 하시오. (IN 연산자 사용)
SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown','cony','sally');

SELECT *
FROM users;

--문자열 매칭 연산자 : LIKE, %, _
-- 위에서 연습한 조건은 문자열 일치에 대해서 다룸
-- 이름이 BR로 시작하는 사람만 조회
-- 이름에 R 문자열이 들어가는 사람만 조회

-- 사원 이름이 S로 시작하는 사원 조회
-- SMNITH, SMILE, SKC
-- % 어떤 문자열(한글자, 글자가 없을 수도 있고, 여러 문자열이 올 수도 있다.)

SELECT *
FROM emp
WHERE ename LIKE 'S%';

-- 글자 수를 제한한 매턴 매칭
-- _(언더바) 정확히 한문자
SELECT *
FROM emp
WHERE ename LIKE 'S____';

-- emp 테이블의 사원 이름에 S가 들어가는 사원 조회
-- ename LIKE '%S%'

SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where4
-- member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.

SELECT *
FROM member;

SELECT mem_id,mem_name
FROM member
WHERE mem_name LIKE '신%';

-- member 테이블에서 회원의 이름에 글자[이]가 들어가는 모든 사람의 MEM_ID, MEM_NAME을 조회하는 쿼리를 작성하시오.

SELECT mem_id,mem_name
FROM member
WHERE mem_name LIKE '%이%';

-- null 비교 연산 (IS)
-- comm 컬럼의 값이 null인 데이터를 조회 WHERE comm = null)
SELECT *
FROM emp
WHERE comm = null;

SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;

-- emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회되도록 쿼리를 작성하시오.

SELECT *
FROM emp
WHERE comm >=0; -- 0보다 크거나 같은 값을 조회

SELECT *
FROM emp
WHERE comm IS NOT null; -- NOT를 사용하여 널값이 없는 자료를 조회

-- 사원의 관리자가 7698, 7839 그리고 null이 아닌 직원만 조회
-- NOT IN 연산자에서는 NULL 값을 포함 시키면 안된다.
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,NULL);

-- --> 올바른 질의문
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

--연산자 우선순위
-- *,/ 연산자가 +,- 보다 우선순위가 높다.
-- 1+5*2 = 11 -> (1+5)*2 x  5를 먼저 2와 곱하고 나머지 +1을 해야함
-- 우선순위 변경 : ()
-- AND > OR OR가 우선순위가 더 높음

-- emp 테이블에서 사원 이름이 SMITH 이거나 사원 이름이 ALLEN 이면서 담당업무가 SALESMAN인 사원 조회

SELECT *
FROM emp
WHERE ename Like 'SMITH' OR ename Like 'ALLEN' AND JOB IN('SALESMAN');

SELECT *
FROM emp
WHERE ename Like 'SMITH' OR (ename Like 'ALLEN' AND JOB IN('SALESMAN'));

-- 사원 이름이 SMITH 이거나 ALLEN 이면서 담당업무가 SALESMAN인 사원 조회

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

--정렬
-- SELECT *
-- FROM table
-- [WHERE]
-- ORDER BY {칼럼|별칭|컬럼인덱스 [ASC | DESC], ....}

-- emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 오름 차순 정렬한 결과를 조회 하세요.

SELECT *
FROM emp
ORDER BY ename ASC;

-- emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 내림 차순 정렬한 결과를 조회 하세요.

SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE (설명하다)
--ORDER BY ename DESC; -- DESC : DESCRNDING (내림)

-- emp 테이블에서 사원 정보를 ename컬럼으로 내림차순, ename 값이 같을 경우 mgr 칼럼으로 오름차순 정렬하는 쿼리를 작성하세요.
SELECT *
FROM emp
ORDER BY ename DESC, mgr ASC;

--정렬시 별칭을 사용
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;
--컬럼 인덱스로 정렬
-- java array(배열) index[0]부터 시작 SQL의 경우 colomn index : 1부터 시작
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;

--order by 1 실습
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY LOC DESC;

--order by 2 실습
SELECT *
FROM emp
WHERE comm IS NOT null AND comm != 0;

SELECT *
FROM emp
WHERE comm > 0 ORDER BY comm DESC, empno ASC;

--order by 3 실습
SELECT *
FROM emp
WHERE job NOT IN ('PRESIDENT')
ORDER BY job, empno DESC;