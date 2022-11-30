package com.mentor.mentee.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.mentor.mentee.domain.BoardInfo;
import com.mentor.mentee.service.BoardInfoService;

@Controller
@Slf4j
public class BoardInfoController {

	@Autowired
	private BoardInfoService boardInfoService;

	@GetMapping("/boards")
	public @ResponseBody PageInfo<BoardInfo> getBoards(BoardInfo boardInfo){
		return boardInfoService.selectBoards(boardInfo);
	}

	@GetMapping("/boards/{boardNum}")
	public @ResponseBody BoardInfo getBoards(@PathVariable("boardNum") int boardNum){
		return boardInfoService.selectBoard(boardNum);
	}
	
	@PostMapping("/boards")
	public @ResponseBody int addBoard(@RequestBody BoardInfo boardInfo){
		return boardInfoService.insertBoard(boardInfo);
	}
	
	@PutMapping("/boards")
	public @ResponseBody int modifyBoard(@RequestBody BoardInfo boardInfo){
		log.info("게시판 수정요청 : " + boardInfo);
		return boardInfoService.updateBoard(boardInfo);
	}
	
	@DeleteMapping("/boards")
	public @ResponseBody int removeBoard(@RequestBody BoardInfo boardInfo){
		return boardInfoService.deleteBoard(boardInfo);
	}
}
