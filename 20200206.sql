--sub7

select *
from customer;


select *
from cycle;

SELECT a.cid,customer.cnm,a.pid,product.pnm, a.day, a.cnt
FROM
(SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)) a,customer,product
            WHERE a.cid = customer.cid AND a.pid = product.PID;
            
--대전시에 있는 5개의 구 햄버거지수
--(kfc + 버거킹 + 맥도날드) / 롯데리아;

SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%대전%'
GROUP BY sido;

--분자(KFC,버거킹,맥도날드)

--대전광역시	중구	7
--대전광역시	동구	4
--대전광역시	유성구	4
--대전광역시	서구	17
--대전광역시	대덕구	2

SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '대전광역시' AND GB IN ('KFC','버거킹','맥도날드')
GROUP BY sido, sigungu;


--롯데리아
--대전광역시	중구	6
--대전광역시	동구	8
--대전광역시	서구	12
--대전광역시	유성구	8
--대전광역시	대덕구	7
SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '대전광역시' AND GB IN ('롯데리아')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2,2) hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*) c1
FROM fastfood
WHERE /*sido = '대전광역시' AND*/ GB IN ('KFC','버거킹','맥도날드')
GROUP BY sido, sigungu) a,


(SELECT sido, sigungu, COUNT(*) c2
FROM fastfood
WHERE /*sido = '대전광역시' AND*/ GB IN ('롯데리아')
GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;

--fastfood 테이블을 한번만 읽는 방식으로 작성하기
SELECT ROWNUM, sido, sigungu, ROUND((kfc+burgerking+mac) / lot, 2) burger_score
FROM
(SELECT sido, sigungu,
        NVL(SUM(DECODE(gb,'KFC', 1)),0) kfc, NVL(SUM(DECODE(gb, '버거킹', 1)),0) burgerking,
        NVL(SUM(DECODE(gb, '맥도날드', 1)),0) mac, NVL(SUM(DECODE(gb, '롯데리아', 1)),1)lot
        
FROM fastfood
WHERE gb IN('KFC','버거킹','맥도날드','롯데리아')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;


SELECT *
FROM fastfood
WHERE sido = '경기도'
AND sigungu = '구리시';

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

--햄버거 지수, 개인별 근로소득 금액 순위가 같은 시도별로 [조인] 지수, 개인별 근로소득 금액으로 정렬 후 ROWNUM을 통해 순위를 부여 같은 순위의 행끼리 조인
--햄버거지수 시도, 햄버거 지수 시군구, 햄버거지수, 세금 시도, 세금 시군구, 개인별 근로소득액

/*--ROWNUM 사용시 주의
1. SELECT ==> ORDER BY
    정렬된 결과에 ROWNUM을 적용하기 위헤서는 INLINE-VIRW
2.1번부터 순차적으로 조회가 되는 조에 대해서만 WHERE 절에서 기술이 가능
    ROWNUM = 1 (O)
    ROWNUM = 2 (X)
    ROWNUM < 10 (O)
    ROWNUM > 10 (X)*/
    
/*ROWNUM - ORDER BY
ROUND
GROUP BY SUM
JOIN
DECODE
NVL
IN*/

-- 이게 위 지문의 답
 SELECT b.sido, b.sigungu, b.burger_score, a.sido, a.sigungu, a.pri_sal
FROM 
(SELECT ROWNUM rn, a.*
FROM 
(SELECT sido, sigungu, ROUND(sal/people) pri_sal
 FROM tax
 ORDER BY pri_sal DESC) a) a,

(SELECT ROWNUM rn, b.*
FROM
(SELECT sido, sigungu, ROUND((kfc + BURGERKING + mac) / lot, 2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC', 1)), 0) kfc, NVL(SUM(DECODE(gb, '버거킹', 1)), 0) BURGERKING,
       NVL(SUM(DECODE(gb, '맥도날드', 1)), 0) mac, NVL(SUM(DECODE(gb, '롯데리아', 1)), 1) lot       
FROM fastfood
WHERE gb IN ('KFC', '버거킹', '맥도날드', '롯데리아')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC) b ) b
WHERE a.rn = b.rn;

--DML

--empno 컬럼은 NOT NULL 제약 조건이 있다. - INSERT 시 반드시 값이 존재해야 정상적으로 입력된다
--empno 컬럼을 제외한 나머지 컬럼은 NULLABLE 이다. (NULL 값이 저장될 수 있다.)
INSERT INTO emp(empno,ename,job)
VALUES (9999,'brown',NULL);

select *
from emp;

INSERT INTO emp (ename,job)
VALUES ('sally','SALESMAN');

--문자열 : '문자열'(싱글컨테이션) ==> "문자열"(JAVA에선 이렇게)
-- 숫자 : 10
-- 날짜 : TO_DATE('20200206','YYYYMMDD')

--emp 테이블의 hiredate 컬럼은 date 타입

--emp테이블의 8개의 컬럼에 값을 입력;
DESC emp ;

INSERT INTO emp VALUES (9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99);
ROLLBACK;

--여러건의 데이터를 한번에 INSERT :
--INSERT INTO 테이블명 (컬럼명1, 컬럼명2...)
--SELECT ...
--FROM ;

INSERT INTO emp
SELECT 9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99
FROM dual

    UNION ALL
    
SELECT 9999,'brown','CLERK',NULL, TO_DATE('20200205','YYYYMMDD'),1100,NULL,99
FROM dual;

SELECT *
FROM emp;

--UPDATE 쿼리
--UPDATE 테이블명 SET 컬럼명1 = 갱신할 컬럼 값1, 컬럼명 2 = 갱신할 컬럼 값2,.....
--WHERE 행 제한 조건
--업데이트 쿼리 작성시 WHERE 절이 존재하지 않으면 해당 테이블의 모든 행을 대상으로 업데이트가 일어난다.
--UPDATE, DELETE 절에 WHERE절이 없으면 의도한게 맞는지 다시한번 확인한다.
--WHERE절이 있다고 하더라도 해당 조건으로 해당 테이블을 SELECT하는 쿼리를 작성하여 실행하면 UPDATE 대상 행을 조회할 수 있으므로 확인하고 실행하는 것도
-- 사고 발생 방지에 도움이 된다.

--99번 부서번호를 갖는 부서 정보가 DEPT테이블에 있는 상황
--INSERT INTO dept VALUES (99,'ddit','desjeon');
SELECT *
FROM dept;
--99번 부서번호를 갖는 부서의 DNAME 컬럼의 값을 '대덕IT', loc 컬럼의 값을 '영민빌딩'으로 업데이트
UPDATE dept SET DNAME = '대덕IT', loc = '영민빌딩'
where deptno = 99;

SELECT *
FROM DEPT;

--실수로 WHERE절을 기술하지 않았을 경우;
UPDATE dept SET dnme = '대덕IT', loc = '영민빌딩'
ROLLBACK;

--여사님-시스템 번호를 잊어먹음 ==> 한달에 한번씩 모든 여사님을 대상으로 본인 주민번호 뒷자리로 비밀번호를 업데이트
-- 시스템 사용자 : 여사님(12,000), 영업점(550), 직원(1300)
--UPDATE 사용자 set 비밀번호 = 주민번호뒷자리
--WHERE 사용자구분 = '여사님'

-- 10 ==> SUBQUERY 
-- SMITH, WARD가 속한 부서에 소속된 직원 정보
SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN ('SMITH','WARD'));
--UPDATE시에도 서브 쿼리 사용이 가능;
INSERT INTO emp(empno, ename) VALUES (9999,'brown');

select *
from emp;

--9999번 사원 deptno, job 정보를 SMITH 사원이 속한 부서정보, 담당업무로 업데이트

UPDATE emp SET deptno = (SELECT deptno
                            FROM emp
                            WHERE ename = 'SMITH'),job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

select *
from emp;

ROLLBACK;

--DELETE
--DELETE SQL : 특정 행을 삭제
--DELETE [FROM] 테이블명 WHERE 행 제한 조건
--DELETE[FROM] table [WHERE condition]; // 꼭 프롬이 있을 필요는 없음

SELECT *
FROM dept;

--99번 부서번호에 해당하는 부서 정보 삭제

DELETE dept WHERE deptno = 99;

SELECT *
FROM dept;
COMMIT;


--SUBQUERY를 통해서 특정 행을 제한하는 조건을 갖는 DELETE;
--매니저가 7698 사번인 직원을 삭제 하는 쿼리를 작성

DELETE emp
WHERE empno IN (7499,7521,7654,7844,7900); -- 하드코딩

DELETE emp
WHERE empno IN(SELECT empno
                FROM emp
                WHERE mgr = 7698); --서브 쿼리를 사용한 DELETE
                
SELECT *
FROM emp;
                
ROLLBACK; -- 커밋하기 전의 실행한 스크립트를 되돌린다. 

SELECT *
FROM emp;

--트랜잭션 : 여러 단계의 과정을 하나의 작업 행위로 묶는 행위





