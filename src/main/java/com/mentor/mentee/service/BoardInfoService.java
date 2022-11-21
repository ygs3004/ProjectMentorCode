package com.mentor.mentee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mentor.mentee.domain.BoardInfo;
import com.mentor.mentee.mapper.BoardInfoMapper;

@Service
public class BoardInfoService {
	@Autowired
	private BoardInfoMapper boardInfoMapper; 

	public PageInfo<BoardInfo> selectBoards(BoardInfo boardMdel){
		PageHelper.startPage(boardMdel.getPage(), boardMdel.getPageSize());
		return PageInfo.of(boardInfoMapper.selectBoards(boardMdel));
	}
	public BoardInfo selectBoard(int boardNum){
		return boardInfoMapper.selectBoard(boardNum);
	}
	;
	public int insertBoard(BoardInfo boardMdel){
		return boardInfoMapper.insertBoard(boardMdel);
	}
	public int updateBoard(BoardInfo boardMdel){
		return boardInfoMapper.updateBoard(boardMdel);
	}
	public int deleteBoard(BoardInfo boardMdel){
		return boardInfoMapper.deleteBoard(boardMdel);
	}
	
}
