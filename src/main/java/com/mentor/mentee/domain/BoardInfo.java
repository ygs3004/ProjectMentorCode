package com.mentor.mentee.domain;

import lombok.Data;

@Data
public class BoardInfo {

	private Integer page;
	private Integer pageSize;
	private Integer boardNum;
	private Integer boardParentNum;
	private Integer level;
	private String boardTitle;
	private String boardFilePath;
	private String boardContent;
	private String credate;
	private String crename;
	private Integer creusr;
	private String moddate;
	private Integer modusr;
	private String order;
	private String searchType;
	private String searchStr;
}
