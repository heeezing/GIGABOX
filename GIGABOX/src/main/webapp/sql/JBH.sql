create table member(
 mem_num number,
 id varchar2(12) not null,
 auth number(1) default 2 not null,
 nick_name varchar2(30),
 constraint member_pk primary key (num)
);

create table member_detail(
 mem_num number,
 name varchar2(10) not null,  
 passwd varchar2(25) not null,
 phone varchar2(15) not null,
 email varchar2(50) not null,
 zipcode varchar2(90) not null,
 address1 varchar2(90) not null,
 address2 varchar2(90) not null,
 reg_date date default sysdate not null,
 au_id varchar2(36) unique,
 membership_id number not null,
 photo blob,
 photo_name varchar2(100),
 constraint member_detail_pk primary key (num),
 constraint member_detail_fk1 foreign key (num) references member (num),
 constraint member_detail_fk2 foreign key (membership_id) references membership (membership_id)
);
create sequence member_seq;