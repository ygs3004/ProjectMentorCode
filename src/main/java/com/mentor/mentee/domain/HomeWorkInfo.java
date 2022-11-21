package com.mentor.mentee.domain;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@RequiredArgsConstructor
public class HomeWorkInfo {

	private Integer hwInfoNum; // primary key
    private String hwInfoName; // 과제 제목
    private String hwInfoContent; // 숙제 내용
    private String hwInfoMentor; // 과제 내준 멘토
    private Date hwInfoRegDate; // 과제 등록일
    private Date hwInfoDeadline; // 과제 제한 기간
    private Integer hwInfoComplete; // 현재 관제 제출자

}