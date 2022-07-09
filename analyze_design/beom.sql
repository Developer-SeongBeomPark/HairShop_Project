use dbtest;

CREATE TABLE category (
       cateno               int NOT NULL,
       catename             varchar(20) NOT NULL,
       PRIMARY KEY (cateno)
);


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

drop table designer;


CREATE TABLE hairmenu (
       menuno               int NOT NULL,
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


CREATE TABLE enroll (
       enrollno             int NOT NULL,
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


CREATE TABLE user (
       uid                  varchar(20) NOT NULL,
       upw                  varchar(20) NOT NULL,
       uemail               varchar(50) NOT NULL,
       uname                varchar(20) NOT NULL,
       uphone               varchar(20) NOT NULL,
       grade                varchar(5) DEFAULT 'C' NOT NULL
                                   CHECK (grade IN ('A', 'C')),
       PRIMARY KEY (uid)
);


CREATE TABLE reserve (
       reserveno            int NOT NULL,
       uid                  varchar(20) NOT NULL,
       message              varCHAR(100) NULL,
       enrollno             int NOT NULL,
       PRIMARY KEY (reserveno), 
       FOREIGN KEY (enrollno)
                             REFERENCES enroll(enrollno), 
       FOREIGN KEY (uid)
                             REFERENCES user(uid)
);


CREATE TABLE cerification (
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


CREATE TABLE style (
       imgno                int NOT NULL,
       sfilename            varchar(50) NOT NULL,
       did                  varchar(50) NOT NULL,
       gender               varchar(10) NULL,
       imgtype              varchar(50) NULL,
       imgcode              blob NULL,
       PRIMARY KEY (imgno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did)
);


CREATE TABLE review (
       rno                  int NOT NULL,
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


CREATE TABLE notice (
       noticeno             int NOT NULL,
       uid                  varchar(20) NOT NULL,
       ntitle               varchar(30) NOT NULL,
       viewcnt              int DEFAULT 0 NULL,
       ndate                varchar(20) NOT NULL,
       ncontent             text NOT NULL,
       PRIMARY KEY (noticeno), 
       FOREIGN KEY (uid)
                             REFERENCES user(uid)
);



