CREATE TABLE movie (
	movie_num	number,
	m_rank	number	NOT NULL,
	m_title	varchar2(90)	NOT NULL,
	m_titleEng	varchar2(30),
	m_director	varchar2(30),
	m_actor	varchar2(150),
	m_nation	varchar2(30),
	m_company	varchar2(30),
	m_plot	clob,
	m_runtime	number,
	m_rating	varchar2(24),
	m_genre	varchar2(30),
	m_opendate	date,
	m_poster	blob,
	poster_name varchar2(60),
	m_poster2	clob,
	m_stllimg	blob,
	stllimg_name	varchar2(60),
	m_stllimg2	clob,
	m_opendate2 varchar2(10),
	m_date	date	default SYSDATE not null,
	m_vod	clob,
	m_status number not null, -- 1: 상영 / 2: 상영예정 / 3: 상영중지
	constraint movie_pk primary key (movie_num)
);
create sequence movie_seq;

CREATE TABLE review (
	review_num	number,
	movie_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	review_content	varchar2(660)	NOT NULL,
	review_date	date	default SYSDATE NOT NULL,
	review_mdate	date,
	constraint review_pk primary key (review_num),
	constraint review_fk1 foreign key (movie_num) references movie (movie_num),
	constraint review_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence review_seq;


CREATE TABLE review_rating (
	rating_num	number,
	review_num	number	NOT NULL,
	movie_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	rating_score	number(1)	default 5 NOT NULL,
	constraint review_rating_pk primary key (rating_num),
	constraint review_rating_fk1 foreign key (review_num) references review (review_num),
	constraint review_rating_fk2 foreign key (movie_num) references movie (movie_num),
	constraint review_rating_fk3 foreign key (mem_num) references member (mem_num)
);
create sequence review_rating_seq;

CREATE TABLE review_fav (
	review_favnum	number,
	review_num	number	NOT NULL,
	movie_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	constraint review_fav_pk primary key (review_favnum),
	constraint review_fav_fk1 foreign key (review_num) references review (review_num),
	constraint review_fav_fk2 foreign key (movie_num) references movie (movie_num),
	constraint review_fav_fk3 foreign key (mem_num) references member (mem_num)
);
create sequence review_fav_seq;

CREATE TABLE review_report (
	repo_num	number,
	review_num	number	NOT NULL,
	movie_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	repo_date	date	default SYSDATE NOT NULL,
	constraint review_report_pk primary key (repo_num),
	constraint review_report_fk1 foreign key (review_num) references review (review_num),
	constraint review_report_fk2 foreign key (movie_num) references movie (movie_num),
	constraint review_report_fk3 foreign key (mem_num) references member (mem_num) 
);
create sequence review_report_seq;

CREATE TABLE moviepost (
	post_num	number,
	movie_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	post_content	clob	NOT NULL,
	post_date	date	default SYSDATE NOT NULL,
	post_mdate	date,
	post_photo	blob	NOT NULL,
	post_title	varchar2(90)	NOT NULL,
	constraint moviepost_pk primary key (post_num),
	constraint moviepost_fk1 foreign key (movie_num) references movie(movie_num),
	constraint moviepost_fk2 foreign key (mem_num) references member(mem_num)
);
create sequence moviepost_seq;

CREATE TABLE post_reply (
	re_num	number,
	post_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	re_content	varchar2(300)	NOT NULL,
	re_date	date	default SYSDATE NOT NULL,
	re_mdate	date	NULL,
	constraint post_reply_pk primary key (re_num),
	constraint post_reply_fk1 foreign key (post_num) references moviepost (post_num),
	constraint post_reply_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence post_reply_seq;

CREATE TABLE post_fav (
	post_favnum	number,
	post_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	constraint post_fav_pk primary key (post_favnum),
	constraint post_fav_fk1 foreign key (post_num) references moviepost (post_num),
	constraint post_fav_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence post_fav_seq;

CREATE TABLE post_report (
	repo_post_num	number,
	post_num	number	NOT NULL,
	mem_num	number	NOT NULL,
	repo_post_dated	date	default SYSDATE NOT NULL,
	constraint post_report_pk primary key (repo_post_num),
	constraint post_report_fk1 foreign key (post_num) references moviepost (post_num),
	constraint post_report_fk2 foreign key (mem_num) references member (mem_num)
);
create sequence post_report_seq;