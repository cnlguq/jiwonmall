package com.jiwonmall.jiwon.member.persistence;

import com.jiwonmall.jiwon.member.domain.MemberDTO;

public interface IMemberDAO {

	public void signup(MemberDTO mDto) throws Exception;
	public MemberDTO signin(String member_id) throws Exception;
	public int updateMember(MemberDTO mDto) throws Exception;
	public int dropMember(String member_id) throws Exception;
	
	public int idchk(String member_id) throws Exception;
	public void useynMember(String email) throws Exception;
}
