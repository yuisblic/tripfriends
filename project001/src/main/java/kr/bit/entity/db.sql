create table user_tbl(
	userId varchar(50) not null,
	userPw varchar(68) not null,
	userName varchar(50) not null,
	userEmail varchar(100) not null,
	userProfile varchar(50),
	primary key(userId)
);

ALTER TABLE user_tbl
ADD userProfile varchar(50);


select * from user_tbl;

delete from user_tbl where userName='마영숙';

ALTER TABLE user_tbl MODIFY COLUMN userPw varchar(68);
drop table user_tbl;
drop table board_tbl;

create table board_tbl(
	idx int not null auto_increment,
	categori varchar(50) not null,
	userId varchar(50) not null,
	title varchar(100) not null,
	content varchar(2000) not null,
	indate datetime default now(),
	count int default 0,
	wish int default 0,
	primary key(idx)
);

ALTER TABLE board_tbl MODIFY COLUMN content LONGTEXT;

select title, content from board_tbl where idx=26;
delete from board_tbl;

insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','파리 여행','에펠탑과 루브르 박물관을 꼭 방문해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','로마의 역사','콜로세움과 바티칸 시국에서 고대 로마의 숨결을 느껴보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','베니스 운하 투어','곤돌라를 타고 로맨틱한 베니스 운하를 둘러보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','스위스 알프스','융프라우 등정과 아름다운 산악 풍경을 감상하세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','암스테르담 자전거 여행','운하를 따라 자전거를 타며 네덜란드의 풍차를 구경해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','프라하의 야경','천문시계와 카를교에서 아름다운 야경을 즐겨보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','그리스 산토리니','에게해의 푸른 바다와 하얀 집들이 어우러진 풍경을 감상하세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','스페인 바르셀로나','가우디의 건축물과 람블라스 거리를 탐험해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','아이슬란드 오로라','겨울에 방문하여 신비로운 오로라를 감상해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','독일 옥토버페스트','뮌헨에서 열리는 세계 최대의 맥주 축제를 즐겨보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','크로아티아 해변','아드리아해의 아름다운 해변과 두브로브니크 성벽을 걸어보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','스코틀랜드 고성','에든버러 성과 하이랜드의 중세 고성들을 탐험해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','노르웨이 피요르드','거대한 빙하가 만든 장엄한 피요르드를 크루즈로 둘러보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','포르투갈 와인 투어','포르토에서 유명한 포트와인 시음을 즐겨보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','오스트리아 음악 여행','비엔나에서 모차르트와 슈트라우스의 음악을 감상해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','체코 온천 휴양','카를로비 바리에서 유럽의 유명 온천을 경험해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','헝가리 부다페스트','세체니 다리와 국회의사당의 아름다운 야경을 감상하세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','아일랜드 절경','모허 절벽과 아름다운 아일랜드 시골 풍경을 감상하세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','벨기에 초콜릿 투어','브뤼셀에서 세계적으로 유명한 벨기에 초콜릿을 맛보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','폴란드 역사 탐방','크라쿠프의 구시가지와 비극의 역사가 담긴 아우슈비츠를 방문해보세요.',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','ma8662','핀란드 사우나 체험','헬싱키에서 전통 핀란드 사우나를 즐겨보세요.',10);


insert into board_tbl (categori, userId, title, content, wish) 
values('sa','ma8662','치앙마이 가실분','교토',90);
insert into board_tbl (categori, userId, title, content, wish) 
values('mg','hgd','고비사막 같이 가요','교토로',500);
insert into board_tbl (categori, userId, title, content, wish) 
values('sa','osj0310','필리핀 어학연수 알려주세요','교토로 같',70);
insert into board_tbl (categori, userId, title, content, wish) 
values('eu','qwe','체코 프라하 크리스마켓 갈래요','교토로 같이',11);

create table wishList(
	userId varchar(50) not null,
	idx int not null,
	writerId varchar(50) not null,
	primary key(userId, idx),
	foreign key(userId) references user_tbl(userId) on delete cascade,
	foreign key(idx) references board_tbl(idx) on delete cascade,
	foreign key(writerId) references user_tbl(userId) on delete cascade
);

select * from wishList;
delete from wishList;
drop table wishList;

select b.idx, b.categori, b.userId, b.title, b.content, b.indate, b.count, b.wish
from wishList wl
join board_tbl b on wl.idx=b.idx
where wl.userId = 'qwe';

create table reply_tbl (
	idx int auto_increment primary key,
    post_id int not null,               -- 해당 댓글이 속한 게시글 ID
    ref int default 0,
    reStep int default 0,          
    reLevel int default 0,
    userId varchar(50) not null,        -- 댓글 작성자 ID
    content varchar(2000) not null,     -- 댓글 내용
    indate datetime default now(),      -- 댓글 작성 시간
    replyAvailable int default 0    	-- 댓글 삭제 여부 (1=삭제)
);


select * from reply_tbl where post_id='56';
delete from reply_tbl;
drop table reply_tbl;

select * from reply_tbl where idx='3';

select * from reply_tbl where post_id='56'
order by ref asc, reStep asc, indate asc




