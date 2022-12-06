package com.mentor.mentee.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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

    //메세지 요청 받은 리스트 (승인/거절 전)
   public List<Apply> getApplyList(String userId) {
       return applyMapper.getApplyList(userId);
    }


    // 수락 리스트 보내기
    public PageInfo<Apply> getApproveList(Apply apply){
        PageHelper.startPage(apply.getPage(), apply.getPageSize());
        List<Apply> approveList = applyMapper.getApproveList(loginUserBean.getUserId());
        return PageInfo.of(approveList);
    }

    // 거절 리스트 보내기
    public PageInfo<Apply> getRefuseList(Apply apply){
        PageHelper.startPage(apply.getPage(), apply.getPageSize());
        List<Apply> refuseList = applyMapper.getRefuseList(loginUserBean.getUserId());
        return PageInfo.of(refuseList);
    }

    // 보낸메세지 중복 체크 여부
    public boolean checkApplyMsg(int studyNum){
        if(applyMapper.checkApplyMsg(studyNum, loginUserBean.getUserId())==1){
            return true;
        }else{
            return false;
        }
    }

    // 가입요청 승인
    public int approveMentee(Apply apply) {
        applyMapper.approveMentee(apply.getApplyNum());
        int count = applyMapper.getApproveTotal(loginUserBean.getUserId());
        return studyService.updateCapacity(count,loginUserBean.getUserId());
    }

    // 가입요청 거절
    public int refuseMentee(Apply apply) {
        return applyMapper.refuseMentee(apply.getApplyNum());
    }


    // 거절 후 승인
    public int refuseToApprove(Apply apply) {
        applyMapper.approveMentee(apply.getApplyNum());
        studyService.updateCapacity(applyMapper.getApproveTotal(loginUserBean.getUserId()),loginUserBean.getUserId());
        return 1;
    }

    // 승인 후 거절
    public int approveToRefuse(Apply apply) {
        applyMapper.refuseMentee(apply.getApplyNum());
        int num = applyMapper.getApproveTotal(loginUserBean.getUserId());
        System.out.println("nuuuuuuum"+num);
        studyService.updateCapacity(num,loginUserBean.getUserId());
        return 1;
    }

    public PageInfo<Apply> getMsgList(){
        return PageInfo.of(applyMapper.getMsgList(loginUserBean.getUserId()));
    }

    //멘티로그인 보낸메세지수정
    public int modifyMsg(Apply apply){
        return applyMapper.modifyMsg(apply.getApplyMsg(), apply.getApplyNum());
    }

    //멘티로그인 보낸메세지삭제
    public int deleteMsg(Apply apply){
        return applyMapper.deleteMsg(apply.getApplyNum());
    }
}
