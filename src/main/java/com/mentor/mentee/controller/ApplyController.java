package com.mentor.mentee.controller;

import com.mentor.mentee.domain.Apply;
import com.mentor.mentee.domain.User;
import com.mentor.mentee.service.ApplyService;
import com.mentor.mentee.service.StudyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
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

    // 멘토에게 스터디 수락요청 메세지 보내기
    @PostMapping("/apply/send-msg")
    public @ResponseBody int insertApply(@RequestBody Apply apply) {
        return applyService.insertApply(apply);
    }

    // 신청한 멘티 요청메세지 출력
    @GetMapping("/apply/getlist")
    public @ResponseBody List<Apply> getApplyList (Apply apply){
        return applyService.getApplyList(loginUserBean.getUserId());
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

}