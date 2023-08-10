--스낵 상품
CREATE TABLE snack(
	sn_num number,
	sn_name	varchar2(60) NOT NULL,
	sn_detail varchar2(100) NOT NULL,
	sn_price number(6)	NOT NULL,
	sn_dc_price	number(6),
	sn_photo blob NOT NULL,
	sn_photo_name varchar2(100)	NOT NULL,
	sn_info	varchar2(300) NOT NULL,
	sn_category	number(1) NOT NULL,
	sn_reg_date	date DEFAULT SYSDATE NOT NULL,
	sn_modify_date date,
	sn_status number(1) NOT NULL,
	sn_notice clob 
	constraint snack_pk primary key (sn_num)
);

CREATE SEQUENCE snack_seq;


--장바구니
CREATE TABLE cart (
	cart_num number,
	mem_num	number NOT NULL,
	sn_num number NOT NULL,
	orders_quantity number(2) NOT NULL,
	reg_date date DEFAULT SYSDATE NOT NULL,
	constraint cart_pk primary key (cart_num),
	constraint cart_fk1 foreign key (mem_num) references member (mem_num),
	constraint cart_fk2 foreign key (sn_num) references snack (sn_num)
);

CREATE SEQUENCE cart_seq;


--주문
CREATE TABLE orders (
	orders_num number,
	mem_num	number NOT NULL,
	sn_name	varchar2(60) NOT NULL,
	sn_photo blob NOT NULL,
	orders_total number(9) NOT NULL,
	payment	number(1) NOT NULL,
	orders_type number(1) NOT NULL,
	orders_status number(1) NOT NULL,
	orders_date date DEFAULT SYSDATE NOT NULL,
	valid_date date DEFAULT add_months(SYSDATE-1,12) NOT NULL,
	modify_date date,
	billing_key	varchar2(300),
	to_id varchar2(12),
	to_phone varchar2(15),
	message	varchar2(300),
	constraint orders_pk primary key (orders_num),
	constraint orders_fk foreign key (mem_num) references member (mem_num)
);

CREATE SEQUENCE orders_seq;


--주문상세
CREATE TABLE orders_detail (
	detail_num number,
	orders_num number NOT NULL,
	sn_num number NOT NULL,
	sn_name	varchar2(60) NOT NULL,
	sn_photo blob NOT NULL,
	sn_detail varchar2(100)	NOT NULL,
	sn_price number(6) NOT NULL,
	sn_dc_price number(6),
	sn_total number(8) NOT NULL,
	orders_quantity varchar2(2) NOT NULL,
	constraint orders_detail_pk primary key (detail_num),
	constraint orders_detail_fk1 foreign key (orders_num) references orders (orders_num)
);

CREATE SEQUENCE detail_seq;


--포인트
CREATE TABLE point (
	pt_num number,
	res_num number,
	orders_num number,
	mem_num	number NOT NULL,
	pt_date	date DEFAULT SYSDATE NOT NULL,
	add_point number DEFAULT 0 NOT NULL,
	use_point number DEFAULT 0 NOT NULL,
	constraint point_pk primary key (pt_num),
	constraint point_fk1 foreign key (res_num) references reservation (res_num),
	constraint point_fk2 foreign key (orders_num) references orders (orders_num),
	constraint point_fk3 foreign key (mem_num) references member (mem_num)
);

CREATE SEQUENCE point_seq;
