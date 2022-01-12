package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.UserDao;
import com.spring.board.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public UserVo selectUser(UserVo userVo) throws Exception {
		return sqlSession.selectOne("user.userObj", userVo);
	}
	
	@Override
	public UserVo userIdUniqueCheck(String id) throws Exception {
		return	sqlSession.selectOne("user.idCheck",id);
	}
	
	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userInsert", userVo);
	}
	
	@Override
	public int userUpdate(UserVo userVo) throws Exception {
		return sqlSession.update("user.userUpdate", userVo);
	}
	
	@Override
	public int userDelete(String userId, String userPw) throws Exception{
		return sqlSession.delete("user.userDelete");
	}
	
}
