/*제약조건 확인 방법
1. tool
2. dictionary view
제약조건 : USER_CONSTRAINTS
제약조건-컬럼 : USER_CONS_COLUMNS
제약조건이 몇개의 컬럼에 관련되어 있는지 알 수 없기 때문에 테이블을 별도로 분리하여 설계
1정규형
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP','DEPT','EMP_TEST','DEPT_TEST');

/*EMP, DEPT PK, FK 제약이 존재하지 않음
2.EMP : pk (empno)
3.    fk ( deptno) - dept.deptno (fk 제약을 생성하기 위해서는 참조하는 테이블 컬럼에 인덱스가 존재해야 한다.)
    
1.dept : pk (deptno)*/

--2.
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

--테이블,컬럼주석 : CICTIONARY 확인 가능
--테이블 주석 : USER_TAB_COMMENTS
--컬럼 주석 : USER_COL_COMMENTS

/*
주석생성
테이블 주석 : COMMENT ON TABLE 테이블명 IS '주석'
컬럼 주석 : COMMENT ON COLUMN 테이블.컬럼 IS '주석'

emp : 직원
dept : 부서

*/

COMMENT ON TABLE emp is '직원';
COMMENT ON TABLE dept IS '부서';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP','DEPT');

DEPT	DEPTNO : 부서번호
DEPT	DNAME : 부서명
DEPT	LOC : 부서위치
EMP	EMPNO : 직원번호
EMP	ENAME : 직원이름
EMP	JOB : 담당업무
EMP	MGR : 매니저 직원번호
EMP	HIREDATE : 입사 일자
EMP	SAL : 급여
EMP	COMM : 성과급
EMP	DEPTNO : 소속부서번호

COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치';

COMMENT ON COLUMN emp.empno IS '직원번호';
COMMENT ON COLUMN emp.ename IS '직원이름';
COMMENT ON COLUMN emp.job IS '담당업무';
COMMENT ON COLUMN emp.mgr IS '매니저 직원번호';
COMMENT ON COLUMN emp.hiredate IS '입사일자';
COMMENT ON COLUMN emp.sal IS '급여';
COMMENT ON COLUMN emp.comm IS '성과급';
COMMENT ON COLUMN emp.deptno IS '소속부서번호';


1.
SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM cycle;
SELECT * FROM daily;


--주석 과제
SELECT *
FROM USER_TAB_COMMENTS,USER_COL_COMMENTS
WHERE USER_TAB_COMMENTS.TABLE_NAME = USER_COL_COMMENTS.TABLE_NAME
AND  USER_COL_COMMENTS.TABLE_NAME IN ('CUSTOMER','CYCLE','DAILY','PRODUCT');

/*VIEW = QUERY
TABLE 처럼 DBMS에 미리 작성한 객체
==> 작성하지 않고 QUERY에서 바로 작성한 VIEW : IN-LINEVIEW ==> 이름이 없기 때문에 재활용이 불가
VIEW는 테이블이다 (X)

사용목적
1. 보안 목적(특정 컬럼을 제외하고 나머지 결과만 개발자에 제공
2. INLINE-VIEW를 VIEW로 생성하여 재활용
    . 쿼리 길이 단축
    
생성방법
CREATE (OR REPLACE) VIEW 뷰명칭 [ (column1, column2.....)] AS
SUBQUERY;

emp 테이블에서 8개의 컬럼중 sal, comm 컬럼을 제외한 6개의 컬럼을 제공하는 v_emp VIEW 생성*/

CREATE OR REPLACE VIEW v_emp AS
SELECT empno,ename,job,mgr,hiredate,deptno
FROM emp;

--시스템 계정에서 Melgoon 계정으로 VIEW 생성권한 추가
GRANT CREATE VIEW TO Melgoon;

--기존 인라인 뷰로 작성시
SELECT *
FROM (SELECT empno, ename, job,mgr,hiredate,deptno
FROM emp);

--VIEW 객체 활용
SELECT *
FROM v_emp;

/*emp테이블에는 부서명이 없음 ==> dept 테이블과 조인을 빈번하게 진행
조인된 결과를 view로 생성 해놓으면 코드를 간결하게 작성하는게 가능

VIEW : v_emp_dept
dname(부서명), empno(직원번호), ename(직원이름), job(담당업무), hirdate(입사일자)
*/
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--인라인뷰로 작성시
SELECT
FROM(SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno);

--VIEW 활용시
SELECT *
FROM v_emp_dept;

--SMITH 직원 삭제후 V_EMP_DEPT VIEW 건수 변화를 확인

--VIEW는 물리적인 데이터를 갖지 않고, 논리적인 데이터의 정의 집합(SQL)이기 때문에
--VIEW에서 참조하는 테이블의 데이터가 변경이 되면 VIEW의 조회 결과도 영향을 받는다.

/*SEQUENC : 시퀀스 - 중복되지 않는 정수값을 리턴해주는 오라클 객체
CREATE SEQUENCE 시퀀스 이름
[OPTION....]
명명규칙 : SEQ_테이블명*/

--emp 테이블에서 사용한 시퀀스 생성
CREATE SEQUENCE seq_emp;

/*시퀀스 제공 함수
NEXTVAL : 시퀀스에서 다음 값을 가져올 때 사용
CURRVAL : NEXTVAL을 사용하고나서 현재 읽어 들인 값을 재확인

시퀀스 주의점
ROLLBACK을 하더라도 NEXTVAL를 통해 얻은 값이 원복되진 않는다
NEXTVAL를 통해 값을 받아오면 그 값을 다시 사용할 수 없다.*/

SELECT seq_emp.NEXTVAL
FROM dual;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'jamse',99,'017');

/*
DDL(INDEX)
정렬해놓고 색인 마냥 찾아가는 개념
테이블의 일부 컬럼을 기준으로 데이터를 정렬한 객체
테이블의 ROW를 가리키는 주소를 가지고 있다.(ROWID)
--ROWID는 테이블의 주소
*/
SELECT ROWID, emp.*
FROM emp;
-- 주소를 알면 바로 접근 가능
SELECT *
FROM EMP
WHERE ROWID = 'AAAE5dAAFAAAACLAAD';
--정렬된 인덱스의 기준으로 해당 ROW의 위치를 빠르게 검색하여 테이블의 원하는 행에 빠르게 접근
--테이블에 데이터를 입력하면 인덱스 구조도 갱신된다.

--인덱스가 없을때 EMPNO 값으로 조회 하는 경우
-- emp 테이블에서 pk_emp 제약조건을 삭제하여 empno컬럼으로 인덱스가 존재하지 않는 환경을 조성

ALTER TABLE emp DROP CONSTRAINT pk_emp;

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/*emp 테이블의 empno 컬럼으로 PK 제약을 생성하고 동일한 SQL을 실행
PK : UNIQUE + NOT NULL
    (UNIQUE 인덱스를 생성해준다)
==> empno 컬럼으로 unique 인덱스가 생성됨

인덱스로 SQL을 실행하게 되면 인덱스가 없을때와 어떻게 다른지 차이점을 확인
*/

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno); -- 인덱스 생성

SELECT rowid, emp.*
FROM emp; -- 테이블은 순서가 없다

SELECT empno, rowid
FROM emp
ORDER BY empno;

explain plan for
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/*SELECT 조회컬럼이 테이블 접근에 미치는 영향
SELECT * FROM emp WHERE empno =7782
==>
SELECT * FROM emp WHERE empno = 7782
*/

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/*UNIQUE VS NON-UNIQUE 인덱스의 차이 확인
1.PK_EMP 삭제
2.EMPNO 컬럼으로 NON-UNIQUE 인덱스 생성
3.실행계획 확인
*/
ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_n_emp_01 ON emp (empno);

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

/* emp 테이블에 job 컬럼을 기준으로 하는 새로운 non-unique 인덱스를 생성*/
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

/*선택가능한 사항
1. emp 테이블을 전체 읽기
2. idx_n_emp_01(empno) 인덱스 활용
3. idx_n_emp_02(job) 인덱스 활용*/

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);









    