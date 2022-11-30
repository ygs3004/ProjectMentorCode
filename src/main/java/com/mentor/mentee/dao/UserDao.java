package com.mentor.mentee.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mentor.mentee.domain.User;
import com.mentor.mentee.mapper.StudyMapper;
import com.mentor.mentee.mapper.UserMapper;

@Repository
public class UserDao {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private StudyMapper StudyMapper;

    public String checkUserIdExist(String userId) {
        return userMapper.checkUserIdExist(userId);
    }

    public String checkUserEmailExist(String userEmail) {

        return userMapper.checkUserEmailExist(userEmail);
    }

    public void addUserInfo(User joinUser) {
        userMapper.addUserInfo(joinUser);
    }
    public User getLoginUserInfo(User tempLoginUserBean) {

        System.out.println("dao id : "+tempLoginUserBean.getUserId());
        System.out.println("dao pw : "+tempLoginUserBean.getUserPw());
        System.out.println(tempLoginUserBean.isUserLogin());
        
        return userMapper.getLoginUserInfo(tempLoginUserBean);
    }
    public User getModifyUserInfo(int userIdx) {
        return userMapper.getModifyUserInfo(userIdx);
    }

    public void modifyUserInfo(User modifyUserBean) {
        userMapper.modifyUserInfo(modifyUserBean);
    }

    public User getDeleteUserInfo(int userIdx) {
        return userMapper.getDeleteUserInfo(userIdx);
    }
    public int deleteUserInfo(User deleteUserBean) {
        return userMapper.deleteUserInfo(deleteUserBean);
    }

    public User getUserInfo(String userId){
        return userMapper.getUserInfo(userId);
    }

    public List <User> list(User userListBean) {
		return userMapper.getUserList(userListBean);
	}
    
    public String getMentorId(String userId){
        User user = getUserInfo(userId);
        String mentorId = "";

        // 접속해 있는 유저가 멘티라면
        if(user.getUserRole() == 2){
            int studyNum = user.getStudyNum();
            mentorId = StudyMapper.getStudyByNum(studyNum).getStudyUserId();
        }else{ // 멘티가 아니라면(멘토라면
            mentorId = userId;
        }
        return mentorId;
    }

}
