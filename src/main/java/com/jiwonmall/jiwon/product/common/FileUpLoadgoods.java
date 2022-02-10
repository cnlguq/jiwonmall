package com.jiwonmall.jiwon.product.common;

import java.io.File;
import java.rmi.ServerException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.IIOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUpLoadgoods {
	public static Map<String, String> upload(HttpServletRequest request, HttpServletResponse response) 
			throws ServerException, IIOException{
		String savePath = "D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload\\goods";
		Map<String, String> goodsMap = new HashMap<String, String>();
		String encoding = "UTF-8";
		File currentDirPath = new File(savePath);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(10 * 1024 * 1024);
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem)items.get(i);
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "= " + fileItem.getString(encoding));
					goodsMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						String fileName = fileItem.getName().substring(idx + 1);
						goodsMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);
					}
				}
			}
			goodsMap.put("savePath", savePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return goodsMap;
	}
}
