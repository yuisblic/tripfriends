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
values('jp','ma8662','교토가고 싶어요','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','13','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','14','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','15','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','16','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','17','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','18','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','19','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','20','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','21','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','22','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','23','교',10);
insert into board_tbl (categori, userId, title, content, wish) 
values('jp','ma8662','24','교',10);

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




