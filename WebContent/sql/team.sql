

---------------------------------------------------------


-- info_beans_country_extra ==> 테이블 생성
-- info_seq_view ==> 상위 테이블 관련 시퀀스 & 뷰 2개
-- req ==> 댓글테이블 + 시퀀스
-- member ==> 회원관련 테이블


---------------------------------------------------------





-- 정보테이블
create table info(
 info_no number(10) primary key,
 info_genre varchar2(10) not null,
 info_title varchar2(100),
 info_cont clob,
 info_hit number(5) default 0,
 info_date date,
 info_file varchar2(3000)
);

-- 게시물 번호 시퀀스
create sequence info_seq
start with 1
increment by 1
nocache;

-- 원두테이블
create table beans(
 info_no number(10) primary key,
 coun_no number(10) not null,
 beans_aroma number(10) not null,
 beans_acidity number(10) not null,
 beans_sweet number(10) not null,
 beans_bitter number(10) not null,
 beans_body number(10) not null,
 info_title varchar2(100) not null,
 info_cont clob not null,
 info_file varchar2(3000)
);

-- 나라테이블
-- 아시아 1, 남미 2, 아프리카 3, 북미 4, 유럽 5, 오스트레일리아 6, 남극 7
-- 인도네시아 101, 인도 102
-- 콜롬비아 201, 과테말라 202, 니카라과 203, 멕시코 204, 엘살바도르 205, 코스타리카 206, 파나마 207, 도미니카 208, 브라질 209, 온두라스 210, 페루 211
-- 에티오피아 301, 르완다 302, 말라위 303, 짐바브웨 304, 케냐 305, 탄자니아 306
create table country(
 info_no number(10) primary key,
 coun_no number(10) not null,
 coun_7 varchar2(30) not null,
 coun_add varchar2(300), 
 info_title varchar2(100) not null,
 info_cont clob not null,
 info_file varchar2(3000)
);


-- 추출방식테이블
create table extra(
 info_no number(10) primary key,
 extra_genre varchar2(30) not null,
 info_title varchar2(100) not null,
 info_cont clob not null,
 info_file varchar2(3000)
);

-- 바리에이션테이블(보류중)
create table variat(
 info_no number(10) primary key,
 info_title varchar2(100) not null,
 info_cont clob not null,
 info_file varchar2(3000)
);

-- 블랜딩테이블(보류중)
create table blend(
 info_no number(10) primary key,
 info_title varchar2(100) not null,
 info_cont clob not null,
 info_file varchar2(3000)
);


-- 원두 View
create view beans_v as 
select b.info_no, b.coun_no, c.info_title beans_coun, c.coun_add beans_counadd, b.beans_aroma, b.beans_acidity, b.beans_sweet, b.beans_bitter, b.beans_body, b.info_title, b.info_cont, b.info_file 
from beans b, country c 
where b.coun_no=c.coun_no 
order by b.info_no desc;

-- 게시물 View
create view info_v as 
select g.info_no, i.info_genre, g.info_title, g.info_file, i.info_hit, i.info_date
from info i,
(select info_no, info_title, info_file from info union
select info_no, info_title, info_file from beans union
select info_no, info_title, info_file from country union
select info_no, info_title, info_file from extra) g
where i.info_no=g.info_no and g.info_title is not null
order by i.info_no desc;

insert into country values(info_seq.nextval, 101, '아시아', '인도네시아주소', '인도네시아', '인도네시아정보', '');
insert into country values(info_seq.nextval, 102, '아시아', '인도주소', '인도', '인도정보', '');
insert into country values(info_seq.nextval, 201, '남미', '콜롬비아주소', '콜롬비아', '정보', '');
insert into country values(info_seq.nextval, 202, '남미', '주소', '과테말라', '정보', '');
insert into country values(info_seq.nextval, 203, '남미', '주소', '니카라과', '정보', '');
insert into country values(info_seq.nextval, 204, '남미', '주소', '멕시코', '정보', '');
insert into country values(info_seq.nextval, 205, '남미', '주소', '엘살바도르', '정보', '');
insert into country values(info_seq.nextval, 206, '남미', '주소', '코스타리카', '정보', '');
insert into country values(info_seq.nextval, 207, '남미', '주소', '파나마', '정보', '');
insert into country values(info_seq.nextval, 208, '남미', '주소', '도미니카', '정보', '');
insert into country values(info_seq.nextval, 209, '남미', '주소', '브라질', '정보', '');
insert into country values(info_seq.nextval, 210, '남미', '주소', '온두라스', '정보', '');
insert into country values(info_seq.nextval, 211, '남미', '주소', '페루', '정보', '');
insert into country values(info_seq.nextval, 301, '아프리카', '주소', '에티오피아', '정보', '');
insert into country values(info_seq.nextval, 302, '아프리카', '주소', '르완다', '정보', '');
insert into country values(info_seq.nextval, 303, '아프리카', '주소', '말라위', '정보', '');
insert into country values(info_seq.nextval, 304, '아프리카', '주소', '짐바브웨', '정보', '');
insert into country values(info_seq.nextval, 305, '아프리카', '주소', '케냐', '정보', '');
insert into country values(info_seq.nextval, 306, '아프리카', '주소', '탄자니아', '정보', '');

insert into beans values(info_seq.nextval, 101, 4, 2, 3, 2, 4, '자바', '인도네시아 자바', '');
insert into beans values(info_seq.nextval, 101, 4, 2, 5, 2, 4, '만델링', '인도네시아 만델링', '');
insert into beans values(info_seq.nextval, 101, 4, 2, 3, 2, 3, '발리 칸타마니', '인도네시아 발리 칸타마니', '');
insert into beans values(info_seq.nextval, 101, 4, 4, 3, 2, 3, '가요 마운틴', '인도네시아 마운틴', '');
insert into beans values(info_seq.nextval, 101, 4, 5, 3, 2, 4, '토라자', '인도네시아 토라자', '');
insert into beans values(info_seq.nextval, 102, 5, 4, 4, 3, 4, '몬순드 말리바', '인도 몬순드 말리바', '');
insert into beans values(info_seq.nextval, 201, 5, 5, 3, 2, 3, '슈프리모', '콜롬비아 슈프리모', '');
insert into beans values(info_seq.nextval, 201, 5, 5, 3, 2, 3, '엑셀소 디카페인', '콜롬비아 엑셀소 디카페인', '');
insert into beans values(info_seq.nextval, 202, 5, 4, 3, 3, 4, 'SHB', '과테말라 SHB', '');
insert into beans values(info_seq.nextval, 203, 3, 4, 3, 3, 3, 'SHB', '니카라과 SHB', '');
insert into beans values(info_seq.nextval, 204, 4, 3, 3, 2, 2, '알투라SHB', '멕시코 알투라SHB', '');
insert into beans values(info_seq.nextval, 205, 4, 3, 3, 2, 2, '펜시SHB', '엘살바도르 펜시SHB', '');
insert into beans values(info_seq.nextval, 206, 3, 3, 4, 3, 2, 'SHB', '코스타리카 SHB', '');
insert into beans values(info_seq.nextval, 207, 5, 4, 3, 4, 3, 'SHB', '파나마 SHB', '');
insert into beans values(info_seq.nextval, 208, 2, 4, 3, 2, 1, 'AA', '도미니카 AA', '');
insert into beans values(info_seq.nextval, 209, 4, 3, 3, 2, 2, '산토스', '브라질 산토스', '');
insert into beans values(info_seq.nextval, 209, 4, 3, 3, 2, 2, '산토스 디카페인', '브라질 산토스 디카페인', '');
insert into beans values(info_seq.nextval, 210, 3, 4, 2, 2, 3, 'SHG', '온두라스 SHG', '');
insert into beans values(info_seq.nextval, 211, 5, 4, 4, 3, 4, 'HB GRADE1', '페루 HB GRADE1', '');
insert into beans values(info_seq.nextval, 301, 4, 5, 3, 3, 4, '예가체프', '에티오피아 예가체프', '');
insert into beans values(info_seq.nextval, 301, 4, 5, 3, 3, 4, '모카 시다모', '에티오피아 모카 시다모', '');
insert into beans values(info_seq.nextval, 302, 2, 3, 3, 3, 4, 'AB+', '르완다 AB+', '');
insert into beans values(info_seq.nextval, 303, 5, 3, 3, 4, 4, 'AAA+', '말라위 AAA+', '');
insert into beans values(info_seq.nextval, 304, 4, 5, 3, 3, 4, 'AA+', '짐바브웨 AA+', '');
insert into beans values(info_seq.nextval, 305, 4, 5, 3, 3, 4, 'AA', '케냐 AA', '');
insert into beans values(info_seq.nextval, 306, 4, 5, 3, 3, 4, 'AA', '탄자니아 AA', '');

select * from (select p.*, row_number() over(order by info_no desc) rnum from info_v p where info_genre like '%beans%') where rnum between 1 and 3;


-- 댓글 구현 테이블 
CREATE TABLE info_reply (
   rep_num NUMBER(5) PRIMARY KEY, -- 댓글 고유 번호
   info_no NUMBER(5) NOT NULL, -- 이 댓글이 달린 게시글의 번호
   cont NVARCHAR2(2000), -- 댓글 내용
   writerNum NUMBER(5), -- 댓글쓴이 num
   dep NUMBER, -- 이 댓글의 깊이
   parentNum NUMBER, -- 이 댓글이 만약 대댓글이라면, 몇 번 댓글이 부모인지
   regdate DATE,
   R_CATEGORY VARCHAR2(50 BYTE)
);

CREATE SEQUENCE rep_seq 
start with 1
increment by 1
nocache;

-- MNO 관리자 100 번 이하 회원 101 번 부터
-- 아이디 중복 체크
create table member_in (
 m_id VARCHAR2(20 BYTE) UNIQUE NOT NULL, 
 m_nickname VARCHAR2(20 BYTE) NOT NULL, 
 m_pwd VARCHAR2(20 BYTE) NOT NULL, 
 m_tel VARCHAR2(20 BYTE), 
 m_address VARCHAR2(200 BYTE), 
 m_email VARCHAR2(50 BYTE), 
 m_date DATE, 
 m_no NUMBER(5, 0)  PRIMARY KEY
);
select max(m_no) from member_in where m_no < 100;
select max(m_no) from member_in where m_no > 100;

insert into member_in values('_','_','_','010','_','_','',-1);
insert into member_in values('mrg_1','백서진','0000','010','서울','aaa@aaa','20/04/01',1);
insert into member_in values('hong','홍길동','1234','010','대전','bbb@bbb','20/04/04',101);
insert into member_in values('leess','이순신','1234','010','대구','ccc@ccc','20/04/05',102);

insert into member_in values('hhhh','홍길동','1234','010','대전','bbb@bbb','20/04/04',111);
insert into member_in values('kkkk','홍길동','1234','010','대전','bbb@bbb','20/04/04',121);

insert into member_in values('22','_','_','010','_','_','',2);

-- 탈퇴 회원정보 저장 테이블
create table member_out (
 m_id VARCHAR2(20 BYTE) NOT NULL, 
 m_nickname VARCHAR2(20 BYTE) NOT NULL, 
 m_pwd VARCHAR2(20 BYTE) NOT NULL, 
 m_tel VARCHAR2(20 BYTE), 
 m_address VARCHAR2(200 BYTE), 
 m_email VARCHAR2(50 BYTE), 
 m_date DATE,  --탈퇴 날짜
 m_no NUMBER(5, 0) NOT NULL
 );

select * from member_in order by m_no desc;

commit;

