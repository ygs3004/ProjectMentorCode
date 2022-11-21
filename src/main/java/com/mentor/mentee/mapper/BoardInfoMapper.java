package com.mentor.mentee.mapper;

import java.util.List;

import com.mentor.mentee.domain.BoardInfo;

public interface BoardInfoMapper {

	List<BoardInfo> selectBoards(BoardInfo boardModel);
	BoardInfo selectBoard(int boardNum);
	int insertBoard(BoardInfo boardModel);
	int updateBoard(BoardInfo boardModel);
	int deleteBoard(BoardInfo boardModel);
}
