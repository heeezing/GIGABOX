--상영 시간표
create table schedule(
	sch_num number,
	sch_date date not null,
	sch_start varchar2(30) not null,
	sch_end varchar2(30) not null,
	remain number not null,
	hall_num number not null,
	movie_num number not null,
	constraint schedule_pk primary key (sch_num),
	constraint schedule_fk1 foreign key (hall num) references hall (hall_num),
	constraint schedule_fk2 foreign key (movie_num) references movie (movie_num)
);
create sequence schedule_seq;

--좌석
create table seat(
	seat_num number,
	seat_name varchar2(30) not null,
	seat_status number(1) not null,
	hall_num number not null
	constraint seat_pk primary key (seat_num),
	constraint seat_fk1 foreign key (hall_num) references hall (hall_num)
);
create sequence seat_seq;

--예매
create table reservation(
	res_num number,
	res_date date default sysdate not null,
	del_date date,
	res_people number(3) not null,
	res_payment varchar2(50) not null,
	res_total number(10) not null,
	res_status number(1) not null,
	sch_num number not null,
	seat_num number not null,
	mem_num number not null,
	constraint reservation_pk primary key (res_num),
	constraint reservation_fk1 foreign key (sch_num) references schedule (sch_num),
	constraint reservation_fk2 foreign key (seat_num) references seat (seat_num),
	constraint reservation_fk3 foreign key (mem_num) references member (mem_num)
);
create sequence reservation_seq;