package com.spring.board.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.service.UserService;
import com.spring.board.vo.PageVo;


@Controller
public class UserController {
	@Autowired 
	UserService userService;

	@RequestMapping(value = "/user/userJoin.do", method = RequestMethod.GET)
	public String userJoin(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		return "user/userJoin";
	}
	
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		return "user/userLogin";
	}
}
