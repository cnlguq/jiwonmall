package com.jiwonmall.jiwon.product.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiwonmall.jiwon.product.domain.GoodsAttachDTO;
import com.jiwonmall.jiwon.product.domain.GoodsDTO;
import com.jiwonmall.jiwon.product.excel.ExcelFileType;
import com.jiwonmall.jiwon.product.excel.ExcelRead;
import com.jiwonmall.jiwon.product.excel.ExcelReadOption;
import com.jiwonmall.jiwon.product.mapper.GoodsAttachMapper;
import com.jiwonmall.jiwon.product.persistence.IGoodsDAO;
import com.jiwonmall.jiwon.product.service.IGoodsService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class GoodsServiceImpl implements IGoodsService{
	
	@Autowired
	private IGoodsDAO gDao;

	@Setter(onMethod_ = @Autowired)
	private GoodsAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void insertgoods(GoodsDTO gDto) throws Exception {
		gDao.insertgoods(gDto);
		if (gDto.getAttachList() == null || gDto.getAttachList().size() <= 0) {
			return;
		}
		gDto.getAttachList().forEach(attach -> {
			attach.setBno(gDto.getGoods_num());
			attachMapper.insert(attach);
		});
	}

	@Override
	public List<GoodsDTO> goodslist(Map<String, String> q) throws Exception {
		return gDao.goodslist(q);
	}

	@Override
	public GoodsDTO goodsone(int goods_num) throws Exception {
		return gDao.goodsone(goods_num);
	}

	@Override
	public boolean delgoods(int goods_num) throws Exception {
		return gDao.delgoods(goods_num) == 1;
	}

	@Override
	public boolean goodsmodify(GoodsDTO gDto) throws Exception {
		return gDao.goodsmodify(gDto) == 1;
	}

	@Override
	public Integer getnewgoodsnum() throws Exception {
		return gDao.getnewgoodsnum();
	}

	@Override
	public List<GoodsDTO> membergoods(String member_id) throws Exception {
		return gDao.membergoods(member_id);
	}

	@Transactional
	@Override
	public void excelUpload(File destFile, List<Map<String, String>> attach_goods, String member_id) throws Exception {
		ExcelReadOption excelReadOption = new ExcelReadOption();
		log.info(member_id);
		//???????????? ??????
		excelReadOption.setFilePath(destFile.getAbsolutePath());
	        
		//????????? ????????? ??????
		excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q");
		
		//?????????
		excelReadOption.setStartRow(2);
		
		List<Map<String, String>> excelContent  = ExcelRead.read(excelReadOption);
		Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
		Map<String, String> search = new HashedMap<String, String>();
		String q = "";
		search.put("q", q);
		List<GoodsDTO> glist = gDao.goodslist(search);
		
		for (Map<String, String> excelimg : attach_goods) {
			log.info("excel ?????????: " + excelimg);
		}
		
		for (Map<String, String> map : excelContent) {
			log.info("excel ?????????: " + map);
		}
		
		for (GoodsDTO goodsDTO : glist) {
			log.info("DB?????????: " + goodsDTO);
		}
		
		//?????? ?????? ????????? ??????????????? ??????
		for (Map<String, String> map : excelContent) {
			for (GoodsDTO goodsDTO : glist) {
				if (!("".equals(map.get("B")))) {
					if (Integer.parseInt(map.get("B")) == goodsDTO.getGoods_num()) {
				    	GoodsDTO gDto = new GoodsDTO();
				    	log.info("?????? ?????? ??? ???????????? ????????????");
						log.info("excel ????????????: "+ map.get("B") + "= db ????????????: " + goodsDTO.getGoods_num());
						gDto.setGoods_name(map.get("C"));
						gDto.setGoods_contents(map.get("D"));
						gDto.setGoods_company(map.get("F"));
						gDto.setGoods_origin(map.get("G"));
						gDto.setGoods_cost(Integer.parseInt(map.get("H")));
						gDto.setMember_id(member_id);
						gDto.setGoods_num(Integer.parseInt(map.get("B")));
						log.info("????????? gDto: " + gDto);
						int i = 0;
						for (Map<String, String> excelimg : attach_goods) {
							if (excelimg.get("row").equals(map.get("A"))) {
								if (i == 0) {
									attachMapper.deleteAll(Integer.parseInt(map.get("B")));
								}
						    	GoodsAttachDTO attachDTO = new GoodsAttachDTO();
								log.info("?????? ?????????: " + excelimg.get("row") + "= ?????? ?????????: " + map.get("A"));
								attachDTO.setBno(Integer.parseInt(map.get("B")));
								attachDTO.setUuid(excelimg.get("uuid"));
								attachDTO.setUploadpath(excelimg.get("uploadpath"));
								attachDTO.setFileName(excelimg.get("fileName"));
								attachDTO.setFiletype(true);
								log.info("?????? ?????????: " + attachDTO);
//								attachMapper.excelupdateimg(attachDTO);
								attachMapper.insert(attachDTO);
								if (excelimg.get("col").equals("12")) {
							    	GoodsDTO gDtoimg = new GoodsDTO();
									gDtoimg.setGoods_image(excelimg.get("fileName"));
									gDtoimg.setMember_id(member_id);
									gDtoimg.setGoods_num(Integer.parseInt(map.get("B")));
									gDao.mainimgupdate(gDtoimg);
								}
								i++;
							}
						}
						gDao.excelupdategoods(gDto);
					}
				}
			}
		}
		
		for (Map<String, String> map : excelContent) {
			if ("".equals(map.get("B"))) {
				if (!("".equals(map.get("A"))) && !("".equals(map.get("C"))) && !("".equals(map.get("D"))) && !("".equals(map.get("F"))) && !("".equals(map.get("G"))) && !("".equals(map.get("H"))) && !("".equals(map.get("J")))) {
					log.info("???????????? ?????? ???");
					log.info(map);
					GoodsDTO gDto = new GoodsDTO();
					List<GoodsAttachDTO> attachDTOimg = new ArrayList<GoodsAttachDTO>();
					gDto.setGoods_name(map.get("C"));
					gDto.setGoods_contents(map.get("D"));
					gDto.setGoods_company(map.get("F"));
					gDto.setGoods_origin(map.get("G"));
					gDto.setGoods_cost(Integer.parseInt(map.get("H")));
					gDto.setGoods_kind(Integer.parseInt(map.get("J")));
					gDto.setMember_id(member_id);
					log.info("?????? ??????: " + gDto);
					gDao.excelinsert(gDto);
					for (Map<String, String> excelimg : attach_goods) {
						if (excelimg.get("row").equals(map.get("A"))) {
							log.info("?????? ?????????: " + excelimg.get("row") + "= ?????? ?????????: " + map.get("A"));
							GoodsAttachDTO attachDTO = new GoodsAttachDTO();
							attachDTO.setUuid(excelimg.get("uuid"));
							attachDTO.setUploadpath(excelimg.get("uploadpath"));
							attachDTO.setFileName(excelimg.get("fileName"));
							attachDTO.setFiletype(true);
							attachDTO.setBno(gDto.getGoods_num());
							log.info("?????? ?????? ?????? ?????????: " + attachDTO);
							attachMapper.insert(attachDTO);
							if (excelimg.get("col").equals("12")) {
								GoodsDTO gDtoimg = new GoodsDTO();
								gDtoimg.setGoods_image(excelimg.get("fileName"));
								gDtoimg.setMember_id(member_id);
								gDtoimg.setGoods_num(gDto.getGoods_num());
								log.info("??????????????? ??????: " + gDtoimg);
								gDao.mainimgupdate(gDtoimg);
							}
						}
					}
				}
			}
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("excelContent", excelContent);
//		try {
//		    sampleDAO.insertExcel(paramMap);
//		}catch(Exception e) {
//		    e.printStackTrace();
//		}
	}

	@Override
	public List<GoodsDTO> rangeList(Map<String, Object> range) throws Exception {
		return gDao.rangeList(range);
	}

}
