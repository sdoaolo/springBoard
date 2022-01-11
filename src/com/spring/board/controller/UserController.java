package com.spring.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.service.UserService;
import com.spring.board.service.boardService;
import com.spring.board.vo.MenuVo;
import com.spring.board.vo.PageVo;


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
	
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) throws Exception{
		
		return "user/userLogin";
	}
}
