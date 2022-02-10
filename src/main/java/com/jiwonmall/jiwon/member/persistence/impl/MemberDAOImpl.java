package com.jiwonmall.jiwon.member.persistence.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jiwonmall.jiwon.member.domain.MemberDTO;
import com.jiwonmall.jiwon.member.persistence.IMemberDAO;
@Repository
public class MemberDAOImpl implements IMemberDAO{

	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "MemberMapper";
	
	@Override
	public void signup(MemberDTO mDto) throws Exception {
		sqlSession.insert(namespace+".signup", mDto);
		
	}

	@Override
	public MemberDTO signin(String member_id) throws Exception {
		return sqlSession.selectOne(namespace+".signin", member_id);
	}

	@Override
	public int updateMember(MemberDTO mDto) throws Exception {
		return sqlSession.update(namespace+".updateMember", mDto);
	}

	@Override
	public int dropMember(String member_id) throws Exception {
		return sqlSession.delete(namespace+".dropMember", member_id);
	}

	@Override
	public int idchk(String member_id) throws Exception {
		String result = null;
		result = sqlSession.selectOne(namespace+".idchk", member_id);
		if (result != null) {
			result = "-1";
		} else {
			result = "1";
		}
		return Integer.parseInt(result);
	}

	@Override
	public void useynMember(String email) throws Exception {
		sqlSession.update(namespace+".useyn", email);
	}

}
