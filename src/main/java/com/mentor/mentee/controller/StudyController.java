package com.mentor.mentee.controller;

import com.github.pagehelper.PageInfo;
import com.mentor.mentee.dao.UserDao;
import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;
import com.mentor.mentee.service.ApplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.mentor.mentee.service.StudyService;
import com.mentor.mentee.service.HomeWorkService;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping
@Slf4j
@RequiredArgsConstructor
public class StudyController {

    @Resource(name = "loginUserBean")
    private User loginUserBean;
    final UserDao userDao;
    final StudyService StudyService;
    final HomeWorkService homeWorkService;

    @GetMapping("/study/info")
    public String myStudy(HttpServletRequest request, Model model, @RequestParam(value="studynum", required=false, defaultValue="0") int studynum) {
         if(studynum == 0){
            if(!StudyService.getAssignedStudyNum(loginUserBean.getUserId()) & loginUserBean.getUserRole()==1){
                return "redirect:/study/create";
            } else {
                // 접속한 회원의 멘토룸 정보
                log.info("접속한 loginUserBean : " + loginUserBean);

                String userId = loginUserBean.getUserId();
                int studyNum = loginUserBean.getStudyNum();
                Study study = StudyService.getStudyByNum(studyNum);

                //접속한 회원의 과제 유무 체크
                boolean checkHomeWork = homeWorkService.checkHomeWork(userId);
                model.addAttribute("study", study);
                model.addAttribute("checkHomeWork", checkHomeWork);
                return "/study/study-info";
            }
        }else{
        boolean checkHomeWork = homeWorkService.checkHomeWork(loginUserBean.getUserId());
        Study study = StudyService.getStudyByNum(studynum);
        model.addAttribute("study", study);
        model.addAttribute("checkHomeWork", checkHomeWork);
        return "/study/study-info";
        }
    }


    // 스터디개설 form으로 이동
    @GetMapping("/study/create")
    public String goCreateStudy(HttpServletResponse response) throws IOException {
        //userId 앞으로 개설된 방 있는지 확인
        boolean result = StudyService.getAssignedStudyNum(loginUserBean.getUserId());
        if (result) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('스터디는 한개만 개설할 수 있습니다.');</script>");
            out.close();
//            request.setAttribute("message", "스터디는 한개만 개설할 수 있습니다.");
            return "redirect:/";
        } else {
            return "/study/study-create";
        }
    }

    // 스터디개설 후 이동
    @PostMapping("/study/insert")
    public String insertStudy(Study study) {
        StudyService.setTemp(study);
        StudyService.createStudy(study, loginUserBean.getUserId());
        return "redirect:/study/info";
    }


    // 스터디 수정 form으로 이동
    @GetMapping("/study/modify")
    public String goModifyStudy(Model model) {
        model.addAttribute("study", StudyService.getStudyById(loginUserBean.getUserId()));
        return "/study/study-modify";
    }


    // study 수정
    @PostMapping("/study/update")
    public String updateStudy(Study study) {
        StudyService.updateStudy(study);
        return "redirect:/study/info";
    }

    // 스터디 삭제
    @GetMapping("/study/delete")
    public String delStudy() {
        StudyService.delStudy(loginUserBean.getUserId());
        return "redirect:/";
    }

    @GetMapping("/study/list")
    public String goStudyList() {
        return "/study/study-list";
    }

    // json으로 info보내기
    @GetMapping("/study/getstudy")
    public @ResponseBody Study getStudy() {
        int studynum = StudyService.getStudyNumByID(loginUserBean.getUserId());
        return StudyService.getStudyByNum(studynum);
    }


    // 스터디리스트 json
    @GetMapping("/study/getstudylist")
    public @ResponseBody PageInfo<Study> getStudyList(Study study) {
        log.info("study list 호출");
        log.info(study.toString());
        return StudyService.getStudyList(study);
    }



}