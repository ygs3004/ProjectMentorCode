package com.mentor.mentee.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.*;

@Data
@Getter
@Setter
public class User {

	public User() {
		this.userIdExist = false;
		this.userEmailExist = false;
		this.userLogin = false;
	}

	private int userIdx; // 회원 고유?번호
	private int StudyNum; 
	private int userRole; // 회원 권한 : 1 - 멘토 , 2 - 멘티

	@Size(min = 2, max = 5)
	@Pattern(regexp = "[가-힣]*")
	private String userName; // 회원 이름
	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String userId;  // 회원 아이디
	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String userPw;  // 비밀번호
	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String userPw2; // 비밀번호확인

	@Email(message = "올바른 이메일 주소를 입력해주세요.")
	private String userEmail; // 이메일 
	@Size(min = 13, max = 13)
	@Pattern(regexp = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$")
	private String userPhone; // 전화번호
	@Pattern(regexp = "[1-2]")
	private String userGender; // 성별 : 1 - 남자 , 2 - 여자 
	@Size(min = 4, max = 20)
	private String userSchool;  // 학교 

	private boolean userIdExist;  // 아이디 중복체크

	private boolean userEmailExist;  // 이메일 중복체크 

	private boolean userLogin;  // 로그인여부


}
