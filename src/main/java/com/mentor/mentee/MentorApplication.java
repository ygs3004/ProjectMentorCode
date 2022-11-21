package com.mentor.mentee;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@MapperScan
public class MentorApplication {

	public static void main(String[] args) {
		SpringApplication.run(MentorApplication.class, args);
	}

}
