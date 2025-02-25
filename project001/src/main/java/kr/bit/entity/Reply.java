package kr.bit.entity;

import lombok.Data;

@Data
public class Reply {
	private int idx;
	private int post_id;
	private int ref;
	private int reStep;
	private int reLevel;
	private String userId;
	private String content;
	private String indate;
	private int replyAvailable;
}
