package com.spring.board.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.MenuVo;
import com.spring.board.vo.PageVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		//setting : pageVo.setTypelist 
		
		// 체크박스가 하나도 체크 안됐거나, 
		// 그냥 처음 리스트 불러올 땐  null 값이기 때문에
		// NullPointerException이 떳었어서 널체크 해줌! 
		if(pageVo.getType() == null) {
			pageVo.setType("a01,a02,a03,a04"); 
		}
		
	    String[] typeList = pageVo.getType().split(",");
	    pageVo.setTypeList(typeList);

		return boardDao.selectBoardList(pageVo);
		
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		//Dao에서 sql session이용할 때 인자가 한개만 받을 수 있어서 여기서 boardVo로 합친 것.
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.boardInsert(boardVo);
	}
	
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception{
		return boardDao.boardUpdate(boardVo);
	}
	
	@Override
	public int boardDelete(String boardType, int boardNum) throws Exception{
		BoardVo boardVo = new BoardVo();
		//Dao에서 sql session이용할 때 인자가 한개만 받을 수 있어서 여기서 boardVo로 합친 것.
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.boardDelete(boardVo);
	}
	
	@Override
	public List<MenuVo> SelectMenuList() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectMenuList();
	}
	
	@Override
	public List<BoardVo> BoardTypeToName(List<BoardVo> boardList, List<MenuVo> menuList) throws Exception{
		for(int i = 0; i <boardList.size();i++) {
			for(int k = 0; k<menuList.size(); k++) {
				//System.out.println("board: " +boardList.get(i).getBoardType().length());
				//System.out.println("menu: " + menuList.get(k).getMenuId().length());
				//System.out.println("-------------------------------------------");
				if(boardList.get(i).getBoardType().equals( menuList.get(k).getMenuId())) {
					boardList.get(i).setBoardTypeName(menuList.get(k).getMenuName());
					//System.out.println("board: " +boardList.get(i).getBoardType());
					break;
				}
			}
		}
		return boardList;
	}
}
