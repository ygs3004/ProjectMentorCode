package com.mentor.mentee.service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mentor.mentee.dao.UserDao;
import com.mentor.mentee.domain.BoardInfo;
import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;
import lombok.RequiredArgsConstructor;
import com.mentor.mentee.mapper.StudyMapper;
import com.mentor.mentee.mapper.UserMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StudyService {

    @Resource(name = "loginUserBean")
    private User loginUserBean;
    final UserDao userDAO;
    final UserMapper userMapper;
    final StudyMapper studyMapper;

    // GET userInfo BY userId
    public User getUserByID(String userId){
        return userDAO.getUserInfo(userId);
    }

    // GET roomInfo BY user_id
    public Study getStudyById(String userId){
    return studyMapper.getStudyById(userId);
    }

    // GET roomInfo BY studyNum
    public Study getStudyByNum(int num){
        return studyMapper.getStudyByNum(num);
    }

    // Insert roomInfo
    @Transactional
    public void createStudy(Study study, String userId) {
        if(study.getStudyUserId()==null){
            study.setStudyUserId(userId);
        }
        study.setStudyNum(0);
        studyMapper.createStudy(study);
        int studyNum = getStudyNumByID(userId); //id로 만들어진 roomNum 조회
        usersAddStudyNum(studyNum, userId);
    }

    // Delete roomInfo
    public void delStudy(String userId){
        studyMapper.delStudy(userId);
        userMapper.updateStudyNum(0, userId);
        loginUserBean.setStudyNum(0);
    }

    // Update roomInfo
    public void updateStudy(Study study){
        study.setStudyUserId(loginUserBean.getUserId());
        studyMapper.updateStudy(study);
    }

    // Update RoomNUM TO users (BY userId)
    public void usersAddStudyNum(int studyNum, String userId){
        userMapper.updateStudyNum(studyNum, userId);
        loginUserBean.setStudyNum(studyNum);
    }

    // Select RoomNUM (BY userId)
    public int getStudyNumByID(String userId){
        int studyNum = studyMapper.getStudyById(userId).getStudyNum();
        return studyNum;
    }

    //CHECK RoomNum BY userId
    public boolean getAssignedStudyNum(String userId){
        if(studyMapper.getStudyById(userId) == null){
            return false;
        } else{
            return true;
        }
    }

//    public String getMentorIdByNum(int studyNum){
//        return studyMapper.getMentorIdByNum(studyNum);
//    }

    public PageInfo<Study> getStudyList(Study study){
        PageHelper.startPage(study.getPage(), study.getPageSize());

        return PageInfo.of(studyMapper.getStudyList());
    }

}
