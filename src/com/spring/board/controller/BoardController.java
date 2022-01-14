package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.service.UserService;
import com.spring.board.vo.MenuVo;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	@Autowired 
	UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,HttpServletRequest req, PageVo pageVo) throws Exception{
															
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<MenuVo> menuList = new ArrayList<MenuVo>();
		HttpSession session = req.getSession();
	
		System.out.println("_______________________________________________________");
		System.out.println("testtttttttttttttttttttttttt BoardList : " + session.getAttribute("login"));
		
		int page = 1;
		int totalCnt = 0;
	
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		//pageVo.type에 선택 type 내용이 "a03,a02" 이런 식으로 들어가 있어서... 괜찮았는데
		menuList = boardService.SelectMenuList("menu");
		boardList = boardService.SelectBoardList(pageVo, menuList);
		totalCnt = boardService.selectBoardCnt();		
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		
		System.out.println("pageVo.getType()" + pageVo.getType());
		
		return "board/boardList";
	}
	
	
	@RequestMapping(value = "/board/boardListAction.do", method = RequestMethod.POST, produces="text/plain; charset=EUC-KR")
		public String boardListAction(Locale locale, Model model,PageVo pageVo) throws Exception{

		int page = 1;
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<MenuVo> menuList = new ArrayList<MenuVo>();

		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		menuList = boardService.SelectMenuList("menu");
		boardList = boardService.SelectBoardList(pageVo,menuList);
	
		model.addAttribute("pageNo", page);
		model.addAttribute("boardList", boardList);
		
		return "board/typeSearchListForm";
	}	
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
//		UserVo userVo;
//		loginVo = userService.selectUser(userVo.getUserId(),userVo.getUserPw());
		
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		System.out.println("____________View____________________");
		System.out.println("boardVo.getCreator"+ boardVo.getCreator());
		System.out.println("____________View____________________");
		int page = 1;
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		model.addAttribute("pageNo", page);
		
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model, HttpServletRequest req) throws Exception{
		HttpSession session = req.getSession();
		System.out.println("_______________________________________________________");
		System.out.println("AAAAAAAAAAAAAAAAAA BoardWrite : " + session.getAttribute("login"));
		List<MenuVo> menuList = new ArrayList<MenuVo>();
		menuList = boardService.SelectMenuList("menu");
		model.addAttribute("menuList", menuList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo,HttpServletRequest req) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int num = boardVo.getBoardVoList().size();
		int check = 0;
		
		HttpSession session = req.getSession();
		
		String creator;
		for(int i=0;i<num;i++) {
			if(boardVo.getBoardVoList().get(i).getBoardTitle() != null) {
				BoardVo Bvo= new BoardVo();
				Bvo = boardVo.getBoardVoList().get(i);
				if (session.getAttribute("login")== null) {
					creator = "";
				}else {
					System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
					System.out.println(boardVo.getBoardVoList().get(0).getCreator());
					creator = boardVo.getBoardVoList().get(0).getCreator();
				}
				Bvo.setCreator(creator);
				
				//boardType에는 code Id가 들어가야하는데 codeId는 jsp에서 List에 menuId라는 변수로 들어가있다. 
				//따라서 select의 value를 list.menuId로 바로 바꿔주면 된다
				Bvo.setBoardType(boardVo.getBoardType());
				int resultCnt =	boardService.boardInsert(Bvo);
				check += resultCnt;		//insert성공시 1이라서
			}
		}
		
		result.put("success", (check == num)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	///update
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method  = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model,PageVo pageVo
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		 
		
		BoardVo boardVo = new BoardVo();
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		//jsp로 데이터 전달
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("pageNo", 1);
		model.addAttribute("board", boardVo);
		
		//board/boardUpdate.jsp로 위의 데이터가 전달되어서 변수처럼 사용할 수 있다. ${boardVo} 요론느낌
		return "board/boardUpdate";
	}
	
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		//update는 삽입된 행의 개수를 반환하므로 0일수 있다. 
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardDelete.do", method = RequestMethod.GET)
	@ResponseBody 
		public String boardDelete(Locale locale, Model model
				,@PathVariable("boardType")String boardType
				,@PathVariable("boardNum")int boardNum) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardType,boardNum);
		
		//delete는 삭제된 행의 개수를 반환하므로 실패했을 때 0이고, 성공시 무조건 양수이다. 따라서 0보다 클 때 Y를 put
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}	
}
