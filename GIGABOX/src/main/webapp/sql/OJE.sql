-- 극장
create table theater(
 th_num number,
 th_name varchar2(30) not null,
 th_address varchar2(200) not null,
 th_phone varchar2(14) not null,
 th_photo blob not null,
 th_photoname varchar2(150) not null,
 constraint theater_pk primary key (th_num)
);
create sequence theater_seq;

-- 상영관
create table hall(
 hall_num number,
 hall_name varchar2(90) not null,
 hall_status number(1) default 2 not null,
 seats number not null,
 th_num number not null,
 constraint hall_pk primary key (hall_num),
 constraint hall_fk foreign key (th_num) references theater (th_num)
);
create sequence hall_seq;