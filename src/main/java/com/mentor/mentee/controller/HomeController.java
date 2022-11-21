package com.mentor.mentee.controller;

import com.mentor.mentee.domain.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;

@Controller
public class HomeController {

    @Resource(name = "loginUserBean")
    private User loginUserBean;

    @GetMapping("/")
    public String home(){
        return "index";
    }


    @GetMapping("/r")
    public String references(){
        return "reference";
    }



}