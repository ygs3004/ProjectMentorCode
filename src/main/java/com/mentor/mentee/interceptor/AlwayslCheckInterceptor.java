package com.mentor.mentee.interceptor;

import com.mentor.mentee.domain.User;
import com.mentor.mentee.service.HomeWorkService;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AlwayslCheckInterceptor implements HandlerInterceptor {

    private User loginUserBean;
    private HomeWorkService homeWorkService;

    public AlwayslCheckInterceptor(User loginUserBean, HomeWorkService homeWorkService) {
        this.loginUserBean = loginUserBean;
        this.homeWorkService = homeWorkService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        boolean checkHomeWork = false;

        if (loginUserBean.isUserLogin()) {
            if(loginUserBean.getStudyNum()>=1) checkHomeWork = homeWorkService.checkHomeWork(loginUserBean.getUserId());

            request.getSession().setAttribute("checkHomeWork", checkHomeWork);
        }

        return true;
    }


}