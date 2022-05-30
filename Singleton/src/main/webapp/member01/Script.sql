create table member01 (
    id varchar2(50) primary key,	-- 메일 주소
    passwd varchar2(60) not null,	-- 암호화 해서 DB 저장
    name varchar2(20) not null,
    reg_date date default sysdate not null,
    address varchar2(100) not null,
    tel varchar2(20) not null
    );