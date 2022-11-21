package com.mentor.mentee.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import com.mentor.mentee.service.StudyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.mentor.mentee.domain.HomeWork;
import com.mentor.mentee.domain.HomeWorkInfo;
import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;
import com.mentor.mentee.service.HomeWorkService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/homework")
@RequiredArgsConstructor
public class HomeWorkController {

    final HomeWorkService homeWorkService;
    final StudyService studyService;

    @Resource(name = "loginUserBean")
    private User loginUserBean;

    @GetMapping("/upload")
    public String uploadHomeWork(User user){
        return "/homework/homework-upload";
    }

    @PostMapping("/upload-success")
    public String uploadSuccess(HomeWorkInfo homeWorkInfo, Model model){

        String userId = loginUserBean.getUserId();

        homeWorkInfo.setHwInfoMentor(userId);

        int success = homeWorkService.uploadHomeWorkInfo(homeWorkInfo);
        model.addAttribute("homeWorkInfo", homeWorkInfo);

        return "redirect:/homework/info-mentor";
    }

    @GetMapping("/info-mentor")
    public String mentorHomeWorkInfo (Model model) {

        String userId = loginUserBean.getUserId();
        int studyNum = loginUserBean.getStudyNum();

        Study study = studyService.getStudyByNum(studyNum);
        HomeWorkInfo homeWorkInfo = homeWorkService.getHomeWorkInfo(userId);
        List<HomeWork> hwList = homeWorkService.getHomeWorkList(userId);

        model.addAttribute("hwList", hwList);
        model.addAttribute("homeWorkInfo", homeWorkInfo);
        model.addAttribute("study", study);

        return "/homework/homework-info-mentor";
    }

    @GetMapping("/info-mentee")
    public String menteeHomeWorkInfo(Model model){

        int hwStudyNum = loginUserBean.getStudyNum();
        String userId = loginUserBean.getUserId();
        HomeWorkInfo homeWorkInfo = homeWorkService.getHomeWorkInfo(userId);
        HomeWork homeWork = homeWorkService.getHomeWork(hwStudyNum);

        model.addAttribute("homeWork", homeWork);
        model.addAttribute("homeWorkInfo", homeWorkInfo);

        return "/homework/homework-info-mentee";
    }

    @GetMapping("/submit-form")
    public String homeWorkSubmit(Model model){

        String userId = loginUserBean.getUserId();
        HomeWorkInfo homeWorkInfo = homeWorkService.getHomeWorkInfo(userId);

        model.addAttribute("homeWorkInfo", homeWorkInfo);

        return "/homework/homework-submit-form";
    }

    @PostMapping("/submit")
    public String homeWorkSubmit(HomeWork homeWork, MultipartFile[] uploadFile) throws IllegalStateException, IOException{

        homeWorkService.homeWorkSubmit(homeWork, uploadFile);

        return "redirect:/homework/info-mentee";
    }

    @GetMapping("/modify-form")
    public String homeWorkModify(Model model){

        String userId = loginUserBean.getUserId();
        HomeWorkInfo homeWorkInfo = homeWorkService.getHomeWorkInfo(userId);

        model.addAttribute("homeWorkInfo", homeWorkInfo);

        return "/homework/homework-modify-form";
    }

}
