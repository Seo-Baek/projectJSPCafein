create table que(
 que_no number(10) primary key,
 que_genre varchar2(20) not null,
 que_title varchar2(1000),
 que_hit number(5) default 0
);

insert into que values (1, 'beans_aroma', '냄새나 향기에 예민한 편인가요?', default);
insert into que values (2, 'beans_bitter', '홍삼이나 한약을 맛으로 먹나요?', default);
insert into que values (3, 'beans_acidity', '비타민이나 아이셔를 좋아합니다.', default);
insert into que values (4, 'beans_sweet', '당신도 내사랑 초콜릿?', default);
insert into que values (5, 'beans_aroma', '비슷한 향기여도 구별할 수 있어요?',  default);
insert into que values (6, 'beans_bitter', '카카오 초콜릿 99%정도는 심심하지!', default);
insert into que values (7, 'beans_body', '콩나물국 보다 설렁탕을 좋아해요.', default);
insert into que values (8, 'beans_acidity', '사과나 귤같은 과일은 없어서 못먹지!', default);
insert into que values (9, 'beans_body', '우유 쪼아 우유 쪼아 우유 주세용~', default);
insert into que values (10, 'beans_sweet', '아직 초딩입맛 입니다.', default);


commit;


create table que_m(
 q_no number(10) primary key,
 m_no number(10) not null,
 beans_aroma number(10) not null,
 beans_acidity number(10) not null,
 beans_sweet number(10) not null,
 beans_bitter number(10) not null,
 beans_body number(10) not null,
 m_date DATE
);

CREATE SEQUENCE q_seq 
start with 1
increment by 1
nocache;

create view que_v as 
select *
from que_m;