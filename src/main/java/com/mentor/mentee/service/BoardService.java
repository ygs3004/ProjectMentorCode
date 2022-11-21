package com.mentor.mentee.service;
 
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mentor.mentee.domain.BoardFile;
import com.mentor.mentee.mapper.BoardMapper;
 
@Service
public class BoardService {

    protected final Logger logger = LoggerFactory.getLogger(BoardService.class);


    @Autowired
    BoardMapper mapper;


	public int insertBoard(BoardFile boardFile) {
		return mapper.insertBoard(boardFile);
	}
	public List<BoardFile> selectBoards(BoardFile boardFile){
		return mapper.selectBoards(boardFile);
	}
	public int updateBoard(BoardFile boardFile) {
		return mapper.updateBoard(boardFile);
	}
}