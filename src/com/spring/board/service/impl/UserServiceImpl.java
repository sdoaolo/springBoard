package com.spring.board.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.UserDao;
import com.spring.board.service.UserService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.UserVo;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDao userDao;
	
	
	@Override
	public UserVo selectUser(String id, String pw) throws Exception{
		UserVo userVo = new UserVo();
		userVo.setUserId(id);
		userVo.setUserPw(pw);

		return userDao.selectUser(userVo);
	}
	
	@Override
	public UserVo userIdUniqueCheck(String id) throws Exception{
		return userDao.userIdUniqueCheck(id);
	}
	
	@Override
	public int userInsert(UserVo userVo) throws Exception{
		return userDao.userInsert(userVo);
	}
	
	@Override
	public int userUpdate(UserVo userVo) throws Exception{
		return userDao.userUpdate(userVo);
	}
	
	@Override
	public int userDelete(String userId, String userPw) throws Exception{
		return userDao.userDelete(userId, userPw);
	}

}
