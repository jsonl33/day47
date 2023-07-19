drop table emp;
drop table emp01;
drop table emp02;

/* 테이블 합병 실습을 위한 원본 테이블 만들기 */
create table emp(
 empno number(38) primary key --사원번호
 ,ename varchar2(50) --사원명
 ,job varchar2(50) --부서명
 ,sal number(38) --급여
 ,deptno number(38) --부서번호
  );
  
  insert into emp values(101,'홍길동','개발부',5000,10);
  insert into emp values(102,'이순신','개발부',5000,10);
  insert into emp values(103,'강감찬','디자인부',3000,20);
  
  select * from emp order by empno asc;
  
--emp01 복제본 테이블 생성
create table emp01 as select * from emp;

--개발부서만 레코드만 복제한 emp02테이블 생성
create table emp02 as select * from emp where job='개발부';

select * from emp01;
select * from emp02;

--where 조건문이 없어서 job컬럼 레코드 행값 전체가 test로 변경
update emp02 set job='test';
commit;

--새로운 레코드 하나 저장
insert into emp02 values(104,'을지문덕','top',2000,30);

--두테이블을 합병
merge into emp01
using emp02
on(emp01.empno = emp02.empno)
when matched then --동일 레코드가 있다면 수정
  update set
  emp01.ename = emp02.ename ,
  emp01.job = emp02.job,
  emp01.sal = emp02.sal,
  emp01.deptno = emp02.deptno
  
when not matched then --동일 레코드가 없다면 저장
 insert  values(emp02.empno, emp02.ename, emp02.job, emp02.sal, emp02.deptno);
 
 select * from emp01;
 
 commit;