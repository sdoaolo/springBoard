package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.MenuVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(String boardType, int boardNum) throws Exception;
	
	public List<MenuVo> SelectMenuList() throws Exception ;
	
	
	//이거 밥먹고 와서 하장
	//public String BoardTypeToName(List<BoardVo> boardVo, List<MenuVo> menuVo) throws Exception;
}
