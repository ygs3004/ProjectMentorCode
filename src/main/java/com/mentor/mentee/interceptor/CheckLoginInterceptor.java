package com.mentor.mentee.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mentor.mentee.service.HomeWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;

import com.mentor.mentee.domain.User;
import org.springframework.web.servlet.ModelAndView;

public class CheckLoginInterceptor implements HandlerInterceptor {

	private User loginUserBean;
	private HomeWorkService homeWorkService;

	public CheckLoginInterceptor(User loginUserBean, HomeWorkService homeWorkService) {
		// TODO Auto-generated constructor stub
		this.loginUserBean = loginUserBean;
		this.homeWorkService = homeWorkService;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		if (loginUserBean.isUserLogin()) {
			request.getSession().setAttribute("loginUser", loginUserBean);
		}

	}
}
