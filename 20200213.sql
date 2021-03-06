--DDL
/*synonym : 동의어
1.객체 별칭을 부여
 ==> 이름을 간단하게 표현
 
Melgoon 사용자가 자신의 테이블 emp테이블을 사용해서 만든 v_emp view
hr 사용자가 사용할 수 있게 끔 권한을 부여

v_emp : 민감한 정보 sal, comm 을 제외한 view
hr 사용자 v_emp를 사용하기 위해 다음과 같이 작성

SELECT * FROM Melgoon.v_emp; --

hr 계정에서
synonym Melgoon.v_emp ==> v_emp //synonym을 사용하면 명령어가 간단해지고 어디서 오는 테이블인지 알 수 있음
v_emp == Melgoon.v_emp

SELECT *
FROM v_emp;

1.sem 계정에서 v_emp를 hr 계정에서 조회할 수 있도록 조회권한 부여

GRANT SELECT ON v_emp TO hr; ( v_emp를 hr 사용자에게 조회할 권한을 부여)*/
GRANT SELECT ON v_emp TO hr;

/*2.hr 계정 v_emp 조회하는게 가능 ( 권한 1번에서 받았기 때문에)
사용시 해당 객체의 소유자를 명시 : sem.v_emp
간단한게 sem.v_emp ==> v_emp 사용하고 싶은 상황
synonym 생성

CREATE SYNONYM 시노님이름(객체이름) FOR 원 객체명;

SYNONYM 삭제
DROP SYNONYM 시노님이름;

--DCL(GRANT / REVOKE)
권한 종류
1.시스템 권한 : TABLE을 생성, VIEW 생성 권한... GRANT CONNECT TO Melgoon;
2.객체 권한 : 특정 객체에 대해 SELECT,UPDATE,INSERT,DELETE.... GRANT SELECT ON 객체명 TO hr;

ROLE : 권한을 모아놓은 집합
사용자별로 개별 권한을 부여하게 되면 관리의 부담
특정 ROLE에 권한을 부여하고 해당 ROLE 사용자에게 부여
해당 ROLE을 수정하게 되면 ROLE을 갖고 있는 모든 사용자에게 영향

권한 부여/회수
시스템 권한 : GRANT 권한이름 TO 사용자 | ROLE; -- 부여
            REVOKE 권한이름 FROM 사용자 | ROLE; -- 회수
            
객체 권한 : GRANT 권한이름 ON 객체명 TO 사용자 | ROLE
        REVOKE 권한이름 ON 객체명 FROM 사용자 | ROLE;
        
        
스키마 : 객체들의 집합

테이블 스페이스, 사용자 생성

role : 권한들의 집합

--DATA dictionary : 사용자가 관리하지 않고, dbms가 자체적으로 관리하는 시스템 정보를 담은 view

data dictionary 접두어
1.USER : 해당 사용자가 소유한 객체
2.ALL : 해당 사용자가 소유한 객체 + 다른 사용자로 부터 권한을 부여받은 객체
3.DBA : 모든 사용자의 객체 (일반 사용자는 사용 불가)

*V$ 특수 VIEW
*/
SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES;

/*
DICTIONARY 종류 확인 : SYS.DICTIONARY;
*/

SELECT *
FROM DICTIONARY;

/*대표적인 dictionary
OBJECTS : 객체 정보 조회(테이블, 인덱스, VIEW, SYNONYM...)
TABLES : 테이블 정보만 조회
TAB_COLUMNS : 테이블의 컬럼 정봊 ㅗ회
INDEXES : 인덱스 정보 조회
IND_COLUMNS : 인덱스 구성 컬럼 조회
CONSTRAINTS : 제약 조건 조회
CONS_COLUMNS : 제약조건 구성 컬럼 정보 조회
TAB_COMMENTS : 테이블 주석
COL_COMMENTS : 테이블의 컬럼 주석
*/
SELECT * 
FROM USER_OBJECTS; -- 오라클 객체 정보

--emp, dept 테이블의 인덱스와 인덱스 컬럼 정보 조회
--user_indexes, user_ind_columns join
--테이블명, 인덱스 명, 컬럼명

SELECT *
FROM USER_INDEXES;

select table_name, index_name, COLUMN_NAME
from user_ind_columns
ORDER BY table_name, index_name, column_position;

/*select A.INDEX_NAME,A.TABLE_NAME
from USER_INDEXES A,USER_IND_COLUMNS B
WHERE USER_INDEXES.INDEX_NAME = USER_IND_COLUMNS.INDEX_NAME;*/

--multiple insert : 하나의 insert 구문으로 여러 테이블에 데이터를 입력하는 DML

SELECT *
FROM dept_test2;

SELECT *
FROM dept_test;

--동일한 값을 여러 테이블에 동시 입력하는 multiple insert;
INSERT ALL
    INTO dept_test
    INTO dept_test2
SELECT 98,'대덕','중앙로' FROM dual UNION ALL
SELECT 97,'IT','영민' FROM dual;
DELETE FROM dept_test WHERE deptno = '97';
DELETE FROM dept_test2 WHERE deptno = '98';
COMMIT;

--테이블에 입력할 컬럼을 지정하여 mlitiple insert
ROLLBACK;
INSERT ALL
    INTO dept_test (deptno, loc) VALUES( deptno,loc)
    INTO dept_test2
SELECT 98 deptno,'대덕' dname,'중앙로' loc FROM dual UNION ALL
SELECT 97,'IT','영민' FROM dual;

--테이블에 입력할 데이터를 조건에 따라 mulitiple insert
/*CASE
    WHEN 조건 기술 THEN
END;*/

ROLLBACK;
INSERT ALL--ALL이기 때문에 전부 실행하여 삽입
    WHEN deptno = 98 THEN -- 98번이면 테이블에 입력해라
        INTO dept_test (deptno, loc) VALUES( deptno,loc)
        INTO dept_test2
    ELSE --그외 값을 입력
        INTO dept_test2
SELECT 98 deptno,'대덕' dname,'중앙로' loc FROM dual UNION ALL
SELECT 97,'IT','영민' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

d

--조건을 만족하는 첫번째 insert만 실행하는 multiple insert

ROLLBACK;

INSERT FIRST -- FIRST이기 때문에 조건이 맞는 것만 입력된다.
    WHEN deptno >= 98 THEN -- 98보다 크거나 같을 때
        INTO dept_test (deptno, loc) VALUES( deptno,loc)
    WHEN deptno >= 97 THEN -- 97보다 크거나 같을 때
        INTO dept_test2
    ELSE 
        INTO dept_test2
SELECT 98 deptno,'대덕' dname,'중앙로' loc FROM dual UNION ALL
SELECT 97,'IT','영민' FROM dual;



--오라클 객체 : 테이블에 여러개의 구역을 파티션으로 구분
--테이블 이름은 동일하나 값의 종류에 따라 오라클 내부적으로 별도의 분리된 영역에 데이터를 저장하는 것
--dept_test ==> detp_test_20200201

ROLLBACK;

INSERT FIRST -- FIRST이기 때문에 조건이 맞는 것만 입력된다.
    WHEN deptno >= 98 THEN -- 98보다 크거나 같을 때
        INTO dept_test (deptno, loc) VALUES( deptno,loc)
    WHEN deptno >= 97 THEN -- 97보다 크거나 같을 때
        INTO dept_test20200202
    ELSE 
        INTO dept_test2
SELECT 98 deptno,'대덕' dname,'중앙로' loc FROM dual UNION ALL
SELECT 97,'IT','영민' FROM dual;

/*MERGE : 통합
테이블에 데이터를 입력/갱신 하려고 함
1. 내가 입력하려고 하는 데이터가 존재하면 
    ==> 업데이트
2. 내가 이력하려고 하는 데이터가 존재하지 않으면
    ==> INSERT
    
    1.SELECT 실행
    2-1.SELECT 실행 결과가 0 ROW이면 INSERT
    2-2.SELECT 실행 결과가 1 ROW이면 UPDATE
    
MERGE 구문을 사용하게 되면 SELECT 를 하지 않아도 자동으로 데이터 유무에 따라 INSERT 혹은 UPDATE 실행한다
2번의 쿼리를 한번으로 준다.

--MERGE 구문--
merge into 테이블명 [alias](별칭)
USING (TABLE | VIEW | IN-LINE-VIEW)
ON (조인조건)
WHEN MATCHED THEN
    UPDATE SET col1 = 컬럼값, col2 = 컬럼값2.....
WHEN NOT MATCHED THEN
    INSERT (컬럼1, 컬럼2.....)VALUES(컬럼값1,컬럼값2......); */
    
    SELECT *
    FROM emp_test;
    
    --DELETE emp_test;
    
    --로그를 안남긴다. ==> 복구가 안된다. ==> 테스트용으로...
    --TRUNCATE TABLE emp_test; (절대 돌리지 말 것! 복구 안됨!)
    ROLLBACK;
    SELECT *
    FROM emp_test;
    
    
    --emp테이블에서 emp_test로 복사한다. (7469-SMITH)
    INSERT INTO emp_test
    SELECT empno,ename,deptno,'010'
    FROM emp
    WHERE empno=7369;
    
    --데이터가 잘 입력 되었는지 확인
    SELECT *
    FROM emp_test;
    
    UPDATE emp_test SET ename = 'brown'
    WHERE empno = 7369;
    
    COMMIT;
    
   /* emp테이블의 모든 직원을 emp_test테이블로 통합
    emp 테이블에는 존재하지만 emp_test에는 존재하지 않으면 insert
    emp 테이블에는 존재하고 emp_test에도 존재하면 ename,deptno를 update;*/
    
    --emp테이블에 존재하는 14건의 데이터중 emp_test에도 존재하는 7369를 제외한 13건의 데이터가
    --emp_test 테이블에 신규로 입력이 되고
    --emp_test에 존재하는 7369번의 데이터는 ename(brown)이 emp테이블에 존재하는 이름인 SMITH로 갱신
    
    MERGE INTO emp_test a
    USING emp b
    ON (a.empno = b.empno)
    WHEN MATCHED THEN
        UPDATE SET a.ename=b.ename, a.deptno = b.deptno
    WHEN NOT MATCHED THEN
        INSERT (empno,ename,deptno) VALUES(b.empno,b.ename,b.deptno);
        
        SELECT *
        FROM emp_test;
        
    --해당 테이블에 데이터가 있으면 insert, 없으면 update
    --emp_test테이블에 사번이 9999번인 사람이 없으면 새롭게 insert 있으면 update
    --(9999.'brown',10,'010');
    
    INSERT INTO dept_tset VALUES (9999.'brown',10,'010');
    
    UPDATE dept_test SET ename = 'brown' deptno = 10 hp = '010' 
    WHERE empno = 9999;
    
    MERGE INTO emp_test
    USING dual
    ON (empno = 9999)
    WHEN MATCHED THEN
        UPDATE SET ename = ename || '_u',
                    deptno = 10,
                    hp = '010'
        WHEN NOT MATCHED THEN
        INSERT VALUES(9999,'brown',10,'010');
        
        SELECT *
        FROM emp_test;
        
        DESC emp_test;
        
        -- MERGE, WINDOW FUNCTION(분석함수)
        
        --GROUP_AD1
        select deptno,sum(sal)
        from emp
        GROUP BY deptno
        
        UNION ALL -- 두개의 select를 합칠 수 있다. 단, 컬럼의 개수가 같아야하고, 각 컬럼의 데이터 타입이 같아야함
        
        select null,sum(sal)
        from emp
        ORDER BY deptno ASC;
        
        /*
        I/O
        빠른 순서대로
        CPU CACHE > RAM >  SSD > HDD > NETWORK
        */
        
    /*REPORT GROUP FUNCTION
    ROLLUP
    CUBE
    GROUPING
    
    ROLLUP 
    사용방법 : GROUP BY ROLLUP (컬럼1, 컬럼2....)
    SUBGROUP을 자동적으로 생성
    SUBGROUP을 생성하는 규칙 : ROLLUP에 기술한 컬럼을 오른쪽에서부터 하나씩 제거하면서 SUB GROUP을 생성
                            EX : GROUP BY ROLLUP (deptno) ==> 첫번째 sub group : GROUP BY deptno ==> detpno 대상
                                                             두번째 sub group : GROUP BY NULL ==> 전체 행을 대상
                                                             */
    --GROUP_AD1을 GROUP BY ROLLUP 절을 사용하여 작성;
    SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY ROLLUP (deptno);
    
    
    SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal
    FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    /*GROUP BY job, deptno : 담당업무, 부서별 급여합 -- 처음 기술
    GROUP BY hob : 담당업무별 급여합 -- 두번째 기술
    GROUP BY :전체 급여합 -- 마지막 기술
            */
            
    SELECT job, deptno, GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    SELECT job, deptno,GROUPING(job), GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    --GROUP_AD2(CASE)
    SELECT CASE
        WHEN GROUPING(job) = 1 THEN '총계'
        ELSE job
        END job, deptno, GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    --GROUP_AD2(DECODE)
    SELECT DECODE( GROUPING(job),1,'총계',
                    0,job) job, deptno, GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    --GROUP_AD2(DECODE)
   SELECT DECODE( GROUPING(job),1,'총',
                    0,job) job,DECODE( GROUPING(deptno),1,'소계',0,deptno) deptno,
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
    /* --GROUP_AD2(CASE)
   SELECT CASE
        WHEN GROUPING(job) = 1 THEN '총계'
        ELSE job
        END job, 
        CASE
        WHEN GROUPING(deptno) = 1 THEN '소계'
        ELSE deptno
        END deptno,
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);*/
    
    ----GROUP_AD2-1(DECODE)
    SELECT DECODE( GROUPING(job),1,'총',
                    0,job) job,DECODE( GROUPING(deptno),1,DECODE(GROUPING(job),1,'계','소계'),0,deptno) deptno,
        SUM(sal + NVL(comm,0)) sal
        FROM emp
    GROUP BY ROLLUP (job, deptno);
    
            
        
        
        
        
        