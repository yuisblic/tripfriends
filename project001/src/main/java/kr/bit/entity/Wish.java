package kr.bit.entity;

import lombok.Data;

@Data
public class Wish {
	private String userId;	//현재 로그인한 회원
	private int idx;		//게시물 고유번호
	private String writerId;//게시물 작성자
}
