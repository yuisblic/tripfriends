package kr.bit.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	  private int idx;
	  private String categori;
	  private String userId;
	  private String title;
	  private String content;
	  private String indate;	//작성일
	  private int count;		//조회수
	  private int wish;			//찜수
}
