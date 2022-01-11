package com.spring.board.dao;

import com.spring.board.vo.UserVo;

public interface UserDao {
	public UserVo selectUser(UserVo userVo) throws Exception;
	
	public int userInsert(UserVo userVo) throws Exception;
	
	public int userUpdate(UserVo userVo) throws Exception;
	
	public int userDelete(String userId, String userPw) throws Exception;
	
}
