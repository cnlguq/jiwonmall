package com.jiwonmall.jiwon.board.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeDTO {
	private Integer notice_num;
	private String member_id;
	private String notice_title;
	private String notice_contents;
	private Date notice_date;
	private String filename;
	private int sort;
	
	//날짜 포맷 담기위해
	private String date;
	
	private List<NoticeAttachDTO> attachList;
}
