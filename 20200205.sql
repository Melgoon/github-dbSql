--sub4
--데이터 추가
--비상호 연관 쿼리, 낫인 이용
--dept 테이블에는 5건의 데이터가 존재
--emp 테이블에는 14명의 직원이 있고, 직원은 하나의 부서 속해 있다.(deptno)
--부서중 직원이 속해 있지 않은 부서 정보를 조회하라.

--서브쿼리에서 데이터의 조건이 맞는지 확인자 역할을 하는 서브쿼리 작성

INSERT INTO dept VALUES(99,'ddit','daejeon');

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp
                    GROUP BY deptno);

--ROLLBACK 트랜잭션 취소
COMMIT; --트랜잭션 확정

--sub5
--모든 제품은 다음 4가지

SELECT *
FROM product;

--cid=1인 고객이 애음하는 제품

SELECT pid
FROM cycle
WHERE cid = 1;

SELECT *
FROM product
WHERE pid NOT IN(100,400);

SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
FROM cycle
WHERE cid = 1);



SELECT *
FROM product
WHERE PID NOT IN (SELECT PID
                    FROM cycle
                    WHERE PID IN(100,400));

--sub6
--cid=2인 고객이 애음하는 제품중 cid=1인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리 작성

--cid=1인 고객의 애음 정보 ( 100번,400번 제품을 애음중)
SELECT *
FROM cycle
WHERE cid = 1;

--cid=2인 고객의 애음 정보(100,200번 제품을 애음중)
SELECT *
FROM cycle
WHERE cid = 2;

--cid = 1, cid=2인 고객이 동시에 애음하는 제품은 100번

SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);

SELECT *
FROM cycle

WHERE cid IN(SELECT cid
                FROM cycle
                WHERE cid = 1 OR cid = 2 AND PID = 100);
--sub7
SELECT a.cid,customer.cnm,a.pid,product.pnm, a.day, a.cnt
FROM
(SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)) a,customer,product
            WHERE a.cid = customer.cid AND a.pid = product.PID;
            
            
SELECT cycle.cid,customer.cnm,cycle.pid,product.pnm,cycle.day,cycle.cnt
FROM cycle, customer, PRODUCT
WHERE cycle.cid = 1 AND cycle.pid IN(SELECT pid
                        FROM cycle
                        WHERE cid = 2)
                        AND cycle.cid = customer.cid AND cycle.pid = product.pid;
                        
SELECT cycle.cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm, --권장하는 방법은 아님, 사용하지 않아야할 방법
        cycle.pid, (SELECT pnm FROM product WHERE pid = cycle.pid) pnm,
        cycle.day, cycle.cnt
FROM cycle
WHERE cid = 1 AND pid IN(SELECT cid
                FROM cycle
                WHERE cid = 2);
                
--매니저가 존재하는 직원을 조회(KING을 제외한 13명의 데이터가 조회)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXSITS 조건에 만족하는 행이 존재 하는지 확인하는 연산자
--다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는다.
 -- WHERE empno = 7369
 -- WHERE EXISTS (SELECT 'X'
 --                 FROM ......);
 
 -- 매니저가 존재하는 직원을 EXISTS 연산자를 통해 조회
 -- 매니저도 직원
 SELECT *
 FROM emp e
 WHERE EXISTS (SELECT 'X'
                FROM emp m
                WHERE e.mgr = m.empno);
                
--sub9
--1번 고객이 애음하는 제품;

SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
FROM cycle
WHERE cid = 1);

select *
from cycle;
select *
from product;

SELECT *
FROM product e 
WHERE EXISTS (SELECT 'X'
                FROM cycle m
                WHERE m.cid = 1 AND m.pid = e.pid);
                
--sub10

SELECT *
FROM product e 
WHERE NOT EXISTS (SELECT 'X'
                FROM cycle m
                WHERE m.cid = 1 AND m.pid = e.pid);
--집합연산
--합집합 : UNION -중복제거(집합개념) / UNION ALL - 중복을 제거하지 않음(속도 향상)
--교집합 : INTERSECT (집합개념)
--차집합 : MINUS (집합개념)
--집합연산의 공통점
--두 집합의 컬럼의 개수, 타입이 일치 해야 한다

--동일한 집합을 합집하기 때문에 중복되는 데이터는 한번만 적용된다.
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--UNION ALL연산자는 UNION 연산자와 다르게 중복을 허용한다.

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--INTERSECT(교집합) : 위, 아래 집합에서 값이 같은 행만 조회

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

-- MINUS(차집합) : 위 집합에서 아래 집합의 데이터를 제거한 나머지 집합;

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);

--집합의 기술 순서가 영향이 가는 집합연산자
-- A UNION B  B UNION A ==> 같음
-- A UNION ALL B B UNION ALL A ==> 같음(집합)
-- A INTERSECT B B INTERSECT A ==> 같음
-- A MINUS B B MINUS A ==> 다름

--집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다.
SELECT 'X' fir,'B' sec
FROM dual

UNION

SELECT 'Y','A'
FROM dual;

--정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술
SELECT deptno, dname, loc
    FROM dept
    WHERE DEPTNO IN(10,20)
    --ORDER BY deptno 


UNION

SELECT deptno,dname,loc
FROM dept
WHERE DEPTNO IN(30,40)
ORDER BY DEPTNO;


SELECT deptno, dname,loc
FROM(SELECT deptno, dname, loc
    FROM dept
    WHERE DEPTNO IN(10,20)
    ORDER BY deptno)


UNION

SELECT deptno,dname,loc
FROM dept
WHERE DEPTNO IN(30,40)
ORDER BY DEPTNO;

SELECT *
FROM fastfood;

-- 버거지수 ==> (kfc개수 + 버거킹 개수 + 맥도날드 개수) / 롯데리아 개수
--시도,시군구,버거지수
--버거지수 값이 높은 도시가 먼저 나오도록 정렬

SELECT count(GB) count_GB
FROM fastfood;

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = '롯데리아'; --롯데리아 912개

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = '버거킹'; --맘스터치 282개

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = 'KFC'; -- KFC 111개

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB = '맥도날드'; -- 맥도날드 468개

-- 맘스터치+KFC+맥도날드 / 롯데리아

SELECT SIDO,SIGUNGU,GB
FROM fastfood
WHERE GB IN('버거킹','KFC','맥도날드')--861개 / 912개

MINUS

SELECT SIDO,SIGUNGU,GB
FROM fastFOOD
where GB IN('롯데리아'); --912개

-- 대덕구 버거지수 :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('대전광역시') AND SIGUNGU IN('대덕구') ORDER BY GB DESC; --맥도날드 3개 롯데리아 7개

-- 중구 버거지수 : 
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('대전광역시') AND SIGUNGU IN('중구') ORDER BY GB DESC; -- 맥도날드 4개, 버거킹 2개 KFC  1개 롯데리아 6개
-- 서구 버거지수 :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('대전광역시') AND SIGUNGU IN('서구') ORDER BY GB DESC;  -- 버거킹 6개 맥도날드 7개 KFC 4개 롯데리아 12개
-- 유성구 버거지수 :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('대전광역시') AND SIGUNGU IN('유성구') ORDER BY GB DESC; -- 버거킹 1개 맥도날드 3개 롯데리아 8개
-- 동구 버거지수 :
SELECT SIDO,SIGUNGU,GB
FROM fastFood
where SIDO IN ('대전광역시') AND SIGUNGU IN('동구') ORDER BY GB DESC; -- 버거킹 2개 맥도날드 2개 롯데리아 8개
