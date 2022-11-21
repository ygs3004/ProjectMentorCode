package com.mentor.mentee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mentor.mentee.domain.BoardFile;

@Mapper
public interface BoardMapper {

	int insertBoard(BoardFile boardFile);
	List<BoardFile> selectBoards(BoardFile boardFile);
	int updateBoard(BoardFile boardFile);
}
