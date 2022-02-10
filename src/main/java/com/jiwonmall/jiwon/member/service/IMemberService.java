package com.jiwonmall.jiwon.member.service;

import com.jiwonmall.jiwon.member.domain.MemberDTO;

public interface IMemberService {

	public void signup(MemberDTO mDto) throws Exception;
	public MemberDTO signin(String member_id) throws Exception;
	public boolean updateMember(MemberDTO mDto) throws Exception;
	public boolean dropMember(String member_id) throws Exception;
	
	public int idchk(String member_id) throws Exception;
	public void useynMember(String email) throws Exception;
}
