package com.jiwonmall.jiwon.product.persistence.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jiwonmall.jiwon.product.domain.GoodsDTO;
import com.jiwonmall.jiwon.product.persistence.IGoodsDAO;

@Repository
public class GoodsDAOImpl implements IGoodsDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "GoodsMapper";

	@Override
	public int insertgoods(GoodsDTO gDto) throws Exception {
		return sqlSession.insert(namespace+".insertgoods", gDto);
	}

	@Override
	public List<GoodsDTO> goodslist(Map<String, String> q) throws Exception {
		return sqlSession.selectList(namespace+".goodslist", q);
	}

	@Override
	public GoodsDTO goodsone(int goods_num) throws Exception {
		return sqlSession.selectOne(namespace+".goodsone", goods_num);
	}

	@Override
	public int delgoods(int goods_num) throws Exception {
		return sqlSession.delete(namespace+".delgoods", goods_num);
	}

	@Override
	public int goodsmodify(GoodsDTO gDto) throws Exception {
		return sqlSession.update(namespace+".updategoods", gDto);
	}

	@Override
	public Integer getnewgoodsnum() throws Exception {
		return sqlSession.selectOne(namespace+".getnew_goods_num");
	}

	@Override
	public List<GoodsDTO> membergoods(String member_id) throws Exception {
		return sqlSession.selectList(namespace+".membergoods", member_id);
	}

	@Override
	public int excelupdategoods(GoodsDTO gDto) throws Exception {
		return sqlSession.update(namespace+".excelupdategoods", gDto);
	}

	@Override
	public int mainimgupdate(GoodsDTO gDto) throws Exception {
		return sqlSession.update(namespace+".mainimgupdate", gDto);
	}

	@Override
	public int excelinsert(GoodsDTO gDto) throws Exception {
		
		return sqlSession.insert(namespace+".excelinsert", gDto);
	}

	@Override
	public List<GoodsDTO> rangeList(Map<String, Object> range) throws Exception {
		return sqlSession.selectList(namespace+".rangeList", range);
	}


}
