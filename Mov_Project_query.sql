CREATE TABLE MOV_USER(
USER_CODE NUMBER(8) PRIMARY KEY, --60부터 시작하는 네자리 시퀀스
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
REV_NUM NUMBER(8) PRIMARY KEY, --시퀀스로 1부터
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
	REPLY_NUM NUMBER(8) PRIMARY KEY, -- 이것도 그냥 시퀀스로 1부터
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
	LIKE_CODE NUMBER(10) PRIMARY KEY, --시퀀스로(몇부터 시작??)
	USER_CODE NUMBER(8) NOT NULL,
	REV_NUM NUMBER(8) NOT NULL,
	REPLY_NUM NUMBER(8) NOT NULL,
	LIKE_REV_YN CHAR(1) DEFAULT '0' NOT NULL,
LIKE_REPLY_YN CHAR(1) DEFAULT '0' NOT NULL
);

drop table MOV_LIKE;

CREATE TABLE MOV_LIKE(
	LIKE_CODE NUMBER(10) PRIMARY KEY, --시퀀스로(몇부터 시작??)
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
	ADMIN_CODE NUMBER PRIMARY KEY, -- 시퀀스없이 그냥 부여(4자리)
	ADMIN_ID VARCHAR2(20) UNIQUE,
	ADMIN_PWD VARCHAR2(35) NOT NULL,
	ADMIN_NICK VARCHAR2(30) NOT NULL
);

create sequence seq_noticeboard
increment by 1;

CREATE TABLE MOV_NOTICEBOARD(
	NOTICE_NUM NUMBER PRIMARY KEY, --그냥 시퀀스로
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
	MOV_CODE NUMBER(8) PRIMARY KEY, --10으로 시작하는 4자리 숫자.  시퀀스
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
	MOV_DETAIL_CODE NUMBER(8) PRIMARY KEY, --20으로 시작하는 4자리 숫자. 시퀀스
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
	RESERVE_CODE NUMBER(12) PRIMARY KEY, --시퀀스(12자리 1000-0000-0000)
	MOV_DETAIL_CODE NUMBER(8) NOT NULL,
	SCHEDULE_CODE NUMBER(10) NOT NULL,
	RESERVED_TIME TIMESTAMP NOT NULL,
	USER_CODE NUMBER(8) NOT NULL,
	BOOKED_SEAT_CODE NUMBER(12) NOT NULL,
	PRICE_CODE NUMBER NOT NULL,
	THEATER_CODE NUMBER NOT NULL,
	PERSON_TYPE VARCHAR2(30) NOT NULL,
	RESERVE_GROUP_CODE NUMBER(12)
			--년도-날짜-분까지?? 프로그램상으로 시간 뽑아서 입력하는걸로?
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
	SCHEDULE_CODE NUMBER(8) PRIMARY KEY, --30으로 시작하는 8자리 숫자. 시퀀스
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
	MOV_SEAT_CODE NUMBER PRIMARY KEY, --3자리 숫자 100부터 시퀀스
	THEATER_CODE NUMBER NOT NULL, -- 1관~5관 숫자만 넣기
	SEAT_NUM VARCHAR2(10) NOT NULL -- a1~a10 등등 대충 80~100석 정도
);


CREATE TABLE MOV_PRICE(
	PRICE_CODE VARCHAR2(4) PRIMARY KEY, --그냥 시퀀스없이 숫자로 입력
	PRICE NUMBER NOT NULL,
	MOV_TYPE VARCHAR2(10) NOT NULL,
	PERSON_TYPE VARCHAR2(15) NOT NULL
);

DESC MOV_SEAT;



select * from mov_info;

insert into mov_info values (seq_movcode.nextval, 
'오!문희',
'평화로운 금산 마을. 
불같은 성격에 가족 사랑도 뜨거운 ''두원''(이희준)에게 
하나뿐인 딸 ''보미''가 뺑소니 사고를 당했다는 청천벽력 같은 소식이 전해진다. 
게다가 현장의 유일한 목격자는
기억이 깜빡깜빡하는 엄니 ''문희''(나문희)와 왈왈 짖기만 하는 개 ''앵자''뿐.

의식 불명 상태로 병원에 있는 ''보미''.
경찰 수사에 진전이 없자 ''두원''의 속은 점점 타들어간다.  
하지만 예기치 못한 순간 엄니 ''문희''가 뜻밖의 단서를 기억해내고 
''두원''은 엄니와 함께 논두렁을 가르며 직접 뺑소니범을 찾아 나서기 시작하는데!',
to_date('2020-09-02','YYYY-MM-DD'),
110,
'12세 이상',
'코미디',
'정세교',
'나문희',
'이희준',
null,
'한국',
'/mov_poster/오!문희.jpg',
9.2);

insert into mov_info values (seq_movcode.nextval, 
'뉴 뮤턴트',
'십대의 돌연변이 레인(메이지 윌리암스 분)과 일리야나(안야 테일러조이 분), 샘(찰리 히튼 분),
로베르토(헨리 자가 분)는 비밀 시설에 수용되어 심리 상태를 감시 받는다.
이들이 사회에는 물론 스스로에게도 위험한 존재라고 생각하는 닥터 레예스(앨리스 브라가 분)는
이들에게 돌연변이 능력을 통제하는 방법을 가르쳐주고자 애쓴다.

어느 날, 대재앙이 덮친 마을에서 혼자 살아남은 대니(블루 헌트 분)가 이곳에 들어오며
끔찍한 일들이 벌어지기 시작하고,
자신들의 힘을 두려워하고 다룰 줄 몰랐던 십대 돌연변이들은 믿기지 않는 경험을 하며
자신들의 능력을 각성하기 시작하는데…',
to_date('2020-09-10','YYYY-MM-DD'),
94,
'15세 이상',
'액션',
'조쉬 분',
'메이지 윌리암스',
'안야 테일러 조이',
'찰리 히튼',
'미국',
'/mov_poster/뉴뮤턴트.jpg',
8.1);

--1009
insert into mov_info values (seq_movcode.nextval,
'드라이브',
'삶의 의미라곤 오직 스피드밖에 없었던 한 남자,
그의 일상에 작은 파장을 일으킨 한 여자.

어느덧 또 하나의 의미가 된 그녀가 위험해지고
그녀를 지키기 위해 그는 모든 것을 거는데…',
to_date('2020-09-03','YYYY-MM-DD'),
100,
'19세 이상',
'액션',
'니콜라스 원딩 레픈',
'라이언 고슬링',
'캐리 멀리건',
'알버트 브룩스',
'미국',
'/mov_poster/드라이브.jpg',
8.4);

select *
from (select rownum rn, mov_poster from mov_info order by mov_star_avg)
where rn in(1,2) order by rn ;

desc mov_info;

update mov_info set mov_poster='mov_poster/테넷.jpg'  where  mov_poster = 'mov_poster/테넷.jsp';
update mov_info set mov_poster='mov_poster/다만 악에서 구하소서.jpg'  where  mov_poster = 'mov_poster/다만 악에서 구하소서.jsp';
update mov_info set mov_poster='mov_poster/기기괴괴 성형수.jpg'  where  mov_poster = 'mov_poster/기기괴괴 성형수.jsp';
update mov_info set mov_poster='mov_poster/에이바.jpg'  where  mov_poster = 'mov_poster/에이바.jsp';
update mov_info set mov_poster='mov_poster/테스와 보낸 여름.jpg'  where  mov_poster = 'mov_poster/테스와 보낸 여름.jsp';
update mov_info set mov_poster='mov_poster/오케이 마담.jpg'  where  mov_poster = 'mov_poster/오케이 마담.jsp';
update mov_info set mov_poster='mov_poster/나를 구하지 마세요.jpg'  where  mov_poster = 'mov_poster/나를 구하지 마세요.jsp';
update mov_info set mov_poster='mov_poster/오!문희.jpg'  where  mov_poster = 'mov_poster/오!문희.jsp';
update mov_info set mov_poster='mov_poster/뉴뮤턴트.jpg'  where  mov_poster = 'mov_poster/뉴뮤턴트.jsp';
update mov_info set mov_poster='mov_poster/드라이브.jpg'  where  mov_poster = 'mov_poster/드라이브.jsp';
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

select to_char(s.schedule_date,'yy/mm/dd') as 날짜, s.theater_code, s.mov_detail_code,d.mov_code, d.mov_type
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
        
--잔여석 뽑는 쿼리        
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
insert into mov_noticeboard values(1,'공지사항','woong','없음',sysdate,0,null);
commit;
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
USER_CODE NUMBER(8) PRIMARY KEY, --60부터 시작하는 네자리 시퀀스
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
    
--제목, 2D, 상영관, 상영등급, 날짜, 상영시간 //스케줄코드 3000000, 디테일코드 2000
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
select price_code from mov_price where mov_type='2D' and person_type='성인';
select price*2 as price from mov_price where mov_type='2D' and person_type='성인';
select sum(
    (select nvl(price,0) from mov_price where mov_type='2D' and person_type='성인')
    +(select nvl(price,0) from mov_price where mov_type='2D' and person_type='성인')
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
            6000,5317,'b1',2,'성인',to_char(sysdate,'yyyy-mm-dd hh24:mi'));

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

select * from mov_admin;
insert into mov_admin values(8888,'nutopie','1234','admin1');
insert into mov_admin values(9999,'red','1234','admin2');
commit;
select * from mov_info;
delete mov_info where mov_code>1010;
commit;


