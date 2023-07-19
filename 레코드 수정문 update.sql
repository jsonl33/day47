--emp27테이블의 구조 레코드 모두 복제한 emp35 테이블 생성
create table emp35 as select * from emp27;

select * from emp35;

/*
 문제 1) emp35테이블의 모든 사원의 부서번호를 30으로 변경하는 수정문을 작성해 보자.
*/
update emp35 set deptno=30; 

/*
 문제 2) 101사원번호의 부서번호만 20으로 변경해 하는 수정문을 작성하자.
*/
update emp35 set deptno=20 where empno=101;

/* 서브 쿼리문을 사용한 데이터 수정하기 실습을 위한 테이블 생성 */
create table dept(
  deptno number(38) primary key --부서번호
  ,dname varchar2(50) --부서명
  ,LOC varchar2(100) --지역명
);
insert into dept values(10,'경리부','서울');
insert into dept values(20,'영업부','부산');
insert into dept values(30,'관리부','인천');
insert into dept values(40,'연구부','대전');

select * from dept order by deptno asc;

--dept01복제본 테이블 만들기
create table dept01 as select *from dept;

select * from dept01 order by deptno asc;

--서브쿼리문을 검색을 통한 레코드 수정실습)
update dept01
set (dname,LOC) = (select dname,LOC from dept where deptno=40)
where deptno=20;
/*  dept 테이블의 40번 부서번호의 부서명과 부서지역을 검색해서 dept01테이블의 20번 부서의 부서명과 부서지역을 연구부,대전으로 변경
*/
