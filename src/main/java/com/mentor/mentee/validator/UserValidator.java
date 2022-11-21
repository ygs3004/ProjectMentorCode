package com.mentor.mentee.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.mentor.mentee.domain.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserValidator implements Validator {

	private User loginUserBean;
	public UserValidator(User loginUserBean) {
		this.loginUserBean = loginUserBean;
	}
    @Override
    public boolean supports(Class<?> clazz) {
        // TODO Auto-generated method stub
        return User.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        // TODO Auto-generated method stub
        User userBean = (User) target;

        String beanName = errors.getObjectName();
        System.out.println(beanName);
        
        if(!beanName.equals("tempLoginUserBean") && !beanName.equals("modifyUserBean") && !beanName.equals("deleteUserBean")) {
            if (beanName.equals("joinUser") ) {
                if (userBean.getUserPw().equals(userBean.getUserPw2()) == false) {
                    errors.rejectValue("userPw", "NotEquals");
                    errors.rejectValue("userPw2", "NotEquals");
                }
            }

            if (beanName.equals("joinUser")) {

                if (userBean.isUserIdExist() == false) {
                    errors.rejectValue("userId", "DontCheckUserIdExist");
                }
            }
            if (userBean.isUserEmailExist() == false) {
                errors.rejectValue("userEmail", "DontCheckUserEmailExist");
            }

        }if(beanName.equals("modifyUserBean")){
            if (userBean.getUserPw().equals(userBean.getUserPw2()) == false) {
                errors.rejectValue("userPw", "NotEquals");
                errors.rejectValue("userPw2", "NotEquals");
            }
            if (userBean.isUserEmailExist() == false) {
                errors.rejectValue("userEmail", "DontCheckUserEmailExist");
            }
        }if(beanName.equals("deleteUserBean")) {
        	if (!userBean.getUserPw().equals(loginUserBean.getUserPw())) {
                errors.rejectValue("userPw", "NotEquals");
            }

            
        }
    }
}
