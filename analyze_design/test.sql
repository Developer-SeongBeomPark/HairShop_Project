
CREATE TABLE score (
       scoreno              int NOT NULL,
       name                 varchar(20) NULL,
       kuk                  int DEFAULT 0 NULL
                                   CHECK (kuk BETWEEN 0 AND 100),
       영어                 CHAR(18) DEFAULT 0 NULL
                                   CHECK (영어 BETWEEN 0 AND 100),
       수학                 CHAR(18) DEFAULT 0 NULL
                                   CHECK (수학 BETWEEN 0 AND 100),
       총점                 CHAR(18) NULL
                                   CHECK (총점 BETWEEN 0 AND 300),
       평균                 CHAR(18) NULL,
       학점                 CHAR(18) NULL
                                   CHECK (학점 IN ('A', 'B')),
       PRIMARY KEY (scoreno)
);


CREATE TABLE 부서 (
       부서코드             CHAR(18) NOT NULL,
       부서명               CHAR(18) NULL,
       PRIMARY KEY (부서코드)
);


CREATE TABLE 사원 (
       사원번호             CHAR(18) NOT NULL,
       이름                 CHAR(18) NULL,
       전화번호             CHAR(18) NULL,
       핸드폰번호           CHAR(18) NULL,
       우편번호             CHAR(18) NULL,
       주소                 CHAR(18) NULL,
       부서코드             CHAR(18) NOT NULL,
       사직속상             CHAR(18) NULL,
       PRIMARY KEY (사원번호), 
       FOREIGN KEY (사직속상)
                             REFERENCES 사원, 
       FOREIGN KEY (부서코드)
                             REFERENCES 부서
);


CREATE TABLE 상세정보 (
       키                   CHAR(18) NULL,
       시력좌               CHAR(18) NULL,
       시력우               CHAR(18) NULL,
       혈액형               CHAR(18) NULL,
       사원번호             CHAR(18) NOT NULL,
       몸무게               CHAR(18) NULL,
       PRIMARY KEY (사원번호), 
       FOREIGN KEY (사원번호)
                             REFERENCES 사원
);


CREATE TABLE 회원 (
       회원id               CHAR(18) NOT NULL,
       이름                 CHAR(18) NULL,
       전화번호             CHAR(18) NULL,
       핸드폰번호           CHAR(18) NULL,
       우편번호             CHAR(18) NULL,
       주소                 CHAR(18) NULL,
       등록일자             CHAR(18) NULL,
       PRIMARY KEY (회원id)
);


CREATE TABLE 상품 (
       상품코드             CHAR(18) NOT NULL,
       상품명               CHAR(18) NULL,
       소비자가격           CHAR(18) NULL,
       판매단가             CHAR(18) NULL,
       재고수량             CHAR(18) NULL,
       제조사               CHAR(18) NULL,
       등록일               CHAR(18) NULL,
       PRIMARY KEY (상품코드)
);


CREATE TABLE 공급업체 (
       업체코드             CHAR(18) NOT NULL,
       업체명               CHAR(18) NULL,
       대표자명             CHAR(18) NULL,
       전화                 CHAR(18) NULL,
       담당자               CHAR(18) NULL,
       담당자연락처         CHAR(18) NULL,
       우편번호             CHAR(18) NULL,
       주소                 CHAR(18) NULL,
       PRIMARY KEY (업체코드)
);


CREATE TABLE 주문 (
       주문번호             CHAR(18) NOT NULL,
       회원id               CHAR(18) NOT NULL,
       상품코드             CHAR(18) NOT NULL,
       배송정보             CHAR(18) NULL,
       주문수량             CHAR(18) NULL,
       주문합계             CHAR(18) NULL,
       PRIMARY KEY (주문번호), 
       FOREIGN KEY (상품코드)
                             REFERENCES 상품, 
       FOREIGN KEY (회원id)
                             REFERENCES 회원
);


CREATE TABLE 입고 (
       입고번호             CHAR(18) NOT NULL,
       상품코드             CHAR(18) NOT NULL,
       입고금액             CHAR(18) NULL,
       입고날짜             CHAR(18) NULL,
       입고단가             CHAR(18) NULL,
       입고수량             CHAR(18) NULL,
       업체코드             CHAR(18) NOT NULL,
       PRIMARY KEY (입고번호), 
       FOREIGN KEY (업체코드)
                             REFERENCES 공급업체, 
       FOREIGN KEY (상품코드)
                             REFERENCES 상품
);


CREATE TABLE 상품분류 (
       분류코드             CHAR(18) NOT NULL,
       분류명               CHAR(18) NULL,
       상위코드             CHAR(18) NULL,
       PRIMARY KEY (분류코드), 
       FOREIGN KEY (상위코드)
                             REFERENCES 상품분류
);



