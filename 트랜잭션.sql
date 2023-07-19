--dept51 테이블 생성
create table dept51(
  deptno number(38) primary key --부서번호
  , dname varchar2(50) -- 부서명
  );
  insert into dept51 values(101,'영업부');
  insert into dept51 values(102,'인사부');
  
  select * from dept51 order by deptno asc;
  
  --dept52 복제본 테이블 생성
  create table dept52 as select * from dept51;
  
  select * from dept52;
  
  delete from dept52;
  rollback;--삭제쿼리문이 취소되어서 레코드 복구됨.
  
  delete from dept52 where deptno=102;
  commit; --삭제문 성공 반영
  rollback; --복구 안됨.
  
  -- auto 커밋 실습을 위한 복제 테이블 dept53을 생성
  create table dept53 as select * from dept51;
  
  select * from dept53;
  
  delete from dept53 where deptno=102;
  
  create table dept_copy53 as select * from dept51; --오토 커밋문 create table을 수행하면 삭제문이 성공반영되어 롤백 처리 안됨.
  
  rollback;
  
  delete from dept53 where deptno=101;
  
  truncate table dddd; --truncate 오토커밋문을 사용해서 전체레코드 삭제가 실패해도 delete문은 성공반영되어 롤백 처리안됨.
  
  rollback;
  
  --savepoint 문 실습을 위한 레코드 4개 저장
  insert into dept53 values(101,'개발부');
  insert into dept53 values(102,'관리부');
  insert into dept53 values(103,'인사부');
  insert into dept53 values(104,'경리부');
  
  select * from dept53;
  
  delete from dept53 where deptno=104;
  commit;
  
  delete from dept53 where deptno=103;
  savepoint c01;
  
  delete from dept53 where deptno=102;
  savepoint c02;
  
  delete from dept53 where deptno=101;
  
  rollback to c02; --c02 세이브 포인트까지 복구 => 101번 사원 복구
  rollback;
  
  /* 락이 걸린 무한대기상태를 만들기 위한 복제본 테이블을 생성*/
  create table dept55
  as
  select * from dept;
  
  select * from dept55;
  
  --truncate 문에 의한 전체 레코드삭제
  truncate table dept55;
  
   rollback; --롤백에 의한 데이터 복구가 안된다.이유는 truncate문 자체가 오토 커밋 문 이기 때문이다.