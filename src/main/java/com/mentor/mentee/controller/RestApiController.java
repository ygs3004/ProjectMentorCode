package com.mentor.mentee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.mentor.mentee.service.UserService;

@RestController
public class RestApiController {

	@Autowired
	private UserService userService;
	// 아이디 중복 확인
	@GetMapping("/user/checkUserIdExist/{userId}")
	public String checkUserIdExist(@PathVariable String userId) {

		boolean chk = userService.checkuserIdExist(userId);

		return chk + "";
	}
	// 이메일 중복 확인
	@GetMapping("/user/checkUserEmailExist/{userEmail}")
	public String checkUserEmailExist(@PathVariable String userEmail) {
		System.out.println(userEmail);
		boolean chk1 = userService.checkuserEmailExist(userEmail);
		System.out.println(chk1);
		return chk1 + "";
	}

}
