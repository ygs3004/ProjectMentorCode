package com.mentor.mentee.service;

import com.github.pagehelper.PageHelper;
import com.mentor.mentee.domain.Apply;
import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;
import com.mentor.mentee.mapper.ApplyMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import javax.annotation.Resource;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ApplyService {

    @Resource(name = "loginUserBean")
    private User loginUserBean;
    final ApplyMapper applyMapper;
    final StudyService studyService;


    // Insert apply
    public int insertApply(Apply apply) {
        apply.setApplyMenteeId(loginUserBean.getUserId());
        return applyMapper.insertApply(apply);
    }

   public List<Apply> getApplyList(String userId) {
       return applyMapper.getApplyList(userId);
    }

    //보낸메세지 중복 체크 여부
    public boolean checkApplyMsg(int studyNum){
        if(applyMapper.checkApplyMsg(studyNum, loginUserBean.getUserId())==1){
            return true;
        }else{
            return false;
        }
    }

    public int approveMentee(Apply apply) {
        return applyMapper.approveMentee(apply.getApplyNum());
    }

    public int refuseMentee(Apply apply) {
        return applyMapper.refuseMentee(apply.getApplyNum());
    }
}
