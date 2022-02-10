package com.jiwonmall.jiwon.member.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	private String member_id;
	private String member_pwd;
	private String member_name;
	private String member_address;
	private String member_tel;
	private String member_useyn;
	private Date member_date;
	private String member_zip_num;
	private int member_rank;
	private String member_event;
}
