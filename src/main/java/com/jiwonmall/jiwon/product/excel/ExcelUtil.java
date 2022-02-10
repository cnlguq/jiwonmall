package com.jiwonmall.jiwon.product.excel;

import java.io.FileInputStream;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFCreationHelper;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFPicture;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.jiwonmall.jiwon.domain.AttachFileDTO;
import com.jiwonmall.jiwon.product.domain.GoodsAttachDTO;
import com.jiwonmall.jiwon.product.domain.GoodsDTO;

import lombok.extern.log4j.Log4j;
@Log4j
public class ExcelUtil {
	
	//엑셀로 다운로드
	public static void excelDownload(HttpServletResponse res, List<GoodsDTO> listData, List<GoodsAttachDTO> listimg, String member_id) throws Exception {
		
		final String fileName;
		if(listData != null && listData.size() > 0) {
			fileName = "goodsList.xlsx";
		} else {
			fileName = "goodsform.xlsx";
		}
			/* 엑셀 헤더 이름 */
			final String[] colNames = {
				"No" , "상품번호", "상품이름", "상품내용", "등록날짜",
				"제조사", "원산지", "상품가격", "판매여부", "카테고리", "판매자", "대표이미지", "이미지", "이미지", "이미지", "이미지", "이미지"
			};
			
			// 헤더 사이즈 설정
			final int[] colWidths = {
				2000, 2000, 5000, 5000, 3000, 2000, 3000, 5000, 3000, 3000, 5000, 5000, 5000, 5000, 5000, 5000, 5000
			};
			
			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = null;
			XSSFCell cell = null;
			XSSFRow row = null;
			
			
			//Font
			Font fontHeader = workbook.createFont();
			fontHeader.setFontName("맑은 고딕");	//글씨체
			fontHeader.setFontHeight((short)(9 * 20));	//사이즈
			fontHeader.setBoldweight(Font.BOLDWEIGHT_BOLD);	//볼드(굵게)
			Font font9 = workbook.createFont();
			font9.setFontName("맑은 고딕");	//글씨체
			font9.setFontHeight((short)(9 * 20));	//사이즈
			// 엑셀 헤더 셋팅
			CellStyle headerStyle = workbook.createCellStyle();
			headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
			headerStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			headerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			headerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			headerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			headerStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
			headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			headerStyle.setFont(fontHeader);
			// 엑셀 바디 셋팅
			CellStyle bodyStyle = workbook.createCellStyle();
			bodyStyle.setAlignment(CellStyle.ALIGN_CENTER);
			bodyStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			bodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			bodyStyle.setFont(font9);
			// 엑셀 왼쪽 설정
			CellStyle leftStyle = workbook.createCellStyle();
			leftStyle.setAlignment(CellStyle.ALIGN_LEFT);
			leftStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			leftStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			leftStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			leftStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			leftStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			leftStyle.setFont(font9);
			
			//rows
			//데이터 삽입 시작 행 설정 숫자만큼 비움
			int rowCnt = 0;
			int cellCnt = 0;
//			int listCount = listData.size();
			int listCount = 2;
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
			
			// 엑셀 시트명 설정
			sheet = workbook.createSheet(member_id+"님 등록상품");
			row = sheet.createRow(rowCnt++);
			//헤더 정보 구성
			for (int i = 0; i < colNames.length; i++) {
				cell = row.createCell(i);
				cell.setCellStyle(headerStyle);
				cell.setCellValue(colNames[i]);
				sheet.setColumnWidth(i, colWidths[i]);	//column width 지정
			}
			
			
			//데이터 부분 생성
			for(GoodsDTO gDto : listData) {
				
				//데이터 삽입 시작 열 설정 숫자만큼 비움
				cellCnt = 0;
				int rowimg = rowCnt;
				row = sheet.createRow(rowCnt++);
//				// 넘버링
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(listCount++);
				// 상품번호
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_num());
				// 상품명
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_name());
				
				// 상품내용
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_contents());
				
//				// 상품이미지
//				cell = row.createCell(cellCnt++);
//				cell.setCellStyle(bodyStyle);
//				cell.setCellValue(gDto.getGoods_image());
				
				// 등록날짜
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dateFormat.format(gDto.getGoods_date()));
				
				// 제조사
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_company());
				
				// 원산지
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_origin());
				
				// 상품가격
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_cost());
				
				// 판매여부
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_useyn());
				
				// 카테고리
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getGoods_kind());
				
				// 판매자
				cell = row.createCell(cellCnt++);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(gDto.getMember_id());
				
				
//				for (GoodsAttachDTO gAttachDTO : listimg) {
//					if (gAttachDTO.getBno() == gDto.getGoods_num()) {
//						if (gAttachDTO.getFileName() == gDto.getGoods_image()) {
//								cell = row.createCell(cellCnt);
//								try {
//									// 이미지 파일 로드
//									row.setHeightInPoints(100);
//									InputStream inputStream = new FileInputStream("D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload\\"+gAttachDTO.getUploadpath()+"\\"+gAttachDTO.getUuid()+"_"+gAttachDTO.getFileName());
//									byte[] bytes = IOUtils.toByteArray(inputStream);
//									int pictureIdx = workbook.addPicture(bytes, XSSFWorkbook.PICTURE_TYPE_JPEG);
//									inputStream.close();
//									
//									XSSFCreationHelper helper = workbook.getCreationHelper();
//									XSSFDrawing drawing = sheet.createDrawingPatriarch();
//									XSSFClientAnchor anchor = helper.createClientAnchor();
//									// 이미지를 출력할 CELL 위치 선정
//									anchor.setCol1(cellCnt);
//									sheet.setColumnWidth(cellCnt, 35*256);
//									anchor.setRow1(rowimg);
//									anchor.setCol2(cellCnt);
//									anchor.setRow2(rowimg);
//									// 이미지 그리기
//									XSSFPicture pict = drawing.createPicture(anchor, pictureIdx);
//									++cellCnt;
//									// 이미지 사이즈 비율 설정
//									pict.resize(1, 1);
//								} catch (Exception e) {
//									e.printStackTrace();
//								}
//							}
//						}
//				}
				
				// 대표이미지
				cell = row.createCell(cellCnt++);
				
				for (GoodsAttachDTO gAttachDTO : listimg) {
						if (gAttachDTO.getBno() == gDto.getGoods_num()) {
							if (gAttachDTO.getFileName() != gDto.getGoods_image()) {
								cell = row.createCell(cellCnt);
								try {
									// 이미지 파일 로드
									row.setHeightInPoints(100);
									InputStream inputStream = new FileInputStream("D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload\\"+gAttachDTO.getUploadpath()+"\\"+gAttachDTO.getUuid()+"_"+gAttachDTO.getFileName());
									byte[] bytes = IOUtils.toByteArray(inputStream);
									int pictureIdx = workbook.addPicture(bytes, XSSFWorkbook.PICTURE_TYPE_JPEG);
									inputStream.close();
									
									XSSFCreationHelper helper = workbook.getCreationHelper();
									XSSFDrawing drawing = sheet.createDrawingPatriarch();
									XSSFClientAnchor anchor = helper.createClientAnchor();
									// 이미지를 출력할 CELL 위치 선정
									anchor.setCol1(cellCnt);
									sheet.setColumnWidth(cellCnt, 35*256);
									anchor.setRow1(rowimg);
									anchor.setCol2(cellCnt);
									anchor.setRow2(rowimg);
									// 이미지 그리기
									XSSFPicture pict = drawing.createPicture(anchor, pictureIdx);
									cellCnt++;
									// 이미지 사이즈 비율 설정
									pict.resize(1, 1);
								} catch (Exception e) {
									e.printStackTrace();
								}
								
							}
						}
				}
			}
			
			res.setContentType("application/vnd.ms-excel");
			// 엑셀 파일명 설정
			res.setHeader("Content-Disposition", "attachment;filename=" + fileName);
			try {
				workbook.write(res.getOutputStream());
			} catch(IOException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}

	}
	
	/**
	 * 엑셀파일을 읽어서 Workbook 객체를 리턴한다.
	 * XLS와 XLSX 확장자를 비교한다.
	 * @param filePath
	 * @return
	 */
	public static Workbook getWorkbook(String filePath) {

		/*
         * FileInputStream은 파일의 경로에 있는 파일을
         * 읽어서 Byte로 가져온다.
         *
         * 파일이 존재하지 않는다면은
         * RuntimeException이 발생된다.
         */
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
		}catch(FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		Workbook workbook = null;

		/*
         * 파일의 확장자를 체크해서 .XLS 라면 HSSFWorkbook에
         * .XLSX라면 XSSFWorkbook에 각각 초기화 한다.
         */
		if(filePath.toUpperCase().endsWith(".XLS")) {
			try {
				workbook = new HSSFWorkbook(fis);
			}catch (IOException  e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}else if(filePath.toUpperCase().endsWith(".XLSX")) {
			try {
				workbook = new XSSFWorkbook(fis);
			}catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}

		return workbook;
	}

	/**
     * Cell에 해당하는 Column Name을 가젼온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }

        return CellReference.convertNumToColString(cellNum);
    }


    public static String getValue(Cell cell) {
        String value = "";

		if(cell == null) {
		    value = "";
		}else {
			switch(cell.getCellType()) {
				case Cell.CELL_TYPE_FORMULA :
					value = cell.getCellFormula();
					break;
				case Cell.CELL_TYPE_NUMERIC :
					value = (int)cell.getNumericCellValue() + "";	//(int)형변환 미변환시 소수점 발생가능
					break;
				case Cell.CELL_TYPE_STRING :
					value = cell.getStringCellValue();
					break;
				case Cell.CELL_TYPE_BOOLEAN :
					value = cell.getBooleanCellValue() + "";
					break;
				case Cell.CELL_TYPE_ERROR :
					value = cell.getErrorCellValue() + "";
					break;
				case Cell.CELL_TYPE_BLANK :
					value = "";
					break;
				default :
					value = cell.getStringCellValue();
			}

		}
		return value;
    }
    
    /**
     * 엑셀파일 내용 읽어오기
     * Service에서 이 함수 호출
     * @param excelReadOption
     * @return
     */
    public static List<Map<String, String>> excelRead(ExcelReadOption excelReadOption) {
    	//엑셀 파일 자체
    	//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
    	
//    	Workbook wb = getWorkbook(excelReadOption.getFilePath());
    	Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
    	/**
    	 * 엑셀 파일에서 첫번째 시트를 가지고 온다.
    	 */
    	Sheet sheet = wb.getSheetAt(0);

//    	System.out.println("Sheet 이름: "+ wb.getSheetName(0));
//    	System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
    	/**
    	 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
    	 */
    	int numOfRows = sheet.getPhysicalNumberOfRows();
    	int numOfCells = 0;

    	Row row = null;
    	Cell cell = null;

    	String cellName = "";
    	/**
    	 * 각 row마다의 값을 저장할 맵 객체
    	 * 저장되는 형식은 다음과 같다.
    	 * put("A", "이름");
    	 * put("B", "게임명");
    	 */
    	Map<String, String> map = null;
    	/*
    	 * 각 Row를 리스트에 담는다.
    	 * 하나의 Row를 하나의 Map으로 표현되며
    	 * List에는 모든 Row가 포함될 것이다.
    	 */
    	List<Map<String, String>> result = new ArrayList<Map<String, String>>();
    	/**
    	 * 각 Row만큼 반복을 한다.
    	 */
    	for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
    		/*
    		 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
    		 * 하나의 Row는 여러개의 Cell을 가진다.
    		 */
			row = sheet.getRow(rowIndex);

			if(row != null) {
				//가져온 Row의 Cell의 개수를 구한다.
				//한개의 행마다 몇개의 cell이 있는지 리턴
				//numOfCells = row.getPhysicalNumberOfCells();

				//마지막 셀의 숫자 리턴
//				numOfCells = row.getLastCellNum();
				numOfCells = row.getPhysicalNumberOfCells();

				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				/*
				 * cell의 수 만큼 반복한다.
				 */
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					/*
					 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
					 */
					cell = row.getCell(cellIndex);
					/*
					 * 현재 Cell의 이름을 가져온다
					 * 이름의 예 : A,B,C,D,......
					 */
//					cellName = getName(cell, cellIndex);
					cellName = ExcelCellRef.getName(cell, cellIndex);
					/*
					 * 추출 대상 컬럼인지 확인한다
					 * 추출 대상 컬럼이 아니라면,
					 * for로 다시 올라간다
					 */
					if( !excelReadOption.getOutputColumns().contains(cellName) ) {
						continue;
					}
					/*
					 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
					 */
//					map.put(cellName, getValue(cell));
					map.put(cellName, ExcelCellRef.getValue(cell));
				}
				//행번호 추가
//				map.put("rowNum", String.valueOf(rowIndex+1));
				/*
				 * 만들어진 Map객체를 List로 넣는다.
				 */
				result.add(map);
			}
    	}
    	return result;
    }
    
}
