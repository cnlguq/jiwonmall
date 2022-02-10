package com.jiwonmall.jiwon.product.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GoodsAttachDTO {
	private String uuid;
	private String uploadpath;
	private String fileName;
	private boolean filetype;
	private int bno;
}
