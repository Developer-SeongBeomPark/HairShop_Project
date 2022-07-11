use dbtest;

CREATE TABLE category (
       cateno               int NOT NULL		auto_increment,
       catename             varchar(20) NOT NULL,
       PRIMARY KEY (cateno)
);

insert into category(catename) value('컷');
insert into category(catename) value('펌');
insert into category(catename) value('클리닉');
select * from category;

CREATE TABLE designer (
       did                  varchar(50) NOT NULL,
       dpw                  varchar(10) NOT NULL,
       birth                varchar(6) NOT NULL,
       demail               varchar(50) NOT NULL,
       dphone               varchar(20) NOT NULL,
       address1             varchar(60) NOT NULL,
       address2             varchar(60) NOT NULL,
       dzipcode             varchar(20) NOT NULL,
       validation           boolean DEFAULT false NULL
                                   CHECK (validation IN (false, true)),
       likecnt              int DEFAULT 0 NULL,
       dfilename            varchar(60) NULL,
       dname                varchar(20) NOT NULL,
       PRIMARY KEY (did),
       UNIQUE (
              demail
       )
);
insert into designer values('designer1', '1234', '910709', 'user1@gmail.com', '010-1234-5678', '서울시 종로구', '대왕빌딩 602호', '152342', true, 0 , 'default.jpg', '홍길동');
insert into designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,dfilename) values('designer2','1234','김길동','930709','user2@gmail.com','010-1414-1414','서울시 종로구','대왕빌딩 601호','123412','default.jpg');

select * from designer;





CREATE TABLE hairmenu (
       menuno               int NOT NULL	auto_increment,
       price                int NOT NULL,
       menu                 varchar(20) NOT NULL,
       did                  varchar(50) NOT NULL,
       cateno               int NOT NULL,
       PRIMARY KEY (menuno), 
       FOREIGN KEY (cateno)
                             REFERENCES category(cateno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did)
);

insert into hairmenu(did,price,menu,cateno) values('designer1','20000','남성 디자인컷',1);
insert into hairmenu(did,price,menu,cateno) values('designer1','50000','남성 펌',2);
insert into hairmenu(did,price,menu,cateno) values('designer1','30000','여성 디자인컷',1);
insert into hairmenu(did,price,menu,cateno) values('designer1','10000','여성 펌',2);

select * from hairmenu
	where did = 'designer1'
    order by cateno;


CREATE TABLE enroll (
       enrollno             int NOT NULL	auto_increment,
       enrolldate           varchar(20) NOT NULL,
       enrolltime           varchar(20) NOT NULL,
       menuno               int NOT NULL,
       did                  varchar(50) NOT NULL,
       PRIMARY KEY (enrollno), 
       FOREIGN KEY (menuno)
                             REFERENCES hairmenu(menuno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did)
);

insert into enroll(did,menuno,enrolldate,enrolltime) values('designer1','1','2022-07-10','12:04');
insert into enroll(did,menuno,enrolldate,enrolltime) values('designer1','2','2022-07-10','12:04');
insert into enroll(did,menuno,enrolldate,enrolltime) values('designer1','3','2022-07-10','12:04');

select * from enroll;


CREATE TABLE user (
       uid                  varchar(20) NOT NULL,
       upw                  varchar(20) NOT NULL,
       uemail               varchar(50) NOT NULL,
       uname                varchar(20) NOT NULL,
       uphone               varchar(20) NOT NULL,
       grade                varchar(5) DEFAULT 'C' NOT NULL
                                   CHECK (grade IN ('A', 'C')),
       PRIMARY KEY (uid),
       UNIQUE (
              uemail
       )
);
-- alter table user add UNIQUE (
--               uemail
--        );

insert into user(uid,upw,uemail,uname,uphone) values('user1','1234','test@mail.com','박길동','010-4141-2312');
insert into user(uid,upw,uemail,uname,uphone) values('user2','1234','test2@mail.com','고길동','010-5141-2312');
insert into user(uid,upw,uemail,uname,uphone) values('admin','1234','admin@mail.com','관리자','010-6134-9361');

use dbtest;
delete from user
	where uid = 'user1';

select * from user;


CREATE TABLE reserve (
       reserveno            int NOT NULL	auto_increment,
       uid                  varchar(20) NOT NULL,
       message              varCHAR(100) NULL,
       enrollno             int NOT NULL,
       PRIMARY KEY (reserveno), 
       FOREIGN KEY (enrollno)
                             REFERENCES enroll(enrollno), 
       FOREIGN KEY (uid)
                             REFERENCES user(uid)
);

insert into reserve(enrollno, uid, message) values(2,'user1','안녕하세요');
insert into reserve(enrollno, uid, message) values(1,'user2','안녕하세요 반갑습니다');
insert into reserve(enrollno, uid, message) values(3,'user1','안녕하세요 ㅎㅇㅎㅇ');

delete from reserve where uid = 'user1';
select * from reserve;


CREATE TABLE certification (
       did                  varchar(50) NOT NULL,
       licensetype          varchar(20) NOT NULL,
       licenseno            varchar(50) NULL,
       licensedate          varchar(20) NULL,
       uniquecode1          varchar(50) NULL,
       uniquecode2          varchar(50) NULL,
       PRIMARY KEY (did), 
       FOREIGN KEY (did)
                             REFERENCES designer(did)
);

insert into certification(did, licensetype, licenseno, licensedate,uniquecode1) values('designer1','수첩형 디자이너','12345678901A','20050101','0901234567');
insert into certification(did, licensetype,uniquecode2) values('designer2','상장형 디자이너','0909873165');

select * from certification;


CREATE TABLE style (
       imgno                int NOT NULL	auto_increment,
       sfilename            varchar(50) NOT NULL,
       did                  varchar(50) NOT NULL,
       gender               varchar(10) NULL,
       imgtype              varchar(50) NULL,
       imgcode              blob NULL,
       PRIMARY KEY (imgno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did)
);

insert into style(sfilename,did,gender,imgtype) values('style1.jpg','designer1','male','akdf812u91212o83');
insert into style(sfilename,did,gender,imgtype) values('style2.jpg','designer1','female','akdf812u91212o83');
insert into style(sfilename,did,gender,imgtype) values('style3.jpg','designer1','male','akdfqkwj1234t983');

select * from style;


CREATE TABLE review (
       rno                  int NOT NULL	auto_increment,
       rtitle               varchar(20) NOT NULL,
       rcontent             text NOT NULL,
       rdate                varchar(20) NOT NULL,
       star                 int DEFAULT 5 NULL,
       rfilename            varchar(50) NULL,
       uid                  varchar(20) NOT NULL,
       did                  varchar(50) NOT NULL,
       PRIMARY KEY (rno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did), 
       FOREIGN KEY (uid)
                             REFERENCES user(uid)
);

insert into review(rtitle,rcontent,rdate,rfilename,uid,did) values('최고에요!','맘에 들어요~',sysdate(),'photo1.jpg','user1','designer1');
insert into review(rtitle,rcontent,rdate,rfilename,uid,did) values('최고에요!','맘에 들어요~',sysdate(),'photo5.jpg','user1','designer1');
insert into review(rtitle,rcontent,rdate,rfilename,uid,did) values('최고에요!','맘에 들어요~',sysdate(),'photo3.jpg','user2','designer1');

delete from review where uid = 'user1';
select * from review;


CREATE TABLE notice (
       noticeno             int NOT NULL	auto_increment,
       uid                  varchar(20) NOT NULL,
       ntitle               varchar(30) NOT NULL,
       viewcnt              int DEFAULT 0 NULL,
       ndate                varchar(20) NOT NULL,
       ncontent             text NOT NULL,
       PRIMARY KEY (noticeno), 
       FOREIGN KEY (uid)
                             REFERENCES user(uid)
);

insert into notice(uid,ntitle,ndate,ncontent) values('admin','공지사항입니다',sysdate(),'공지사항 내용입니다.');


use dbtest;

select * from designer;

select distinct d.dname, e.enrolldate, e.enrolltime, h.menu, h.price, h.cateno
	from designer d
    left outer join enroll e
	on d.did = e.did
    left outer join hairmenu h
    on d.did = h.did
    where d.dname = '홍길동';
    

