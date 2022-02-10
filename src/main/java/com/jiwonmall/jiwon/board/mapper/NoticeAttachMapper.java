package com.jiwonmall.jiwon.board.mapper;

import java.util.List;
import java.util.Map;

import com.jiwonmall.jiwon.board.domain.NoticeAttachDTO;

public interface NoticeAttachMapper {
	public void insert(NoticeAttachDTO attachDTO);
	public void delete(String uuid);
	public void deleteAll(int bno);
	
	public List<NoticeAttachDTO> getOldFiles();
	public List<NoticeAttachDTO> goodsAll();
	
	public List<NoticeAttachDTO> noticeList();
	public List<NoticeAttachDTO> faqList();
	
	public List<NoticeAttachDTO> noticeattachscroll(Map<String, Object> q);
	public List<NoticeAttachDTO> faqattachscroll(int cnt);
	
	public void excelupdateimg(NoticeAttachDTO attachDTO);
	
	public Integer deleteN(int bno) throws Exception;
	public Integer deleteF(int bno) throws Exception;
	
	public List<NoticeAttachDTO> findByBno (int bno) throws Exception;
}
