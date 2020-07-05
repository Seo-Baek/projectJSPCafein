-- faq 테이블 생성

create table faq (
    faq_no number(5)  primary key,       -- 글번호
    faq_title varchar2 (500) not null,       -- 글제목
    faq_cont varchar2(1000) not null      -- 글내용
     
);


create sequence faq_seq
start with 1
increment by 1
nocache;

insert into faq values(faq_seq.nextval, '회원이 되면 어떤 혜택이 있나요?', '저희 CAFE:IN 회원이 되시면 비회원으로 이용하셨을 때 보다, 더욱 많은 혜택을 누리실 수 있습니다.' );
insert into faq values(faq_seq.nextval, '회원가입을 할 때 나이 제한이 있나요?', '나이제한 없이 누구나 CAFE:IN 회원으로 가입하실 수 있습니다.' );
insert into faq values(faq_seq.nextval, '회원 탈퇴 시 개인정보는 언제 삭제되나요?', 'CAFE:IN 규정에 의거하여 회원탈퇴 시 바로 삭제됩니다. ' );
insert into faq values(faq_seq.nextval, '아이디를 변경하고 싶어요.', '아이디 변경은 불가능합니다.아이디 변경을 원하실 경우, 회원 탈퇴 후 새로운 아이디로 재가입을 하셔야 합니다.' );
insert into faq values(faq_seq.nextval, '회원탈퇴를 하게되면 어떻게 되나요?', '회원 탈퇴시 회원님의 회원정보는 삭제 됩니다. 그러나, 탈퇴 전 작성하신 게시글은 자동으로 삭제되지 않습니다.' );
insert into faq values(faq_seq.nextval, '회원탈퇴는 어디서 하나요?', '회원탈퇴는 마이페이지 메뉴 -> 회원탈퇴 에서 가능합니다.' );
insert into faq values(faq_seq.nextval, '회원가입을 할 때, 이미 가입된 회원이라고 나와요.', '확인이 힘드실 경우엔 저희 CAFE:IN 고객센터 ☎ 1566-1004 로 연락주시면 확인해 드리도록 하겠습니다.' );
insert into faq values(faq_seq.nextval, '임시비밀번호를 받고싶은데 이메일주소와 휴대전화번호가 변경되어 확인할수없어요.', '회원정보에 등록된 이메일주소와 휴대폰 번호가 변경되어 회원정보 수정을 원하시는 경우
고객센터☎1566-1004로 문의하여 주시면 친절히 답변 드리겠습니다.' );






