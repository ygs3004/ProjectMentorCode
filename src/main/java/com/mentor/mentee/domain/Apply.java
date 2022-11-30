package com.mentor.mentee.domain;

import lombok.*;

@Setter
@Getter
@ToString
public class Apply {

    private String studyTitle;

    private Integer applyNum;
    private String applyMentorId;
    private String applyMenteeId;
    private String applyMsg;
    private Integer applyAor;

}
