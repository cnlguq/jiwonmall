package com.jiwonmall.jiwon.product.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GoodsDTO {

	private int goods_num;
	private String goods_name;
	private String goods_contents;
	private String goods_image;
	private Date goods_date;
	private String goods_company;
	private String goods_origin;
	private int goods_cost;
	private String goods_useyn;
	private int goods_kind;
	private String member_id;
	
	private List<GoodsAttachDTO> attachList;
	
	private String costformat;
	
	private String uuid;
	private String uploadpath;
	private String fileName;
}
