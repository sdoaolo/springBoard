package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	@RequestMapping(value = "/board/userCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String userCheck(Locale locale,UserVo userVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		System.out.println("jsp to controller " + userVo.getUserId());
		UserVo checkUser = userService.userIdUniqueCheck(userVo.getUserId());
		
		result.put("success", (Integer.parseInt(checkUser.getUserId()) > 0)?"NotUnique":"Unique");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) throws Exception{
		
		return "user/userLogin";
	}
	

	@RequestMapping(value = "/board/userLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userLoginAction(Locale locale,HttpServletRequest req, UserVo userVo) throws Exception{
		
		HashMap<String, UserVo> result = new HashMap<String, UserVo>();
		CommonUtil commonUtil = new CommonUtil();
		
		System.out.println("jsp to controller " + userVo.getUserId());
		System.out.println("jsp to controller " + userVo.getUserPw());
		
		UserVo loginVo;
		loginVo = userService.selectUser(userVo.getUserId(),userVo.getUserPw());
		
		result.put("success", loginVo);
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		
		HttpSession session = req.getSession();

		if (loginVo == null) {
			session.setAttribute("login", null);
		}
		else {
			session.setAttribute("login", loginVo);
		}		
		
		System.out.println("testtttttttttttttttttttttttttttttt");
		System.out.println("session'login' " + session.getAttribute("login"));		
		System.out.println("testtttttttttttttttttttttttttttttt");
		return callbackMsg;
	}
}
