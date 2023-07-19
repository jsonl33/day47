--기본키인 primary key와 not null 제약조건 실습을 위한 테이블 생성
create table dept60(
  deptno number(38) primary key --부서 번호
  ,dname varchar2(50) not null --부서명
  ,LOC varchar2(100)  --부서지역
  );
  
  insert into dept60 values(10,'영업부','서울');
  insert into dept60 values(10,'영업부 부산사무소','부산'); -- deptno컬럼에 동일 부서번호를 저장할려다가 무결성 제약조건 위배에러가 나
  --서 저장할 수 없다. 이유는 기본키로 설정되어서 중복 부서번호를 저장할 수 없다.
  
  insert into dept60 values(20, null, '서울');  --dname컬럼이 not null 제약조건으로 설정되어서 null을 저장할 수 없다.
  
  /*dept60테이블의 제약조건이름, 제약조건 유형,제약조건이 속한 테이블 명을 확인  */
  select constraint_name, constraint_type, table_name from user_constraints where table_name in('DEPT60');
  --제약조건 유형에서 C는 NOT NULL과 CHECK제약조건을 의미하고, P는 Primary key즉 기본키 제약조건을 의미한다.
  --오라클에서 기본으로 제공하는 SYS C숫자번호 형태의 제약조건이름이 지정된다.
  --in연산의 영문 테이블명은 반드시 영문대문자로 해야 검색된다. 이유는 영문자 레코드는 대소문자를 구분한다. sql문은 대소문자를 구분
  --하지 않는다.
  
  
  /* not null제약조건 실습을 위한 테이블 생성 */
  create table emp101(
    empno number(38) -- null제약조건 ,사원번호
    ,ename varchar2(50)  --사원명
    ,job varchar2(20)  --직종
    ,deptno number(38) --부서번호
  );
  
  insert into emp101 values(null,null,'영업부',20);
  select * from emp101;
  
  create table emp102(
    empno number(20) not null
    ,ename varchar2(50) not null
    ,job varchar2(50)
    ,deptno number(38)
    );
   insert into emp102 values(null,null,'관리부',10);
   --not null제약조건으로 설정된 컬럼에 null저장금지
   
   insert into emp102 values(501,'이순신','관리부',10);
   select * from emp102;
   
   /* 테이블 컬럼을 정의할 때 사용하는 unique 제약조건 특징)
       1.특정 컬럼에 자료가 중복되지 않게 한다.
       2.null 저장되는 것은 허용한다.
       3.중복 자료에서 null은 체크하지 않는다. 즉 null은 중복을 허용하는 특징이 있다.
   */
   --unique제약조건 실습을 위한 테이블 생성
   create table emp103(
     empno number(10) unique
     ,ename varchar2(30) not null
     ,job varchar2(30)
     ,deptno number(38)
   );
   insert into emp103 values(502,'홍길동','인사부',40);
   insert into emp103 values(502,'이순신','영업부',30); --동일 중복 부서번호 저장안된다.이유는 해당 컬럼 empno가 unique제약조건으로
   --설정 되었기 때문이다.
   select * from emp103;
   
   insert into emp103 values(null,'강감찬','관리부',50);
   insert into emp103 values(null,'신사임당','개발부',60);
   --unique제약조건으로 설정된 컬럼에 null저장 허용하고,중복도 허용한다.
   
   --constraint 키워드로 사용자 정의 제약조건명을 지정해서 만들어 봄
   create table emp105(
     empno number(38) constraint emp105_empno_uk unique
     ,ename varchar2(50) constraint emp105_ename_nn not null
     ,job varchar2(50)
     ,deptno number(38)
   );
   /*  사용자 정의 제약조건명 지정방법)
       테이블명_컬럼명_제약조건유형
       emp105_empno_uk와 emp105_ename_nn이 바로 사용자 정의 제약조건명이다.
   */
   --emp105테이블의 제약조건명이 생성된 테이블명, 제약조건이름을 확인
   select table_name,constraint_name from user_constraints where table_name in('EMP105');
   
   --사원번호를 기본키로 가지는 EMP106테이블 생성)
   create table emp106(
    empno number(38) constraint emp106_empno_pk primary key
    , ename varchar2(50) constraint emp106_ename_nn not null
    ,job varchar2(50)
    ,deptno number(38)
    );
    
    insert into emp106 values(201,'강감찬','관리부',10);
    insert into emp106 values(201,'이순신','영업부',20);
    --중복사원번호는 저장 안된다. 
    
    /*
      참조 무결성을 위한 외래키 제약조건 실습)
       1.기본키로 설정된 부모 즉 주인테이블 dept71부터 먼저 만든다.
       2.dept71 부모 테이블부터 먼저 자료를 저장한다.
    */
    create table dept71(
     deptno number(38) constraint dept71_deptno_pk primary key --부서번호
     ,dname varchar2(100) constraint dept71_dname_nn not null --부서명
     ,LOC varchar2(50) --부서지역
     );
     
     drop table dept71;
     insert into dept71 values(10,'관리부','서울');
     insert into dept71 values(20,'영업부','부산');
     insert into dept71 values(30,'개발부','판교');
     
     select * from dept71 order by deptno asc;
     
     /* 외래키(foreign key) 제약조건 특징)
       1. dept71테이블의 기본키로 설정된 deptno컬럼을 참조하고 있다.
       2. dept71 테이블의 deptno컬럼에 저장된 부서번호만 외래키로 설정된 컬럼 자료값으로 저장된다. 이것이 곧 참조 무결성이다.
       이것이 가능한 것은 주종관계이기 때문이다.
     */
     
     --외래키가 포함된 종속테이블  emp71을 생성
     create table emp71(
       empno number(38) constraint emp71_empno_pk primary key --사원번호
       ,ename varchar2(50) constraint emp71_ename_nn not null --사원명
       ,job varchar2(50) --직종
       ,deptno number(38) constraint emp71_deptno_fk references dept71(deptno) --외래키 설정
     );
     
     insert into emp71 values(11,'홍길동','관리사원',10);
     insert into emp71 values(12,'이순신','영업사원',20);
     
     select * from emp71 order by empno asc;
     
     insert into emp71 values(13,'강감찬','기획사원',50);
     /* 무결성 제약조건 위배 에러가 발생해서 레코드가 저장 안된다. 이유는 부모 테이블 dept71의 기본키 컬럼인 deptno에 부서번호가 없기
     때문이다.
     */
     
     select table_name, constraint_type, constraint_name, r_constraint_name from user_constraints
     where table_name in('DEPT71','EMP71');
     /*  1.  table_name 컬럼: 제약조건명이 지정된 테이블명
         2. constraint_type : 제약조건 유형
         3. constraint_name : 제약조건 이름
         4. r_constraint_name : 외래키가 어느 기본키를 참조하고 있는가에 대한 정보         
     */
     
     /* 문제) 주종관계인 dept71과 emp71 두 테이블의 공통 컬럼인 deptno를 기준으로 미국 표준협회 ANSI Inner JOIN문을 만들어 보자*/
     select * from dept71 inner join emp71 on dept71.deptno = emp71.deptno;
     
     