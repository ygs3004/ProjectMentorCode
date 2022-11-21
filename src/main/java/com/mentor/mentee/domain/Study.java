package com.mentor.mentee.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class Study {

    private Integer page;
    private Integer pageSize;
    private Integer studyNum;
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

    public void setStudyWeekly(String[] studyWeekly) {
    	if(studyWeekly==null) return;
        String weekly = String.join(",", studyWeekly);
        this.studyWeekly = weekly;
    }

    public void setStudyCareer(String[] career) {
    	if(career==null) return;
        String careers = String.join(",", career);
        this.studyCareer = careers;
    }

    public String[] getWeeklyList (){
    	if(studyWeekly==null) return null;
        String[] weeklyList = studyWeekly.split(",");
       return weeklyList;
    }

    public String[] getCareerList (){
    	if(studyCareer==null) return null;
        String[] careerList = studyCareer.split(",");
        return careerList;
    }
}
