package com.mentor.mentee.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class HomeWork {

	private Integer hwNum; // primary key
	private Integer hwStudyNum;
    private String hwUserId; //  HomeWork 제출자
    private String hwContent; // 내용

    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date hwRegDate; // 제출일, 수정일
    private String hwUuid; // 파일명 중복방지 id
    private String hwFilename; // 제출 파일 이름
    private String hwUploadPath; // 서버에 저장된 경로

    public void setUuid(String hwUuid) {
        this.hwUuid+= hwUuid+",";
        this.hwUuid = this.hwUuid.replace("null", "");
    }

    public void setFilename(String hwFilename){
        this.hwFilename += hwFilename+",";
        this.hwFilename = this.hwFilename.replace("null", "");
    }

    public void setUploadPath(String hwUploadPath){
        this.hwUploadPath += hwUploadPath +",";
        this.hwUploadPath = this.hwUploadPath.replace("null", "");
    }

}
