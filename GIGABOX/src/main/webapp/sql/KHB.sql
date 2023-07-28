CREATE TABLE membership_order(
 order_num number NOT NULL,
 mem_num number	NOT NULL,
 membership_id number NOT NULL,
 price number NOT NULL,
 pay_type varchar2(45) NOT NULL,
 pay_date date NOT NULL,
 next_pay_date date NOT NULL,
 billing_key varchar2(300) NOT NULL,
 result_status varchar2(45) NOT NULL,
 result_message	varchar2(300) NOT NULL,
 constraint membership_order_pk primary key (order_num),
 constraint membership_order_fk1 foreign key (mem_num) 
									references member (mem_num),
 constraint membership_order_fk2 foreign key (membership_id) 
									references membership (membership_id)
);

create sequence membership_order_seq;

CREATE TABLE membership(
 membership_id number NOT NULL,
 membership_grade varchar2(45) DEFAULT basic NOT NULL,
 membership_detail varchar2(300) NOT NULL,
 price number NOT NULL,
 constraint membership_pk primary key (membership_id)
);
create sequence membership_seq;