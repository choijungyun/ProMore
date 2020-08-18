-- desc --
desc member;
desc customer_board;
desc notice;

desc project;
desc project_apply;
desc work;
desc work_reply;
desc reply_like;
desc schedule;

-- select --
select * from member;
select * from customer_board;
select * from notice;
select * from project;
select * from project_apply;
select * from work;
select * from work_reply;
select * from reply_like;
select * from schedule;

select * from notice order by not_num;

-- delete --
delete from member;
delete from customer_board;
delete from notice;

delete from project;
delete from project_apply;
delete from work;
delete from work_reply;
delete from reply_like;
delete from schedule;

-- ���⼭ ���� �״�� ������ �����ؼ� ��ü ���� --
-- drop table --
drop table customer_board;
drop table notice;
drop table project_apply;

drop table reply_like;
drop table work_reply;
drop table schedule;
drop table work;
drop table member;
drop table project;

-- drop sequence --
drop sequence member_mem_num_seq;
drop sequence notice_not_num_seq;
drop sequence customer_board_cus_num_seq;

drop sequence project_pro_num_seq;
drop sequence PROJECT_APL_NO_SEQ;
drop sequence work_work_num_seq;
drop sequence work_reply_reply_num_seq;




-- CREATE TABLE --

-- ȸ�� ���̺� --
CREATE TABLE member (
    mem_num NUMBER(10) PRIMARY KEY,
    mem_id VARCHAR2(20) NOT NULL UNIQUE,
    mem_name VARCHAR2(10) NOT NULL,
    mem_nickname VARCHAR2(20) NOT NULL UNIQUE,
    mem_password VARCHAR2(20) NOT NULL,
    mem_level VARCHAR2(10) NOT NULL,
    mem_phone VARCHAR2(11) NOT NULL,
    mem_email VARCHAR2(30) NOT NULL,
    mem_mailing NUMBER(1) NOT NULL,
    mem_skills VARCHAR2(4000),
    mem_reg_date DATE NOT NULL

);


-- ȸ�� ��ȣ ������ --
CREATE SEQUENCE member_mem_num_seq;



-- ���Խ��� ���̺� --
CREATE TABLE customer_board (
    cus_num NUMBER(10) PRIMARY KEY,
    cus_title VARCHAR2(100) NOT NULL,
    cus_cate VARCHAR2(50) NOT NULL,
    cus_id VARCHAR2(20) NOT NULL,
    cus_date DATE NOT NULL,
    cus_content VARCHAR2(4000) NOT NULL,
    cus_file_name VARCHAR2(200),
    cus_file_path VARCHAR2(200),
    cus_file_size NUMBER(10),
    cus_state NUMBER(1) NOT NULL

    --CONSTRAINT fk_cus_id  FOREIGN KEY(cus_id) REFERENCES member(mem_id)
);


-- �� �Խ��� ��ȣ ������ --
CREATE SEQUENCE customer_board_cus_num_seq;






-- �������� ���̺� --
CREATE TABLE notice (
    not_num NUMBER(10) PRIMARY KEY,
    not_title VARCHAR2(100) NOT NULL,
    not_content VARCHAR2(4000) NOT NULL,
    not_write_date DATE NOT NULL,
    not_file_name VARCHAR2(200),
    not_file_path VARCHAR2(100),
    not_file_size NUMBER(10),
    not_read_count NUMBER(10)
);


-- ���� ��ȣ ������ --
CREATE SEQUENCE notice_not_num_seq;




-- ������Ʈ ���̺� --
CREATE TABLE project(
	pro_num NUMBER(20) PRIMARY KEY,
	pro_name VARCHAR2(100) NOT NULL,
	pro_content VARCHAR2(4000) NOT NULL,
	pro_manager VARCHAR2(30) NOT NULL,
	pro_state NUMBER(10) DEFAULT 0,
	pro_max NUMBER(10) DEFAULT 0,
	pro_cnt NUMBER(10) NOT NULL
);


-- ������Ʈ ��ȣ ������ --
CREATE SEQUENCE project_pro_num_seq;




-- ������Ʈ ��û ���̺� --
CREATE TABLE project_apply(
	apl_no NUMBER(20) PRIMARY KEY,
	apl_num NUMBER(20),
    	apl_mem_ID VARCHAR2(20)
--constraint  fk_apl_num foreign key(apl_num) references project(pro_num),
--constraint fk_apl_mem_id  foreign key(apl_mem_id) references member(mem_id)
);


-- ������Ʈ ��û��ȣ ������ --
CREATE SEQUENCE PROJECT_APL_NO_SEQ;

-- �ϰ� ���̺� --
CREATE TABLE work(
    work_num number(8),
    work_sender varchar2(10) not null,
    work_receiver varchar2(10) not null,
    -- work_sender_id varchar2(10) not null,
    -- work_receiver_id varchar2(10) not null,
    work_subject varchar2(30) not null,
    work_content varchar2(300) not null,
    work_state number(10) not null,
    work_start_date date not null,
    work_end_date date not null,
    work_write_date date not null,
    work_file_name varchar2(200),
    work_file_path varchar2(250),
    work_file_size number(10),
    pro_num number(20) not null,
    
    constraint pk_work_num primary key(work_num),
    constraint fk_pro_num_2 foreign key(pro_num) references project(pro_num)
);

-- �ϰ� ��ȣ ������ --
CREATE SEQUENCE work_work_num_seq;




-- �ϰ���� ���̺� --
CREATE TABLE work_reply (
    reply_num NUMBER(8),
    reply_id VARCHAR2(20) NOT NULL,
    reply_date DATE NOT NULL,
    reply_content VARCHAR2(300) NOT NULL,
    reply_file_name VARCHAR2(200),
    reply_file_path varchar2(250),
    reply_file_size NUMBER(10),
    work_num NUMBER(8) NOT NULL,
    constraint pk_reply_num primary key(reply_num),
    constraint fk_work_num foreign key(work_num) references work(work_num) on delete cascade
);


-- �ϰ� ��� ������ --
CREATE SEQUENCE work_reply_reply_num_seq;

-- ���ƿ� ���̺� --
CREATE TABLE reply_like (
    reply_num NUMBER(4),
    mem_id VARCHAR2(20),
    constraint pk_reply_like primary key (reply_num, mem_id),
    constraint fk_reply_num foreign key(reply_num) references work_reply(reply_num) on delete cascade
);


-- �������� ���̺�(project ���̺���� ����) --
CREATE TABLE schedule (
    sche_num NUMBER(20),
    sche_title VARCHAR2(100) NOT NULL,
    sche_start_date DATE NOT NULL,
    sche_end_date DATE NOT NULL,
    sche_content VARCHAR2(300) NOT NULL,
    pro_num NUMBER(20) NOT NULL,
    constraint pk_sche_num primary key(sche_num),
    constraint fk_pro_num foreign key(pro_num) references project(pro_num)
);


-- insert, update --

-- �������� �߰� --
insert into notice(
			not_num,
			not_title,
			not_content,
			not_write_date,
			not_read_count)
		values(
			notice_not_num_seq.nextval,
			'test ���� ����',
			'test ���� �����Դϴ�.',
			sysdate,
			0);


-- ȸ�� �߰� --
insert into member
values(member_mem_num_seq.nextval, 'testid', 'testname', 'testnickname', '1234', '����', 
        '01012345678', 'testemail@test.com', 1, '���� �̷��̷� ����� �������Դϴ�.', sysdate);
        
insert into member
values(member_mem_num_seq.nextval, 'testid1', 'testname1', 'testnickname1', '1234', '����', 
        '01012345678', 'testemail1@test.com', 1, '���� �̷��̷� ����� �������Դϴ�.', sysdate);
        
insert into member
values(member_mem_num_seq.nextval, 'testid2', 'testname2', 'testnickname2', '1234', '����', 
        '01012345678', 'testemail2@test.com', 1, '���� �̷��̷� ����� �������Դϴ�.', sysdate);
        
insert into member
values(member_mem_num_seq.nextval, 'testid3', 'testname3', 'testnickname3', '1234', '����', 
        '01012345678', 'testemail3@test.com', 1, '���� �̷��̷� ����� �������Դϴ�.', sysdate);


-- ȸ�� ���̵� �׽�Ʈ ���̵�� ���� --
update member set mem_id = 'testid' where mem_num = 1;

