package com.jiwonmall.jiwon.board.mapper;

import java.util.List;
import java.util.Map;

import com.jiwonmall.jiwon.board.domain.NoticeDTO;

public interface NoticeMapper {
	
	public List<NoticeDTO> noticeview(Map<String, String> q) throws Exception;
	public List<NoticeDTO> faqview() throws Exception;
	public int createNotice(NoticeDTO nDto) throws Exception;
	public int createFAQ(NoticeDTO nDto) throws Exception;
	public Integer getNewnoticeNum() throws Exception;
	
	public int cntNotice() throws Exception;
	public int cntFAQ() throws Exception;
	
	public List<NoticeDTO> scrollnotice(Map<String, Object> q) throws Exception;
	public List<NoticeDTO> scrollfaq(int cntfaq) throws Exception;
	
	public Integer delete(NoticeDTO nDto) throws Exception;
	public Integer deletefaq(NoticeDTO nDto) throws Exception;
	
	public NoticeDTO read(Integer notice_num) throws Exception;
	
	public int update(NoticeDTO nDto) throws Exception;
}
