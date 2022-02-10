package com.jiwonmall.jiwon.product.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.jiwonmall.jiwon.product.domain.GoodsDTO;

public interface IGoodsService {

	public void insertgoods(GoodsDTO gDto) throws Exception;
	public List<GoodsDTO> goodslist(Map<String, String> q) throws Exception;
	public GoodsDTO goodsone(int goods_num) throws Exception;
	public boolean delgoods(int goods_num) throws Exception;
	public boolean goodsmodify(GoodsDTO gDto) throws Exception;
	
	public Integer getnewgoodsnum() throws Exception;
	public List<GoodsDTO> membergoods(String member_id) throws Exception;
	
	public void excelUpload(File destFile, List<Map<String, String>> attach_goods, String member_id) throws Exception;
	
	public List<GoodsDTO> rangeList(Map<String, Object> range) throws Exception;
}
