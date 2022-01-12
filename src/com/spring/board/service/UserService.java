package com.spring.board.service;

import com.spring.board.vo.UserVo;

public interface UserService {
	public UserVo selectUser(String userId, String userPw) throws Exception;

	public UserVo userIdUniqueCheck(String id) throws Exception;
	
	public int userInsert(UserVo userVo) throws Exception;
	
	public int userUpdate(UserVo userVo) throws Exception;
	
	public int userDelete(String userId, String userPw) throws Exception;
}
