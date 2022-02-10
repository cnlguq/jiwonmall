package com.jiwonmall.jiwon;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jiwonmall.jiwon.product.domain.GoodsAttachDTO;
import com.jiwonmall.jiwon.product.mapper.GoodsAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private GoodsAttachMapper attachMapper;
	
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron="0 0 0 * * *")
	public void checkFiles() throws Exception{
		log.warn("FIle check Task run....................");
		log.warn(new Date());
		// file list in database
		List<GoodsAttachDTO> goodsList = attachMapper.getOldFiles();
		log.info("상품리스트: " + goodsList);
		// ready for check file in directory with database file list
		List<Path> fileListPaths = goodsList.stream().map(vo -> Paths.get(
				"D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload",
				vo.getUploadpath(), vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
		// image file has thumnail file
		goodsList.stream().filter(vo -> vo.isFiletype() == true).map(vo -> Paths.get(
				"D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload",
				vo.getUploadpath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));
		
		log.warn("========================================");
		fileListPaths.forEach(p -> log.warn("db 파일리스트?: " + p));
		
		// files in yesterday directory
		File targetDir = Paths.get("D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload",
				getFolderYesterDay()).toFile();
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		log.warn("------------------------------------------");
		
		if (removeFiles != null) {
			for (File file : removeFiles) {
				log.warn(file.getAbsolutePath());
				file.delete();
			}
		}
	}
}
