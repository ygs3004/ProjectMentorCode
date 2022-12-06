package com.mentor.mentee.controller;

import com.github.pagehelper.PageInfo;
import com.mentor.mentee.domain.Apply;
import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;
import com.mentor.mentee.service.ApplyService;
import com.mentor.mentee.service.StudyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping
@Slf4j
@RequiredArgsConstructor
public class ApplyController {

    @Resource(name = "loginUserBean")
    private User loginUserBean;
    final ApplyService applyService;
    final StudyService StudyService;

    // 메세지보내기 페이지에 띄울 정보 json
    @GetMapping("/study/get/{studynum}")
    public @ResponseBody Object getStudyByNum(@PathVariable int studynum){
        return StudyService.getStudyByNum(studynum);
    }

    // 멘토에게 스터디 수락요청 메세지 보내기
    @PostMapping("/apply/send-msg")
    public @ResponseBody int insertApply(@RequestBody Apply apply) {
        return applyService.insertApply(apply);
    }

    //멘토로그인- 받은 멘티 요청메세지 출력
    @GetMapping("/apply/getlist")
    public @ResponseBody Object getApplyList (Apply apply){
        log.info("로그인 유저빈 아이디"+loginUserBean.getUserId());
        List<Apply> res = applyService.getApplyList(loginUserBean.getUserId());
        if(res.size() != 0){
            return res;
        }else{
            apply.setStudyTitle(StudyService.getStudyById(loginUserBean.getUserId()).getStudyTitle());
            res.add(apply);
            return res;
        }
    }

    //멘토로그인- 승인리스트
    @GetMapping("/apply/getapproveList")
    public @ResponseBody PageInfo<Apply> getapproveList(Apply apply) {
        return applyService.getApproveList(apply);
    }

    //멘토로그인- 거절리스트
    @GetMapping("/apply/getrefuseList")
    public @ResponseBody PageInfo<Apply> getrefuseList(Apply apply) {
        return applyService.getRefuseList(apply);
    }


    //요청 수락
    @PostMapping("/apply/approve")
    public @ResponseBody int approveMentee (@RequestBody Apply apply){
        return applyService.approveMentee(apply);
    }

    //요청 거절
    @PostMapping("/apply/refuse")
    public @ResponseBody int refuseMentee (@RequestBody Apply apply){
        return applyService.refuseMentee(apply);
    }


    //거절 후 승인
    @PostMapping("/apply/refuseToApprove")
    public @ResponseBody int refuseToApprove (@RequestBody Apply apply){
        return applyService.refuseToApprove(apply);
    }

    //승인 후 거절
    @PostMapping("/apply/approveToRefuse")
    public @ResponseBody int approveToRefuse (@RequestBody Apply apply){
        return applyService.approveToRefuse(apply);
    }


    //멘티로그인- 보낸 메세지 리스트
    @GetMapping("/apply/getmsglist")
    public @ResponseBody PageInfo<Apply> getMsgList() {
        return applyService.getMsgList();
    }

    //멘티로그인 - 보낸 메세지 수정
    @PostMapping("/apply/modifyMsg")
    public @ResponseBody int modifyMsg(@RequestBody Apply apply){
        return applyService.modifyMsg(apply);
    }

    //멘티로그인 - 보낸메세지 삭제
    @PostMapping("/apply/deleteMsg")
    public @ResponseBody int deleteMsg(@RequestBody Apply apply){
        return applyService.deleteMsg(apply);
    }
}