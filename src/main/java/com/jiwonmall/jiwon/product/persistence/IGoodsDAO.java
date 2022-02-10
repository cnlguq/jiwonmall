package com.jiwonmall.jiwon.product.persistence;

import java.util.List;
import java.util.Map;

import com.jiwonmall.jiwon.product.domain.GoodsDTO;

public interface IGoodsDAO {
	public int insertgoods(GoodsDTO gDto) throws Exception;
	public List<GoodsDTO> goodslist(Map<String, String> q) throws Exception;
	public GoodsDTO goodsone(int goods_num) throws Exception;
	public int delgoods(int goods_num) throws Exception;
	public int goodsmodify(GoodsDTO gDto) throws Exception;
	
	public Integer getnewgoodsnum() throws Exception;
	public List<GoodsDTO> membergoods(String member_id) throws Exception;
	public int excelupdategoods(GoodsDTO gDto) throws Exception;
	public int mainimgupdate(GoodsDTO gDto) throws Exception;
	
	public int excelinsert(GoodsDTO gDto) throws Exception;
	
	public List<GoodsDTO> rangeList(Map<String, Object> range) throws Exception;
}
