package com.jiwonmall.jiwon.product.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO implements Serializable{
	private Integer cart_num;
	private String member_id;
	private Integer goods_num;
	private Integer cart_cnt;
	private Date cart_date;
}
