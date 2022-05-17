drop table member;

create table member (
    id varchar2(100) not null constraint PK_member_id primary key,
    password varchar2(100) null,
    name varchar2(100) null
    );
    
insert into member values('1', '1234', '홍길동');
insert into member values('2', '1235', '이순신');

commit;

select * from member;