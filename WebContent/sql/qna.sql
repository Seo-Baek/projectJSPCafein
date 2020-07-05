-- qna 테이블

create table qna (
     qna_no number(5)  primary key,                        -- 글번호
     qna_title varchar2 (500) not null,                       -- 글제목
     qna_writer varchar2 (10) not null,                       -- 작성자
     qna_cont varchar2  (1000) not null,                     -- 내용
     qna_pwd varchar2 (20)  not null,                         -- 비밀번호
     qna_file varchar2 (500),                                     		-- 파일 
     qna_date date,                                                     	 -- 업로드 날짜
     qna_group number(4),                                            -- 게시글 그룹
     qna_step number(4),                                               -- 게시글 답변 단계
     qna_indent number(4),                                            -- 답변글 들여쓰기
     qna_modify number(4) default 0                          --수정됨 표시기능
                 
);



create sequence qna_seq
start with 1
increment by 1
nocache;


insert into qna values(qna_seq.nextval,'게시판 문의하기', '서지수','어떤 등급일 때 글쓰기를 할 수 있나요?',1234,null,sysdate,qna_seq.currval,0,0,0);