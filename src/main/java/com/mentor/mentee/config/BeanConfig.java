package com.mentor.mentee.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.context.annotation.SessionScope;

import com.mentor.mentee.domain.User;

@Configuration
@EnableScheduling
public class BeanConfig {

    @Bean("loginUserBean")
    @SessionScope
    User loginUserBean() {
        return new User();
    }

}
