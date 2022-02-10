package com.jiwonmall.jiwon.board.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeAttachDTO {
	private String uuid;
	private String uploadpath;
	private String fileName;
	private boolean filetype;
	private int bno;
}
