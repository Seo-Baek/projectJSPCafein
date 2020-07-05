--------------------------------------------------------
--  파일이 생성됨 - 월요일-4월-20-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence INFO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "GENIE"."INFO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 54 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for View BEANS_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GENIE"."BEANS_V" ("INFO_NO", "COUN_NO", "BEANS_COUN", "BEANS_COUNADD", "BEANS_AROMA", "BEANS_ACIDITY", "BEANS_SWEET", "BEANS_BITTER", "BEANS_BODY", "INFO_TITLE", "INFO_CONT", "INFO_FILE") AS 
  select b.info_no, b.coun_no, c.info_title beans_coun, c.coun_add beans_counadd, b.beans_aroma, b.beans_acidity, b.beans_sweet, b.beans_bitter, b.beans_body, b.info_title, b.info_cont, b.info_file 
from beans b, country c 
where b.coun_no=c.coun_no 
order by b.info_no desc
;
--------------------------------------------------------
--  DDL for View INFO_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GENIE"."INFO_V" ("INFO_NO", "INFO_GENRE", "INFO_TITLE", "INFO_HIT", "INFO_DATE", "INFO_FILE") AS 
  select g.info_no, i.info_genre, g.info_title, i.info_hit, i.info_date, g.info_file
from info i,
(select info_no, info_title,info_file from info union
select info_no, info_title, info_file from beans union
select info_no, info_title, info_file from country union
select info_no, info_title, info_file from extra) g
where i.info_no=g.info_no and g.info_title is not null
order by i.info_no desc
;
REM INSERTING into GENIE.BEANS_V
SET DEFINE OFF;
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (45,306,'탄자니아','탄자니아',4,5,3,3,4,'탄자니아 AA',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (44,305,'케냐','케냐',4,5,3,3,4,'케냐 AA',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (43,304,'짐바브웨','짐바브웨',4,5,3,3,4,'짐바브웨 AA+',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (42,303,'말라위','말라위',5,3,3,4,4,'말라위 AAA+',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (41,302,'르완다','르완다',2,3,3,3,4,'르완다 AB+',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (40,301,'에티오피아','에티오피아',4,5,3,3,4,'에티오피아 시다모 G2',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (39,301,'에티오피아','에티오피아',4,5,3,3,4,'예가체프',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (38,211,'페루','페루',5,4,4,3,4,'HB GRADE1',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (37,210,'온두라스','온두라스',3,4,2,2,3,'SHG',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (36,209,'브라질','브라질',4,3,3,2,2,'산토스 디카페인',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (35,209,'브라질','브라질',4,3,3,2,2,'산토스',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (34,208,'도미니카','도미니카',2,4,3,2,1,'도미니카 AA',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (33,207,'파나마','파나마',5,4,3,4,3,'파나마 SHB',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (32,206,'코스타리카','코스타리카',3,3,4,3,2,'코스타리카 SHB',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (31,205,'엘살바도르','엘살바도르',4,3,3,2,2,'펜시SHB',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (30,204,'멕시코','멕시코',4,3,3,2,2,'알투라SHB',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (29,203,'니카라과','니카라과',3,4,3,3,3,'니카라과 SHB',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (28,202,'과테말라','과테말라',5,4,3,3,4,'과테말라 SHB',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (27,201,'콜롬비아','콜롬비아',5,5,3,2,3,'엑셀소 디카페인',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (26,201,'콜롬비아','콜롬비아',5,5,3,2,3,'콜롬비아 수프리모',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (25,102,'인도','인도',5,4,4,3,4,'인도 몬순드 말리바',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (24,101,'인도네시아','인도네시아',4,5,3,2,4,'인도네시아 토라자',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (23,101,'인도네시아','인도네시아',4,4,3,2,3,'인도네시아 가요 마운틴',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (22,101,'인도네시아','인도네시아',4,2,3,2,3,'인도네시아 발리 칸타마니',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (21,101,'인도네시아','인도네시아',4,2,5,2,4,'인도네시아 만델링',null);
Insert into GENIE.BEANS_V (INFO_NO,COUN_NO,BEANS_COUN,BEANS_COUNADD,BEANS_AROMA,BEANS_ACIDITY,BEANS_SWEET,BEANS_BITTER,BEANS_BODY,INFO_TITLE,INFO_FILE) values (20,101,'인도네시아','인도네시아',4,2,3,2,4,'자바',null);
REM INSERTING into GENIE.INFO_V
SET DEFINE OFF;
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (53,'info','커피의 효능',21,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (52,'info','커피의 시작',23,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (51,'extra','프렌치프레스',12,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (50,'extra','터키쉬커피',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (49,'extra','핸드드립',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (48,'country','베트남',29,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (47,'extra','콜드브루',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (46,'extra','에스프레소',7,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (45,'beans','탄자니아 AA',38,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (44,'beans','케냐 AA',21,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (43,'beans','짐바브웨 AA+',16,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (42,'beans','말라위 AAA+',12,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (41,'beans','르완다 AB+',7,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (40,'beans','에티오피아 시다모 G2',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (39,'beans','예가체프',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (38,'beans','HB GRADE1',3,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (37,'beans','SHG',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (36,'beans','산토스 디카페인',10,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (35,'beans','산토스',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (34,'beans','도미니카 AA',3,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (33,'beans','파나마 SHB',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (32,'beans','코스타리카 SHB',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (31,'beans','펜시SHB',0,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (30,'beans','알투라SHB',0,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (29,'beans','니카라과 SHB',2,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (28,'beans','과테말라 SHB',3,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (27,'beans','엑셀소 디카페인',3,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (26,'beans','콜롬비아 수프리모',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (25,'beans','인도 몬순드 말리바',2,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (24,'beans','인도네시아 토라자',3,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (23,'beans','인도네시아 가요 마운틴',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (22,'beans','인도네시아 발리 칸타마니',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (21,'beans','인도네시아 만델링',2,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (20,'beans','자바',7,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (19,'country','탄자니아',27,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (18,'country','케냐',17,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (17,'country','짐바브웨',24,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (16,'country','말라위',13,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (15,'country','르완다',9,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (14,'country','에티오피아',11,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (13,'country','페루',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (12,'country','온두라스',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (11,'country','브라질',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (10,'country','도미니카',7,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (9,'country','파나마',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (8,'country','코스타리카',7,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (7,'country','엘살바도르',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (6,'country','멕시코',3,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (5,'country','니카라과',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (4,'country','과테말라',5,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (3,'country','콜롬비아',4,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (2,'country','인도',6,to_date('20/04/14','RR/MM/DD'),null);
Insert into GENIE.INFO_V (INFO_NO,INFO_GENRE,INFO_TITLE,INFO_HIT,INFO_DATE,INFO_FILE) values (1,'country','인도네시아',4,to_date('20/04/14','RR/MM/DD'),null);
