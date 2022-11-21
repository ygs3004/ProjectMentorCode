package com.mentor.mentee.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ViewController {
	/*
	 * 
	 * 해당클래스의 상단어노테이션이 @Controller일경우
	 * 아래 goHome()메서드의 리턴타입이 스트링이면
	 * 리턴된 값앞에 /WEB-INF/를 붙이고 뒤에다가 .jsp 를 붙인다!
	 */

	@GetMapping("/views/**")
	public String goPage(HttpServletRequest request) {
		String goPath = request.getRequestURI();
		log.info("goPath=>{}", goPath);
		goPath = goPath.substring(6);
		return goPath;
	}
	//  /WEB-INF/views/user/login.jsp
	
	
}
