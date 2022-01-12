package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.service.UserService;
import com.spring.board.service.boardService;
import com.spring.board.vo.UserVo;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.MenuVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;


@Controller
public class UserController {
	
	@Autowired 
	UserService userService;
	
	@Autowired 
	boardService boardService;
	
	
	@RequestMapping(value = "/user/userJoin.do", method = RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception{
		
		List<MenuVo> menuList = new ArrayList<MenuVo>();
		
		menuList = boardService.SelectMenuList("phone");
		
		model.addAttribute("menuList", menuList);
		
		
		return "user/userJoin";
	}
	@RequestMapping(value = "/board/userJoinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoinAction(Locale locale,UserVo userVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = userService.userInsert(userVo);
		
		result.put("success", (resultCnt>0)?"Y":"N");//insert성공시 1
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) throws Exception{
		
		return "user/userLogin";
	}
}
