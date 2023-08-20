
-------------------이벤트---------------------
CREATE TABLE  event  ( 
	 event_num 	number,
	 mem_num number NOT NULL,
	 category_num 	number NOT NULL,
	 category_detail_num 	number	NULL,
	 event_form_type number NULL,
	 thumb1		blob not null,
	 thumb1_name varchar2(150)	NOT NULL, 
	 thumb2		blob not null,
	 thumb2_name	varchar2(150)	NOT NULL,
	 title 	varchar2(150)	NOT NULL,
	 content 	clob  NOT NULL,-- CKeditor 통해서 값 가져오기 
	 event_start 	date	DEFAULT SYSDATE NOT NULL,
	 event_end 	date	DEFAULT SYSDATE NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	DEFAULT SYSDATE,
	 state 	number	NOT NULL,
	 count number DEFAULT 0 NULL,--조회수
	CONSTRAINT event_pk PRIMARY KEY (event_num), 
	CONSTRAINT event_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT event_fk2 FOREIGN KEY (category_num) REFERENCES event_category (category_num),
	CONSTRAINT event_fk3 FOREIGN KEY (category_detail_num) REFERENCES event_category_detail(category_detail_num)
);
CREATE sequence event_seq;

CREATE TABLE  event_category  ( --이벤트 카테고리 테이블
	category_num 	number,
	category_name 	varchar2(150)	NOT NULL,
	CONSTRAINT event_category_pk PRIMARY KEY (category_num)
);
CREATE sequence event_category_seq;

CREATE TABLE  event_category_detail  ( --이벤트 카테고리 디테일 테이블
	category_num 	number,
	category_name 	varchar2(150)	NOT NULL,
	CONSTRAINT event_category_detail_pk PRIMARY KEY (category_detail_num)
);
CREATE sequence event_category_detail_seq;

CREATE TABLE  event_result  (
	 result_num 	number,
	 mem_num number NOT NULL,
	 event_num 	number NOT NULL,
	 title 	varchar2(150)	NOT NULL,
	 content 	varchar2(4000)	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	DEFAULT SYSDATE,
	CONSTRAINT event_result_pk PRIMARY KEY (result_num),
	CONSTRAINT event_result_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
 	CONSTRAINT event_result_fk2 FOREIGN KEY (event_num) REFERENCES event (event_num)
);

CREATE sequence event_result_seq;

CREATE TABLE  event_reply  (
	 reply_num 	number,
	 mem_num 	number	NOT NULL,
	 th_num		number 	NOT NULL,
	 event_num 	number	NOT NULL,
     content 	varchar2(600)	NOT NULL,
	 --parent 	number	NOT NULL,
	 --depth 	number	NOT NULL,
	 ip 	varchar2(15)	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	DEFAULT SYSDATE
	CONSTRAINT event_reply_pk PRIMARY KEY (reply_num),
	CONSTRAINT event_reply_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT event_reply_fk2 FOREIGN KEY (th_num) REFERENCES theater (th_num),
	CONSTRAINT event_reply_fk3 FOREIGN KEY (event_num) REFERENCES event (event_num)
	
);
CREATE sequence event_reply_seq;

/* 생략.
CREATE TABLE  event_parti  (
	 parti_num 	number,
	 mem_num 	number	NOT NULL,
	 event_num 	number	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 result 	number(1)	NULL,
	CONSTRAINT event_parti_pk PRIMARY KEY (parti_num),
	CONSTRAINT event_parti_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT event_parti_fk2 FOREIGN KEY (event_num) REFERENCES event (event_num)
);
CREATE sequence event_parti_seq;

**/
-------------------고객센터---------------------

CREATE TABLE  cs_qna  (--자주 묻는 질문
	 qna_num 	number,
	 mem_num number NOT NULL,
	 category_num 	number(1)	NOT NULL,
	 title 	varchar2(150)	NOT NULL,
	 content 	clob	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	NULL,
	CONSTRAINT cs_qna_pk PRIMARY KEY (qna_num),
	CONSTRAINT cs_qna_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT cs_qna_fk2 FOREIGN KEY (category_num) REFERENCES cs_qna_category (category_num)	
);
CREATE sequence cs_qna_seq;

CREATE TABLE cs_qna_category (
    category_num number,
    category_name varchar2(150) not null,
    CONSTRAINT category_pk PRIMARY KEY (category_num)
);
CREATE sequence cs_qna_category_seq;

CREATE TABLE  cs_noti  (
	 noti_num 	number,
	 mem_num number NOT NULL,
	 th_num 	number	NOT NULL, ---0:고객센터  1:본사 2~:영화관
	 title 	varchar2(150)	NOT NULL,
	 content 	clob	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	NULL,
	CONSTRAINT cs_noti_pk PRIMARY KEY (noti_num),
	CONSTRAINT cs_noti_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT cs_noti_fk2 FOREIGN KEY (th_num) REFERENCES theater (th_num)
	);
CREATE sequence cs_noti_seq;

CREATE TABLE  cs_personal ( --1:1문의는 회원만 할 수 있도록 만든다. 
	 personal_num 	number,
	 mem_num number NOT NULL,
	 th_num 	number NOT NULL, --0:고객센터  1:본사 2~:영화관
	 category_num 	number	NOT NULL,
	 email varchar2(50) NOT NULL,
	 title 	varchar2(150)	NOT NULL,
	 content 	varchar2(4000)	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	NULL,
	 state 	number(1)	NOT NULL,
	CONSTRAINT cs_personal_pk PRIMARY KEY (personal_num),
	CONSTRAINT cs_personal_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT cs_personal_fk2 FOREIGN KEY (th_num) REFERENCES theater (th_num),
	CONSTRAINT cs_personal_fk3 FOREIGN KEY (category_num) REFERENCES cs_personal_category (category_num)
);
CREATE sequence cs_personal_seq;

CREATE table cs_file(
	file_num number,
	personal_num number NOT NULL,
	origin_name varchar2(150) NOT NULL,
	save_name varchar2(150) NOT NULL,
	file_size number NOT NULL,
	delete_yn number(1) NOT NULL,
	created_date date NOT NULL,
	deleted_date date,
	CONSTRAINT cs_file_pk PRIMARY KEY (file_num),
	CONSTRAINT cs_file_fk1 FOREIGN KEY (personal_num) REFERENCES cs_personal (personal_num)
);

CREATE sequence cs_file_seq;

CREATE TABLE cs_personal_category (
    category_num number,
    category_name varchar2(150),
    CONSTRAINT personal_category_pk PRIMARY KEY (category_num)
);

CREATE TABLE  cs_answer  (
	 answer_num 	number,
	 mem_num number NOT NULL, -- 작성자의 mem_num
	 personal_num 	number	NOT NULL,
	 title 	varchar2(150)	NOT NULL,
	 content 	varchar2(4000)	NOT NULL,
	 reg_date 	date	DEFAULT SYSDATE NOT NULL,
	 modify_date 	date	NULL,
	CONSTRAINT cs_answer_pk PRIMARY KEY (answer_num),
	CONSTRAINT cs_answer_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT cs_answer_fk2 FOREIGN KEY (personal_num) REFERENCES cs_personal (personal_num),
);
CREATE sequence cs_answer_seq;
