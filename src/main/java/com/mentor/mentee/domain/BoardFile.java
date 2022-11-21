package com.mentor.mentee.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class BoardFile {
    private List<MultipartFile> files;
    private Integer boardSeq;
    private Integer boardReRef;
    private Integer boardReSeq;
    private String boardSubject;
    private String boardContent;
    private Integer boardHits;
    private String delYn;
    private String insUserId;
    private String insDate;
    private String updUserId;
    private String updDate;
}