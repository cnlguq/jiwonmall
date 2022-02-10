package com.jiwonmall.jiwon.product.mapper;

import java.util.List;

import com.jiwonmall.jiwon.product.domain.CartDTO;

public interface CartMapper {
	public void deleteCart(String member_id) throws Exception;
	public void insertCart(CartDTO cDto) throws Exception;
	public List<CartDTO> userCart(String member_id) throws Exception;
}
