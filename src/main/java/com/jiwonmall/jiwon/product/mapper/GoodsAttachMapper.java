package com.jiwonmall.jiwon.product.mapper;

import java.util.List;

import com.jiwonmall.jiwon.product.domain.GoodsAttachDTO;

public interface GoodsAttachMapper {

	public void insert(GoodsAttachDTO goodsAttachDTO);
	public void delete(String uuid);
	public List<GoodsAttachDTO> findByBno(int bno);
	public void deleteAll(int bno);
	
	public List<GoodsAttachDTO> getOldFiles();
	public List<GoodsAttachDTO> goodsAll();
	
	public List<GoodsAttachDTO> membergoodsList(String member_id);
	
	public void excelupdateimg(GoodsAttachDTO goodsAttachDTO);
}
