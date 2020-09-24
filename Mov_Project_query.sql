CREATE TABLE MOV_USER(
USER_CODE NUMBER(8) PRIMARY KEY, --60���� �����ϴ� ���ڸ� ������
USER_ID VARCHAR2 (20) UNIQUE,
USER_NICK VARCHAR2(35) UNIQUE,
USER_PWD VARCHAR2(35) NOT NULL,
USER_TEL NUMBER(20) NOT NULL,
USER_ADDR VARCHAR2(50),
USER_ADDR2 VARCHAR2(100),
USER_EMAIL VARCHAR2(50),
USER_BIRTH DATE
);

create sequence seq_revboard 
increment by 1;
 
CREATE TABLE MOV_REVBOARD(
REV_NUM NUMBER(8) PRIMARY KEY, --�������� 1����
REV_TITLE VARCHAR2(80) NOT NULL,
USER_CODE NUMBER(8) NOT NULL,
REV_WRITEDATE DATE DEFAULT SYSDATE,
REV_HIT NUMBER DEFAULT 0 NOT NULL,
REV_LIKE NUMBER DEFAULT 0 NOT NULL,
REV_DISLIKE NUMBER DEFAULT 0 NOT NULL,
REV_FILE VARCHAR2(50),
MOV_CODE NUMBER(8) NOT NULL
);

create sequence seq_replyboard
increment by 1;

CREATE TABLE MOV_REPLYBOARD(
	REPLY_NUM NUMBER(8) PRIMARY KEY, -- �̰͵� �׳� �������� 1����
REV_NUM NUMBER(8) NOT NULL,
REPLY_CONTENT VARCHAR(1000) NOT NULL,
USER_CODE NUMBER(8) NOT NULL,
REPLY_LIKE NUMBER DEFAULT 0 NOT NULL,
REPLY_DISLIKE NUMBER DEFAULT 0 NOT NULL
);

drop sequence seq_revboard;

create sequence seq_revboard
start with 60001000
increment by 1;


CREATE TABLE MOV_LIKE(
	LIKE_CODE NUMBER(10) PRIMARY KEY, --��������(����� ����??)
	USER_CODE NUMBER(8) NOT NULL,
	REV_NUM NUMBER(8) NOT NULL,
	REPLY_NUM NUMBER(8) NOT NULL,
	LIKE_REV_YN CHAR(1) DEFAULT '0' NOT NULL,
LIKE_REPLY_YN CHAR(1) DEFAULT '0' NOT NULL
);

drop table MOV_LIKE;

CREATE TABLE MOV_LIKE(
	LIKE_CODE NUMBER(10) PRIMARY KEY, --��������(����� ����??)
	USER_CODE NUMBER(8) NOT NULL,
	REV_NUM NUMBER(8) NOT NULL,
	REPLY_NUM NUMBER(8) NOT NULL,
	LIKE_REV_YN CHAR(1) DEFAULT '0' NOT NULL,
LIKE_REPLY_YN CHAR(1) DEFAULT '0' NOT NULL
);

commit;

CREATE TABLE MOV_STAR(
	MOV_CODE NUMBER(8)  PRIMARY KEY, 
	STAR_SUM NUMBER DEFAULT 0 NOT NULL,
	STAR_COUNT NUMBER DEFAULT 0 NOT NULL
);

CREATE TABLE MOV_STAR_LOG(
	MOV_CODE NUMBER(8), --seq_movcode
	USER_CODE NUMBER(8), --seq_user
	STAR_SCORE FLOAT NOT NULL,
	CONSTRAINT STAR_LOG_PK PRIMARY KEY(MOV_CODE, USER_CODE)
);

CREATE TABLE MOV_ADMIN(
	ADMIN_CODE NUMBER PRIMARY KEY, -- ���������� �׳� �ο�(4�ڸ�)
	ADMIN_ID VARCHAR2(20) UNIQUE,
	ADMIN_PWD VARCHAR2(35) NOT NULL,
	ADMIN_NICK VARCHAR2(30) NOT NULL
);

create sequence seq_noticeboard
increment by 1;

CREATE TABLE MOV_NOTICEBOARD(
	NOTICE_NUM NUMBER PRIMARY KEY, --�׳� ��������
	NOTICE_TITLE VARCHAR2(100) NOT NULL,
	ADMIN_NICK VARCHAR2(30) NOT NULL,
	NOTICE_CONTENT VARCHAR2(1000) NOT NULL,
	NOTICE_WRITEDATE DATE DEFAULT SYSDATE NOT NULL,
	NOTICE_HIT NUMBER DEFAULT 0 NOT NULL,
	NOTICE_FILE VARCHAR2(50)
);

create sequence seq_movcode
start with 1000
increment by 1;


CREATE TABLE MOV_INFO(
	MOV_CODE NUMBER(8) PRIMARY KEY, --10���� �����ϴ� 4�ڸ� ����.  ������
	MOV_NAME VARCHAR2(50) NOT NULL,
	MOV_SUMMARY VARCHAR2(1000) NOT NULL,
	MOV_OPENDATE DATE,
	MOV_RUNTIME NUMBER,
	MOV_AGE VARCHAR2(30),
	MOV_GENRE VARCHAR2(30),
	MOV_DIRECTOR VARCHAR2(30),
	MOV_ACTOR1 VARCHAR2(30),
	MOV_ACTOR2 VARCHAR2(30),
	MOV_ACTOR3 VARCHAR2(30),
	MOV_COUNTRY VARCHAR2(30),
MOV_POSTER VARCHAR2(50),
MOV_STAR_AVG FLOAT DEFAULT 0.0 NOT NULL
);

create sequence seq_movdetail
start with 2000
increment by 1;

CREATE TABLE MOV_DETAIL(
	MOV_DETAIL_CODE NUMBER(8) PRIMARY KEY, --20���� �����ϴ� 4�ڸ� ����. ������
	MOV_TYPE VARCHAR2(10) NOT NULL,
	MOV_CODE NUMBER(8) NOT NULL
);


create sequence seq_reserve
start with 10000000000
increment by 1;

select * from mov_revBoard;
select * from mov_replyBoard;
insert into mov_revBoard values(1,'woong','6000',sysdate,0,0,0,null,1000);
commit;
select rownum rn, r.* from mov_replyboard r;
select rownum rn, r.* from mov_replyboard r where rev_num=1;
select * from mov_seat;

ALTER TABLE MOV_REVBOARD ADD REV_CONTENT VARCHAR(1000) DEFAULT '' NOT NULL;
ALTER TABLE MOV_REPLYBOARD ADD REPLY_WRITEDATE VARCHAR(1000) DEFAULT SYSDATE NOT NULL;

CREATE TABLE MOV_RESERVE(
	RESERVE_CODE NUMBER(12) PRIMARY KEY, --������(12�ڸ� 1000-0000-0000)
	MOV_DETAIL_CODE NUMBER(8) NOT NULL,
	SCHEDULE_CODE NUMBER(10) NOT NULL,
	RESERVED_TIME TIMESTAMP NOT NULL,
	USER_CODE NUMBER(8) NOT NULL,
	BOOKED_SEAT_CODE NUMBER(12) NOT NULL,
	PRICE_CODE NUMBER NOT NULL,
	THEATER_CODE NUMBER NOT NULL,
	PERSON_TYPE VARCHAR2(30) NOT NULL,
	RESERVE_GROUP_CODE NUMBER(12)
			--�⵵-��¥-�б���?? ���α׷������� �ð� �̾Ƽ� �Է��ϴ°ɷ�?
);

CREATE TABLE MOV_RESERVE_LOG(
	RESERVE_CODE NUMBER(12) PRIMARY KEY,
	USER_CODE NUMBER(8),
	RESERVE_GROUP_CODE NUMBER(12),
	RESERVED_TIME TIMESTAMP NOT NULL,
	CANCEL_TF number(1) DEFAULT 0,
	CANCELED_TIME TIMESTAMP
);

create sequence seq_schedule
start with 30000000
increment by 1;

CREATE TABLE MOV_SCHEDULE(
	SCHEDULE_CODE NUMBER(8) PRIMARY KEY, --30���� �����ϴ� 8�ڸ� ����. ������
	SCHEDULE_DATE TIMESTAMP  NOT NULL,
	THEATER_CODE NUMBER(4) NOT NULL,
	MOV_DETAIL_CODE NUMBER(8) NOT NULL
);

CREATE TABLE MOV_BOOKED_SEAT(
	BOOKED_SEAT_CODE NUMBER(12) PRIMARY KEY,
	SCHEDULE_CODE NUMBER(8) NOT NULL,
	MOV_SEAT_CODE NUMBER NOT NULL,
	BOOKED_TF number(1) DEFAULT 0
);

create sequence seq_movseat
start with 100
increment by 1;

CREATE TABLE MOV_SEAT(
	MOV_SEAT_CODE NUMBER PRIMARY KEY, --3�ڸ� ���� 100���� ������
	THEATER_CODE NUMBER NOT NULL, -- 1��~5�� ���ڸ� �ֱ�
	SEAT_NUM VARCHAR2(10) NOT NULL -- a1~a10 ��� ���� 80~100�� ����
);


CREATE TABLE MOV_PRICE(
	PRICE_CODE VARCHAR2(4) PRIMARY KEY, --�׳� ���������� ���ڷ� �Է�
	PRICE NUMBER NOT NULL,
	MOV_TYPE VARCHAR2(10) NOT NULL,
	PERSON_TYPE VARCHAR2(15) NOT NULL
);

DESC MOV_SEAT;



select * from mov_info;

insert into mov_info values (seq_movcode.nextval, 
'��!����',
'��ȭ�ο� �ݻ� ����. 
�Ұ��� ���ݿ� ���� ����� �߰ſ� ''�ο�''(������)���� 
�ϳ����� �� ''����''�� ���Ҵ� ��� ���ߴٴ� ûõ���� ���� �ҽ��� ��������. 
�Դٰ� ������ ������ ����ڴ�
����� ���������ϴ� ���� ''����''(������)�� �п� ¢�⸸ �ϴ� �� ''����''��.

�ǽ� �Ҹ� ���·� ������ �ִ� ''����''.
���� ���翡 ������ ���� ''�ο�''�� ���� ���� Ÿ����.  
������ ����ġ ���� ���� ���� ''����''�� ����� �ܼ��� ����س��� 
''�ο�''�� ���Ͽ� �Բ� ��η��� ������ ���� ���ҴϹ��� ã�� ������ �����ϴµ�!',
to_date('2020-09-02','YYYY-MM-DD'),
110,
'12�� �̻�',
'�ڹ̵�',
'������',
'������',
'������',
null,
'�ѱ�',
'/mov_poster/��!����.jpg',
9.2);

insert into mov_info values (seq_movcode.nextval, 
'�� ����Ʈ',
'�ʴ��� �������� ����(������ �����Ͻ� ��)�� �ϸ��߳�(�Ⱦ� ���Ϸ����� ��), ��(���� ��ư ��),
�κ�����(� �ڰ� ��)�� ��� �ü��� ����Ǿ� �ɸ� ���¸� ���� �޴´�.
�̵��� ��ȸ���� ���� �����ο��Ե� ������ ������ �����ϴ� ���� ������(�ٸ��� ��� ��)��
�̵鿡�� �������� �ɷ��� �����ϴ� ����� �������ְ��� �־���.

��� ��, ������� ��ģ �������� ȥ�� ��Ƴ��� ���(��� ��Ʈ ��)�� �̰��� ������
������ �ϵ��� �������� �����ϰ�,
�ڽŵ��� ���� �η����ϰ� �ٷ� �� ������ �ʴ� �������̵��� �ϱ��� �ʴ� ������ �ϸ�
�ڽŵ��� �ɷ��� �����ϱ� �����ϴµ���',
to_date('2020-09-10','YYYY-MM-DD'),
94,
'15�� �̻�',
'�׼�',
'���� ��',
'������ �����Ͻ�',
'�Ⱦ� ���Ϸ� ����',
'���� ��ư',
'�̱�',
'/mov_poster/������Ʈ.jpg',
8.1);

--1009
insert into mov_info values (seq_movcode.nextval,
'����̺�',
'���� �ǹ̶�� ���� ���ǵ�ۿ� ������ �� ����,
���� �ϻ� ���� ������ ����Ų �� ����.

����� �� �ϳ��� �ǹ̰� �� �׳డ ����������
�׳ฦ ��Ű�� ���� �״� ��� ���� �Ŵµ���',
to_date('2020-09-03','YYYY-MM-DD'),
100,
'19�� �̻�',
'�׼�',
'���ݶ� ���� ����',
'���̾� ����',
'ĳ�� �ָ���',
'�˹�Ʈ ��轺',
'�̱�',
'/mov_poster/����̺�.jpg',
8.4);

select *
from (select rownum rn, mov_poster from mov_info order by mov_star_avg)
where rn in(1,2) order by rn ;

desc mov_info;

update mov_info set mov_poster='mov_poster/�׳�.jpg'  where  mov_poster = 'mov_poster/�׳�.jsp';
update mov_info set mov_poster='mov_poster/�ٸ� �ǿ��� ���ϼҼ�.jpg'  where  mov_poster = 'mov_poster/�ٸ� �ǿ��� ���ϼҼ�.jsp';
update mov_info set mov_poster='mov_poster/��Ⱬ�� ������.jpg'  where  mov_poster = 'mov_poster/��Ⱬ�� ������.jsp';
update mov_info set mov_poster='mov_poster/���̹�.jpg'  where  mov_poster = 'mov_poster/���̹�.jsp';
update mov_info set mov_poster='mov_poster/�׽��� ���� ����.jpg'  where  mov_poster = 'mov_poster/�׽��� ���� ����.jsp';
update mov_info set mov_poster='mov_poster/������ ����.jpg'  where  mov_poster = 'mov_poster/������ ����.jsp';
update mov_info set mov_poster='mov_poster/���� ������ ������.jpg'  where  mov_poster = 'mov_poster/���� ������ ������.jsp';
update mov_info set mov_poster='mov_poster/��!����.jpg'  where  mov_poster = 'mov_poster/��!����.jsp';
update mov_info set mov_poster='mov_poster/������Ʈ.jpg'  where  mov_poster = 'mov_poster/������Ʈ.jsp';
update mov_info set mov_poster='mov_poster/����̺�.jpg'  where  mov_poster = 'mov_poster/����̺�.jsp';
select mov_poster from mov_info;
commit;

create sequence seq_booked_seat
start with 5000
increment by 1;


select * from mov_user;
select * from mov_detail;

select mov_code, mov_name from mov_info;

desc mov_detail;
insert into mov_detail values(seq_movdetail.nextval, '2D' ,  1000);

select * from mov_schedule;

select * from mov_schedule
where schedule_date between '20/09/20' and '20/09/22';

select to_char(s.schedule_date,'yy/mm/dd') as ��¥, s.theater_code, s.mov_detail_code,d.mov_code, d.mov_type
from mov_schedule s, mov_detail d
where s.mov_detail_code=d.mov_detail_code
and schedule_date between '20/09/20' and '20/09/21'
order by s.theater_code
;

select to_char(s.schedule_date,'yy/mm/dd') as schedule_date,
        s.theater_code, s.mov_detail_code, d.mov_code, d.mov_type
        from mov_schedule s, mov_detail d
		where d.mov_code = 1001
        and d.mov_detail_code=s.mov_detail_code
        and schedule_date between '20/09/20' and '20/09/21'
		order by s.theater_code;


insert into mov_schedule values(seq_schedule.nextval,TO_TIMESTAMP('2020-09-20 06:30', 'YYYY-MM-DD HH24:MI'),1,2000);




select * from mov_booked_seat;

select * from mov_schedule;

select * from mov_seat;
--where mov_seat_code =100;

select count(mov_seat_code) as count from mov_seat
where mov_seat_code=100;

select count(booked_tf)
    from mov_booked_seat bs
        inner join mov_schedule msc
            on msc.schedule_code = bs.schedule_code
                and schedule_code =  30000000
        inner join mov_seat ms
            on ms.mov_seat_code = bs.mov_seat_code
      
        ;

select count(booked_tf) as count, schedule_code
    from mov_booked_seat bs
        where schedule_code =  30000000
            and booked_tf=0
        group by schedule_code
        ;
        
select s.schedule_code, s.schedule_date, s.theater_code, s.mov_detail_code, d.mov_code, d.mov_type, a.count
    from mov_schedule s
        inner join mov_detail d 
            on d.mov_code = 1000
                and d.mov_detail_code=s.mov_detail_code
                and schedule_date between '20/09/20' and '20/09/21' 
                 inner join (select count(booked_tf) as count, schedule_code
                     from mov_booked_seat bs
                             where booked_tf=0
                        group by schedule_code) a
            on a.schedule_code=s.schedule_code
                order by s.theater_code
                ;
select * from mov_schedule;
        


select s.schedule_code, s.schedule_date, s.theater_code, s.mov_detail_code, d.mov_code, d.mov_type
    from mov_schedule s
        inner join mov_detail d 
            on d.mov_code = 1001
                and d.mov_detail_code=s.mov_detail_code
                and schedule_date between '20/09/20' and '20/09/21' 
                order by s.theater_code;
        
--�ܿ��� �̴� ����        
select s.schedule_code, to_char(s.schedule_date,'mm') as schedule_month,
    to_char(s.schedule_date,'dd') as schedule_date,
    s.theater_code, s.mov_detail_code, d.mov_code, d.mov_type,
    nvl(a.count,0) as count, nvl(b.count,0) as bcount
        from mov_schedule s 
            inner join mov_detail d 
                on d.mov_code = 1000
                and d.mov_detail_code=s.mov_detail_code 
                    and to_char(schedule_date,'dd') ='23' 
            left outer join (select count(booked_tf) as count, schedule_code 
                        from mov_booked_seat bs 
                        where  booked_tf=0
                        group by schedule_code) a 
                 on a.schedule_code=s.schedule_code 
            left outer join (select count(booked_tf) as count, schedule_code 
                        from mov_booked_seat bs 
                        where  booked_tf=1
                        group by schedule_code) b 
                 on b.schedule_code=s.schedule_code 
        order by s.theater_code ;

select count(*) as count from mov_star_log where user_code=1111;
select * from mov_star_log;
select star_score from mov_star_log where mov_code=1000 and user_code = 6000;

select * from mov_star;
desc mov_star_log;
select * from mov_noticeboard;
insert into mov_noticeboard values(1000,8.8,1);

insert into mov_star values(1000,8.8,1);
insert into mov_star values(1001,8.6,1);
insert into mov_star values(1002,7.8,1);

select * from mov_star;
select * from mov_star_log;
delete from mov_star_log;
commit;
select user_code from MOV_USER where user_id = 'blue';
select * from mov_user;
commit;

select user_code from MOV_USER where user_id = 'blue';
desc mov_user;

CREATE TABLE MOV_USER(
USER_CODE NUMBER(8) PRIMARY KEY, --60���� �����ϴ� ���ڸ� ������
USER_ID VARCHAR2 (20) UNIQUE,
USER_PWD VARCHAR2(35) NOT NULL,
USER_NICK VARCHAR2(35) UNIQUE,
USER_TEL NUMBER(20) NOT NULL,
USER_ADDR VARCHAR2(50),
USER_ADDR2 VARCHAR2(100),
USER_EMAIL VARCHAR2(50),
USER_BIRTH DATE
);

create sequence seq_user 
start with 6000
increment by 1;

commit;

select * from mov_schedule;
 
select * from (select to_char(schedule_date,'mm/dd') schedule from mov_schedule)
where schedule between '09/20' and '09/22'
group by schedule
order by schedule
;

select * from (
        select to_char(schedule_date,'mm/dd') schedule from mov_schedule
        ) 
        
    group by schedule
    order by schedule
;

select to_char(s.schedule,'mm') scheduleMonth from(
    select * from (
            select to_char(schedule_date,'mm/dd') schedule from mov_schedule
            ) 
        group by schedule
        order by schedule
        ) s;
        
select d.mov_type ,to_char(s.schedule_date,'hh24:mi'),
      nvl(a.count,80) as count, nvl(b.count,0) as bcount
    from mov_schedule s
        inner join mov_detail d
            on d.mov_detail_code = s.mov_detail_code
            and d.mov_code = '1001'
            and to_char(schedule_date,'dd') ='21' 
         left outer join (select count(booked_tf) as count, schedule_code  
              from mov_booked_seat 
                     where  booked_tf=0 
                         group by schedule_code) a  
              on a.schedule_code=s.schedule_code 
         left outer join (select count(booked_tf) as count, schedule_code 
                from mov_booked_seat  
                                 where  booked_tf=1
                                group by schedule_code) b 
                on b.schedule_code=s.schedule_code    
     order by to_char(s.schedule_date,'hh24:mi');
     


select * from mov_detail where mov_detail_code=2000;
select * from mov_schedule where schedule_code = 30000000;

select mov_code from mov_detail where mov_detail_code=2000;
select * from mov_schedule where  mov_detail_code=2000;

select * from mov_info
    where mov_code = (select mov_code from mov_detail where mov_detail_code=2000);
    
--����, 2D, �󿵰�, �󿵵��, ��¥, �󿵽ð� //�������ڵ� 3000000, �������ڵ� 2000
select de.mov_name, de.mov_age, de.mov_type, sc.theater_code,
        to_char(sc.schedule_date,'mm/dd') scheduleDate,
        to_char(sc.schedule_date,'hh:mi') scheduleTime
from mov_schedule sc
    inner join (select i.mov_name, i.mov_age, d.mov_type,d.mov_detail_code
                    from mov_info i
                        inner join mov_detail d
                        on d.mov_code = i.mov_code
                            and mov_detail_code = 2000) de
        on de.mov_detail_code=sc.mov_detail_code
            and schedule_code = 30000000;

select i.mov_name, i.mov_age, d.mov_type,d.mov_detail_code
from mov_info i
inner join mov_detail d
on d.mov_code = i.mov_code
and mov_detail_code = 2000;

select * from mov_price;
select price_code from mov_price where mov_type='2D' and person_type='����';
select price*2 as price from mov_price where mov_type='2D' and person_type='����';
select sum(
    (select nvl(price,0) from mov_price where mov_type='2D' and person_type='����')
    +(select nvl(price,0) from mov_price where mov_type='2D' and person_type='����')
) as sum from dual;

desc mov_booked_seat;
select * from mov_booked_seat order by mov_seat_code;
desc mov_seat;
desc mov_reserve;
desc mov_reserve_log;
select * from mov_reserve;
select * from mov_seat;
select * from mov_price;
select * from mov_reserve;
delete from mov_reserve;
commit;

select mov_seat_code from mov_seat where theater_code='1' and seat_num='a1';
select booked_seat_code from mov_booked_seat where schedule_code='30000000' and MOV_SEAT_CODE='100';

select mov_seat_code from mov_seat where theater_code='1' and seat_num='b2';

alter table mov_reserve modify (PRICE_CODE varchar2(4)); 
alter table mov_reserve modify (reserved_time varchar2(100)); 
alter table mov_reserve_log modify (reserved_time varchar2(100)); 
alter table mov_reserve_log modify (reserve_group_code varchar2(100)); 

commit;

select * from mov_info;


insert into mov_reserve values (seq_reserve.nextval,?,?,to_char(sysdate,'yyyy-mm-dd hh24:mi'),
            ?,?,?,?,?,to_char(sysdate,'yyyy-mm-dd hh24:mi')) ;

insert into mov_reserve values(seq_reserve.nextval,2002,30000242,to_char(sysdate,'YYYY-MM-DD hh24:mi'),
            6000,5317,'b1',2,'����',to_char(sysdate,'yyyy-mm-dd hh24:mi'));

 select i.mov_name,s.schedule_code,i.mov_code,s.theater_code, s.mov_detail_code,
				        d.mov_type,i.mov_age, to_char(s.schedule_date,'yy/mm/dd')scheduleyear
				        from mov_info i
				            inner join mov_detail d
				                on i.mov_code = d.mov_code
				                 and i.mov_code = 1000
				            inner join mov_schedule s 
				                on s.mov_detail_code = d.mov_detail_code
				                and  to_char(s.schedule_date,'dd') = '23';
desc mov_booked_seat;
select * from mov_booked_seat;
delete mov_booked_seat;
create sequence seq_booked_seat
start with 5000
increment by 1;


select * from mov_reserve;
commit;
select * from mov_reserve_log;
desc mov_reserve_log;
desc mov_reserve;
select * from mov_detail;
select * from mov_schedule;
select * from mov_booked_seat;
ALTER TABLE mov_reserve ADD UNIQUE (booked_seat_code);

--ALTER TABLE mov_reserve' ADD CONSTRAINT 'mov_reserve_addunique' UNIQUE ('booked_seat_code');


select * from mov_booked_seat;
select * from mov_seat;

select seat_num from mov_seat ms
    inner join (select mov_seat_code
                from mov_booked_seat where schedule_code=30000000) mbs
        on ms.mov_seat_code=mbs.mov_seat_code;
        
        select mov_seat_code
                from mov_booked_seat where mov_seat_code=30000000;



--5001

select mov_seat_code from mov_booked_seat where booked_seat_code=5001;

select seat_num from mov_seat where mov_seat_code=
(select mov_seat_code from mov_booked_seat where booked_seat_code=5001);

insert into mov_reserve_log (reserve_code, user_code,
reserve_group_code,reserved_time,cancel_tf) 
					 values (seq_reserve.currval,1000,to_char(sysdate,'yyyy-mm-dd hh24:mi'),
					to_char(sysdate,'yyyy-mm-dd hh24:mi'),F);


