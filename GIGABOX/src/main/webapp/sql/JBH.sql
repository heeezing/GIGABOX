create table member(
 mem_num number,
 mem_id varchar2(12) not null,
 mem_auth number(1) default 2 not null,
 mem_nickname varchar2(30),
 constraint member_pk primary key (mem_num)
);

create table member_detail(
 mem_num number,
 mem_name varchar2(10) not null,
 mem_passwd varchar2(25) not null,
 mem_phone varchar2(15) not null,
 mem_email varchar2(50) not null,
 mem_zipcode varchar2(90) not null,
 mem_address1 varchar2(90) not null,
 mem_address2 varchar2(90) not null,
 mem_reg_date date default sysdate not null,
 mem_au_id varchar2(36) unique,
 membership_id number not null,
 constraint member_detail_pk primary key (mem_num),
 constraint member_detail_fk1 foreign key (mem_num) references member (mem_num),
 constraint member_detail_fk2 foreign key (membership_id) references membership (membership_id)
);
create sequence member_seq;