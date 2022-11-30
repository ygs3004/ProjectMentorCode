package com.mentor.mentee.domain;

import lombok.*;

@Getter
@Setter
@ToString
public class Study {

    private Integer page;
    private Integer pageSize;
    private Integer studyNum = 0;

    private String[] tempWeekly;
    private String[] tempCareer;

    private String studyUserId;
    private String studyTitle;
    private String studyPeriod;
    private String studyWeekly;
    private String studyStartTime;
    private String studyEndTime;
    private Integer studyCapacity;
    private Integer studyNowCapacity;
    private String studyCareer;
    private String studySchool;
    private String studyContent;

}
