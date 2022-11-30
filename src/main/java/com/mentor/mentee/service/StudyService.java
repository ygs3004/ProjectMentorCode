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
import lombok.extern.slf4j.Slf4j;
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

    // SELECT userInfo BY Id
    public User getUserByID(String userId){
        return userDAO.getUserInfo(userId);
    }

    // SELECT studyInfo BY Id
    public Study getStudyById(String userId){
        Study study = studyMapper.getStudyById(userId);
        getTemp(study);
    return study;
    }

    // SELECT studyInfo BY studyNum
    public Study getStudyByNum(int num){
        Study study = studyMapper.getStudyByNum(num);
        getTemp(study);
        return study;
    }

    // INSERT studyInfo
    public void createStudy(Study study, String userId) {
        if(study.getStudyUserId()==null){
            study.setStudyUserId(userId);
        }
//        study.setStudyNum(0);
        studyMapper.createStudy(study);
        int studyNum = getStudyNumByID(userId); //id로 만들어진 roomNum 조회
        usersAddStudyNum(studyNum, userId);
    }

    // Delete roomInfo
    public void delStudy(String userId){
        studyMapper.delStudyInfo(userId);
        userMapper.updateStudyNum(0, userId);
        loginUserBean.setStudyNum(0);
    }

    // Update study
    public void updateStudy(Study study){
        study.setStudyUserId(loginUserBean.getUserId());
        setTemp(study);
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

    //아이디로 스터디가 있으면 true
    public boolean getAssignedStudyNum(String userId){
        if(studyMapper.getStudyById(userId) == null){
            return false;
        } else{
            return true;
        }
    }

    public PageInfo<Study> getStudyList(Study study){
        PageHelper.startPage(study.getPage(), study.getPageSize());
        List<Study> studies = studyMapper.getStudyList();
        for(Study s : studies){
            getTemp(s);
        }
        return PageInfo.of(studies);
    }

    // insert나 update할때 temp -> set
    public void setTemp(Study study){
        study.setStudyWeekly(String.join(",", study.getTempWeekly()));
        if(study.getTempCareer() ==null) {
            return;
        }else{
            study.setStudyCareer(String.join(",", study.getTempCareer()));
        }
    }

    // select study 할때 set -> temp
    public void getTemp(Study study) {
        study.setTempWeekly(study.getStudyWeekly().split(","));
        if(study.getStudyCareer() == null){
            return;
        }else{
            study.setTempCareer(study.getStudyCareer().split(","));
        }
    }

}
