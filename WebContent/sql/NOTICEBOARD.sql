--------------------------------------------------------
--  파일이 생성됨 - 금요일-4월-17-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table NOTICEBOARD
--------------------------------------------------------

  CREATE TABLE "GENIE"."NOTICEBOARD" 
   (	"BOARD_NO" NUMBER(5,0), 
	"BOARD_MNO" NUMBER(5,0), 
	"BOARD_WRITER" VARCHAR2(100 BYTE), 
	"BOARD_TITLE" VARCHAR2(100 BYTE), 
	"BOARD_CONT" VARCHAR2(2000 BYTE), 
	"BOARD_FILE" VARCHAR2(200 BYTE), 
	"BOARD_PWD" VARCHAR2(100 BYTE), 
	"BOARD_HIT" NUMBER(6,0) DEFAULT 0, 
	"BOARD_INIT" DATE, 
	"BOARD_DATE" DATE DEFAULT to_char(to_date('99/01/01', 'yy/MM/dd')), 
	"BOARD_SHOW" NUMBER(3,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into GENIE.NOTICEBOARD
SET DEFINE OFF;
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (1,1,'1','1','1','1','1',1,to_date('20/04/04','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),1);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (2,1,'백서진','test_title','<p>testing cont</p><p><br></p><p><br></p><p><br></p><p><img style="width: 295.5px;" src="uploadFile/2020-4-16/59431043-3f4e-4d0d-9d2f-f9ae5aa719cb백서진birth01.jpg
"><br></p>','uploadFile/2020-4-16/2020-4-16_thumb/18e5d856-5059-4949-83b8-421946080186백서진book2_thumb.PNG','0000',0,to_date('20/04/16','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (3,1,'백서진','한글입니다.','<p><img src="uploadFile/2020-4-16/0d63cbd3-9674-4a0d-b5af-a3fe06eedd9d백서진book1.png
" style="width: 130px;"><br></p>',null,'0000',0,to_date('20/04/16','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (4,1,'백서진','test_title','<p>testing cont</p><p><br></p><p><br></p><p><br></p><p><img style="width: 295.5px;" src="uploadFile/2020-4-16/59431043-3f4e-4d0d-9d2f-f9ae5aa719cb백서진birth01.jpg
"><br></p>','uploadFile/2020-4-16/2020-4-16_thumb/2020-4-16_thumb_thumb.PNG','0000',0,to_date('20/04/16','RR/MM/DD'),to_date('99/01/01','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (5,1,'백서진','test_title','<p>testing cont</p><p>asdfadsfsdafadsf</p><p><br></p><p><br></p><p><img style="width: 295.5px;" src="uploadFile/2020-4-16/59431043-3f4e-4d0d-9d2f-f9ae5aa719cb백서진birth01.jpg
">sadfsdffffff<br></p>','uploadFile/2020-4-16/2020-4-16_thumb/2020-4-16_thumb_thumb.PNG','0000',0,to_date('20/04/16','RR/MM/DD'),to_date('99/01/01','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (6,1,'백서진','test_title','<p>testing cont</p><p><br></p><p><br></p><p><br></p><p><img style="width: 295.5px;" src="uploadFile/2020-4-16/59431043-3f4e-4d0d-9d2f-f9ae5aa719cb백서진birth01.jpg
"><br></p>','uploadFile/2020-4-16/2020-4-16_thumb/2020-4-16_thumb_thumb.PNG','0000',0,to_date('20/04/16','RR/MM/DD'),to_date('99/01/01','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (7,1,'백서진','Cafe : In 정보광장 이용 안내','<p><img src="uploadFile/2020-4-17/c60c404b-999f-4539-93e1-788131ec1a4e백서진정보광장-기본공지.png
" style="width: 723px; height: 1022.4px;"></p><p><br></p><p><br></p><p>안녕하세요 Cafe : in 운영진입니다.</p><p>우리 홈페이지는 맛있는 커피로 한잔의 여유를 즐기길 바라는 마음으로 만들어진 곳으로,</p><p>정보 광장을 이용하실 때에는 커피에 관련된 자료를 위주로 올려주시길 부탁드려요.</p><p><br></p><p>다음은 이용 안내입니다.</p><p>1.&nbsp; 욕설 금지</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 서로에게 따듯한 마음으로 다시 한 번 생각하고 게재하기로 해요!</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; (심한 싸움이 일어날 시 강제 탈퇴 될 수 있으니 주의하세요.)<br></p><p>2. Cafe : in은 커피에 관련된 광고를 막지 않습니다.</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 다만 노골적인 광고와 도배는 삼가주시고, 배너 광고 등을 원할 시 cafe.in.contact@gmail.com으로 메일링해주세요!</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 선정적인 광고와 무의미한 도배는 예고없이 강제탈퇴의 이유가 됩니다..!</p><p>3. 심한 친목 관계는 자제해주세요!</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 처음 들어오시는 분들도 함께 반겨주는 향기로운 카페인이 되어주세요!<br></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 또한, 심한 친목으로 인하여 외부에서 일어날 수 있는 일들은 Cafe :in에서 책임지지 않으니 주의 부탁드립니다.</p><p><br></p><p><br></p><p>여러분의 향기로 Cafe : in을 아름답게 만들어주세요</p><p>저희는 바쁜 일상, 당신이 커피와 함께 반짝이는 여유를 즐길 수 있도록 노력하겠습니다.</p><p><br></p><p>- Cafe : in 운영진 드림 -&nbsp;</p><p>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>','uploadFile/2020-4-17/2020-4-17_thumb/43e5250c-58e1-4004-83c0-1f63c27ef866백서진Thumbnail_Cookie_thumb.PNG','0000',0,to_date('20/04/17','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),1);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (8,1,'백서진','test_title','<p>testing cont</p><p><br></p><p><br></p><p><br></p><p><br></p>','uploadFile/2020-4-16/2020-4-16_thumb/2020-4-16_thumb_thumb.PNG','0000',0,to_date('20/04/17','RR/MM/DD'),to_date('99/01/01','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (9,1,'백서진','test_title','<p>testing cont</p><p><br></p><p><br></p><p><br></p><p><br></p>','uploadFile/2020-4-16/2020-4-16_thumb/2020-4-16_thumb_thumb.PNG','0000',0,to_date('20/04/17','RR/MM/DD'),to_date('99/01/01','RR/MM/DD'),0);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (10,1,'백서진','Cafe : In 정보광장 이용 안내','<p><img src="uploadFile/2020-4-17/c60c404b-999f-4539-93e1-788131ec1a4e백서진정보광장-기본공지.png
" style="width: 723px; height: 1022.4px;"></p><p><br></p><p><br></p><p>안녕하세요 Cafe : in 운영진입니다.</p><p>우리 홈페이지는 맛있는 커피로 한잔의 여유를 즐기길 바라는 마음으로 만들어진 곳으로,</p><p>정보 광장을 이용하실 때에는 커피에 관련된 자료를 위주로 올려주시길 부탁드려요.</p><p><br></p><p>다음은 이용 안내입니다.</p><p>1.&nbsp; 욕설 금지</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 서로에게 따듯한 마음으로 다시 한 번 생각하고 게재하기로 해요!</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; (심한 싸움이 일어날 시 강제 탈퇴 될 수 있으니 주의하세요.)<br></p><p>2. Cafe : in은 커피에 관련된 광고를 막지 않습니다.</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 다만 노골적인 광고와 도배는 삼가주시고, 배너 광고 등을 원할 시 cafe.in.contact@gmail.com으로 메일링해주세요!</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 선정적인 광고와 무의미한 도배는 예고없이 강제탈퇴의 이유가 됩니다..!</p><p>3. 심한 친목 관계는 자제해주세요!</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 처음 들어오시는 분들도 함께 반겨주는 향기로운 카페인이 되어주세요!<br></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; - 또한, 심한 친목으로 인하여 외부에서 일어날 수 있는 일들은 Cafe :in에서 책임지지 않으니 주의 부탁드립니다.</p><p><br></p><p><br></p><p>여러분의 향기로 Cafe : in을 아름답게 만들어주세요</p><p>저희는 바쁜 일상, 당신이 커피와 함께 반짝이는 여유를 즐길 수 있도록 노력하겠습니다.</p><p><br></p><p>- Cafe : in 운영진 드림 -&nbsp;</p>','uploadFile/2020-4-17/2020-4-17_thumb/2020-4-17_thumb_thumb.PNG','0000',0,to_date('20/04/17','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),1);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (11,1,'백서진','2020.04.17  회원 이용 규정 위반 유저 공지','<p><br></p><h3 style="text-align: center; ">20.04.17 규정 위반 회원 공지입니다.</h3><p style="text-align: center; "><br></p><p style="text-align: center; ">우리 카페는 운영진 뿐만 아니라 회원 분들도 함께 만들어가는 곳임을 생각해주시고,</p><p style="text-align: center; ">편안한 카페 이용을 위하여 <b><font color="#9c00ff">이용 규정을 올바르게 지켜주시길 </font></b>바랍니다.</p><p style="text-align: center; "><br></p><p style="text-align: center; ">아래 회원들은 아래 위반 사유로 강제 탈퇴 조취 됩니다.</p><p><br></p><table class="table table-bordered" style="background-color: #fff;"><tbody><tr><td style="text-align: center;">아이디</td><td style="text-align: center;">이름</td><td style="text-align: center;">위반 사유</td></tr><tr><td>hon***</td><td>황*성</td><td>욕설 및 불편한 분위기 조성</td></tr><tr><td>lon*****</td><td>지*현</td><td>욕설 및 불편한 분위기 조성<br></td></tr><tr><td>int**</td><td>이*영</td><td>부적절한 게시글 게재 및 선정적인 글 작성</td></tr></tbody></table><p style="text-align: center;"><br></p><p style="text-align: center;"><br></p><p style="text-align: center;">앞으로도 즐거운 카페인 생활을 위하여 운영진들이 노력하겠습니다.</p>',null,'0000',0,to_date('20/04/17','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),1);
Insert into GENIE.NOTICEBOARD (BOARD_NO,BOARD_MNO,BOARD_WRITER,BOARD_TITLE,BOARD_CONT,BOARD_FILE,BOARD_PWD,BOARD_HIT,BOARD_INIT,BOARD_DATE,BOARD_SHOW) values (12,1,'백서진','Cafe :in 에서 즐겁게 놀고 Z플랍 받아가자!','<p><img src="uploadFile/2020-4-17/3058a4ff-a46f-4ecb-956d-035e3869aeb4백서진정보광장-톰브라운.png
" style="width: 891px;"><br></p>','uploadFile/2020-4-17/2020-4-17_thumb/29c2c004-4e62-4677-bd8b-e291a5f3f8f7백서진톰브라운_thumb.PNG','0000',0,to_date('20/04/17','RR/MM/DD'),to_date('20/04/17','RR/MM/DD'),1);
--------------------------------------------------------
--  DDL for Index SYS_C007393
--------------------------------------------------------

  CREATE UNIQUE INDEX "GENIE"."SYS_C007393" ON "GENIE"."NOTICEBOARD" ("BOARD_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table NOTICEBOARD
--------------------------------------------------------

  ALTER TABLE "GENIE"."NOTICEBOARD" ADD PRIMARY KEY ("BOARD_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GENIE"."NOTICEBOARD" MODIFY ("BOARD_PWD" NOT NULL ENABLE);
  ALTER TABLE "GENIE"."NOTICEBOARD" MODIFY ("BOARD_CONT" NOT NULL ENABLE);
  ALTER TABLE "GENIE"."NOTICEBOARD" MODIFY ("BOARD_TITLE" NOT NULL ENABLE);
  ALTER TABLE "GENIE"."NOTICEBOARD" MODIFY ("BOARD_WRITER" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table NOTICEBOARD
--------------------------------------------------------

  ALTER TABLE "GENIE"."NOTICEBOARD" ADD CONSTRAINT "NOTICEMNO_FK" FOREIGN KEY ("BOARD_MNO")
	  REFERENCES "GENIE"."MEMBER1" ("MNO") ENABLE;
