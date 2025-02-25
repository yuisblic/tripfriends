package kr.bit.entity;

import lombok.Data;

@Data
public class User {
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private String userProfile;
}
