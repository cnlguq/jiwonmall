package com.jiwonmall.jiwon.product.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFPicture;
import org.apache.poi.xssf.usermodel.XSSFPictureData;
import org.apache.poi.xssf.usermodel.XSSFShape;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.jiwonmall.jiwon.UploadController;

import lombok.extern.log4j.Log4j;
@Log4j
public class Excelimg {
	
	//이미지 업로드 할 경로
	private String uploadPath = "D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload";
	
	public List<Map<String, String>> excelimg(String fileName) throws Exception {

		List<Map<String, String>> attachimg = new ArrayList<>();
		String tarDir = "D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\excel\\";
		//엑셀파일 경로
		File xlsFile = new File(tarDir+fileName);
		Workbook workbook = null;
		
		UploadController uploadController = new UploadController();
		File uploadFolder = new File(uploadPath, uploadController.getFolder());
		log.info("업로드 패스 경로"+uploadFolder);
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdir();
		}

		String path = uploadFolder.toString()+"\\";
		
		try {
			if (xlsFile.exists()) {
				FileInputStream inputStream = new FileInputStream(xlsFile);
				workbook = new XSSFWorkbook(inputStream);
				XSSFSheet sheet =  (XSSFSheet) workbook.getSheetAt(0);
				XSSFDrawing drawing = sheet.getDrawingPatriarch();
				for (XSSFShape shape : drawing.getShapes()) {
					Map<String, String> attach = new HashMap<>();
					if (shape instanceof XSSFPicture) {
						XSSFPicture picture = (XSSFPicture) shape;
						if (picture.getPictureData() == null) {
							log.info("사진 Path 사용");
							continue;
						}
						XSSFPictureData xssfPictureData = picture.getPictureData();
						ClientAnchor anchor = picture.getPreferredSize();
						int row1 = anchor.getRow1();
						int row2 = anchor.getRow2();
						int col1 = anchor.getCol1();
						int col2 = anchor.getCol2();
						row1++; col1++;
//						log.info("Row1: " + row1 + ", Row2: " + row2);
//						log.info("Column1: " + col1 + "Column2: " + col2);
						String ext = xssfPictureData.suggestFileExtension();
						byte[] data = xssfPictureData.getData();
						
						String sheetname = sheet.getSheetName();
						UUID uuid = UUID.randomUUID();
						sheetname = uuid.toString() + "_" + sheetname;
						
						FileOutputStream out = new FileOutputStream(String.format("%s\\%s_%d_%d.%s", path, sheetname, row1, col1, ext));
						out.write(data);
						out.close();
						
						String uploadpath = uploadController.getFolder();
						String fileNameimg = Integer.toString(row1)+"_"+Integer.toString(col1)+"."+ext;
						log.info("attach에 들어갈 정보: "+"uuid: "+ sheetname + ", uploadpath: " + uploadpath + ", fileName: " + fileNameimg + ", row: " + row1 + ", col1: " + col1);
						attach.put("uuid", sheetname);
						attach.put("uploadpath", uploadpath);
						attach.put("fileName", fileNameimg);
						attach.put("row", Integer.toString(row1));
						attach.put("col", Integer.toString(col1));
						attachimg.add(attach);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (workbook !=null) {
				workbook.close();
			}
		}
		
		return attachimg;
		
	}
}
