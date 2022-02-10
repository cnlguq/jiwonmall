package com.jiwonmall.jiwon.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jiwonmall.jiwon.member.domain.MemberDTO;
import com.jiwonmall.jiwon.member.persistence.IMemberDAO;
import com.jiwonmall.jiwon.member.service.IMemberService;
@Service
public class MemberServiceImpl implements IMemberService{

	@Autowired
	private IMemberDAO mDao;
	
	
	@Override
	public void signup(MemberDTO mDto) throws Exception {
		mDao.signup(mDto);
	}

	@Override
	public MemberDTO signin(String member_id) throws Exception {
		return mDao.signin(member_id);
	}

	@Override
	public boolean updateMember(MemberDTO mDto) throws Exception {
		return mDao.updateMember(mDto) == 1;
	}

	@Override
	public boolean dropMember(String member_id) throws Exception {
		return mDao.dropMember(member_id) == 1;
	}

	@Override
	public int idchk(String member_id) throws Exception {
		return mDao.idchk(member_id);
	}

	@Override
	public void useynMember(String email) throws Exception {
		mDao.useynMember(email);
		
	}

}
