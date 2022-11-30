package com.mentor.mentee.interceptor;

import com.mentor.mentee.domain.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
public class LoginAreaInterceptor implements HandlerInterceptor {

	private User loginUserBean;
	private boolean isTest = false;

	public LoginAreaInterceptor(User loginUserBean) {
		// TODO Auto-generated constructor stub
		this.loginUserBean = loginUserBean;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("로그인이 필요한 url 입장시 체크" + loginUserBean);
		if (!loginUserBean.isUserLogin()) {
			if(isTest) {
				loginUserBean.setUserId("mentor");
				loginUserBean.setUserName("mentor");
				loginUserBean.setUserIdx(1);
				loginUserBean.setUserLogin(true);
				return true;
			}
			String contextPath = request.getContextPath();
			if(String.valueOf(request.getRequestURI()).equals("/study/getstudylist")) return true;
			response.sendRedirect(contextPath + "/user/login");
			return false;
		}

		return true;
	}
}
