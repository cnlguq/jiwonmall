package com.jiwonmall.jiwon.product;

import java.io.File;
import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.jiwonmall.jiwon.product.domain.CartDTO;
import com.jiwonmall.jiwon.product.domain.GoodsAttachDTO;
import com.jiwonmall.jiwon.product.domain.GoodsDTO;
import com.jiwonmall.jiwon.product.excel.ExcelUtil;
import com.jiwonmall.jiwon.product.excel.Excelimg;
import com.jiwonmall.jiwon.product.mapper.GoodsAttachMapper;
import com.jiwonmall.jiwon.product.service.IGoodsService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("product")
public class ProductController implements Serializable{

	private String uploadPath = "D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\fileUpload";
	
	@Autowired
	private IGoodsService gService;
	
	@Setter(onMethod_ = @Autowired)
	private GoodsAttachMapper attachMapper;
	
	@RequestMapping(value = "/insertproduct", method = RequestMethod.GET)
	public String insertproductGet() throws Exception {
		return "product/insertproduct";
	}
	
	@Transactional
	@RequestMapping(value = "/insertproduct", method = RequestMethod.POST)
	public String insertproductPost(GoodsDTO gDto, String goods_image0) throws Exception {
		
		log.info("상품 등록 내용" + gDto);

		if (gDto.getAttachList() != null) {
			String mainimg = goods_image0;
			gDto.setGoods_image(mainimg);
			gDto.getAttachList().forEach(attach -> log.info(attach));
		}
		gService.insertgoods(gDto);
		return "redirect:/main";
	}
	
	@GetMapping("/excel")
	public void excel(HttpServletRequest req, HttpServletResponse res, String member_id) {
		log.info("엑셀 다운로드");
		try {
			// 엑셀 다운로드 함수
			if (member_id == null) {
				member_id = "user";
			}
			List<GoodsDTO> listData = gService.membergoods(member_id);
			List<GoodsAttachDTO> listimg = attachMapper.membergoodsList(member_id);
			log.info("회원 상품등록 리스트: "+listData);
			log.info("회원 상품등록 이미지: "+listimg);
			ExcelUtil.excelDownload(res, listData, listimg, member_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@ResponseBody
	@RequestMapping(value = "/excelinsert", method = RequestMethod.POST)
	public ModelAndView excelUploadAjax(MultipartFile testFile, MultipartHttpServletRequest request, String member_id) throws  Exception{
		List<Map<String, String>> attach_goods;
		System.out.println("업로드 진행");
		MultipartFile excelFile = request.getFile("excelFile");
		
		if(excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}
		String fileName = excelFile.getOriginalFilename();
		File destFile = new File("D:\\sts-4-4.10.0.RELEASE\\Jiwonmall\\src\\main\\webapp\\resources\\excel\\"+excelFile.getOriginalFilename());
		try {
			//내가 설정한 위치에 내가 올린 파일을 만들고
			excelFile.transferTo(destFile);
		} catch(Exception e) {
			throw new RuntimeException(e.getMessage(),e);
		}
		//업로드를 진행하고 다시 지우기
		Excelimg excelimg = new Excelimg();
		attach_goods = excelimg.excelimg(fileName);
		
		gService.excelUpload(destFile, attach_goods, member_id);
		
		destFile.delete();
		ModelAndView view = new ModelAndView();
		view.setViewName("/product/insertproduct");
		view.addObject("", "");
		return view;
	}
	
	@RequestMapping(value = "/productdetail", method = RequestMethod.GET)
	public void productdetail(GoodsDTO gDto, Model model) throws Exception{
		log.info("상품정보" + gService.goodsone(gDto.getGoods_num()));
		List<GoodsAttachDTO> gList = attachMapper.findByBno(gDto.getGoods_num());
		log.info("상품이미지 정보: " + gList);
		for (GoodsAttachDTO gimg : gList) {
			String path = gimg.getUploadpath();
			gimg.setUploadpath(path.replaceAll("\\\\", "/"));
		}
		model.addAttribute("gDtos", gService.goodsone(gDto.getGoods_num()));
		model.addAttribute("gDtosimg", gList);
	}
	
	@ResponseBody
	@RequestMapping(value = "/range", method = RequestMethod.POST)
	public Map<String, Object> range(String range1, String range2, Model model, String rangeq) throws Exception{
		Map<String, Object> range = new HashedMap<>();
		range.put("range1", Integer.parseInt(range1));
		range.put("range2", Integer.parseInt(range2));
		range.put("rangeq", rangeq);
		Map<String, Object> rangelist = new HashedMap<>();
		List<GoodsDTO> rnlist = new ArrayList<GoodsDTO>();
		rnlist = gService.rangeList(range);
		log.info("range Map: " + range);
		for (GoodsDTO goodsDTO : rnlist) {
			if ("".equals(goodsDTO.getGoods_image()) || goodsDTO.getGoods_image() == null) {
				goodsDTO.setUuid("default");
				goodsDTO.setFileName("default.jpg");
				goodsDTO.setUploadpath("default");
			}
		}
		Set<GoodsDTO> setlist = new HashSet<GoodsDTO>(rnlist);
		List<GoodsDTO> newrnlist = new ArrayList<GoodsDTO>(setlist);
		for (GoodsDTO goodsDTO : newrnlist) {
			DecimalFormat df = new DecimalFormat("###,###");
			String path = goodsDTO.getUploadpath();
			String cost = df.format(goodsDTO.getGoods_cost());
			goodsDTO.setUploadpath(path.replaceAll("\\\\", "/"));
			goodsDTO.setCostformat(cost);
			log.info("setlist ===>" + goodsDTO);
		}
		
		rangelist.put("rangeList", newrnlist);
		rangelist.put("rangeq", rangeq);
		return rangelist;
	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public void cartGET() throws Exception{
		
	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.POST)
	public String cart(CartDTO cDto, HttpSession session, Model model) throws Exception{
		log.info("cDto:  " + cDto.getGoods_num());
		List<CartDTO> cart = new ArrayList<CartDTO>();
		List<GoodsDTO> cartgoods = new ArrayList<GoodsDTO>();
		List<GoodsAttachDTO> gList = new ArrayList<GoodsAttachDTO>();
		if (cDto.getGoods_num() != null) {
			List<CartDTO> basket = (ArrayList)session.getAttribute("cart");
			if (basket == null) {
				basket = new ArrayList<CartDTO>();
				session.setAttribute("cart", basket);
			}
			basket.add(cDto);
		}
		
		if (session != null) {
			cart = (ArrayList)session.getAttribute("cart");
		}
		
		if (cart != null) {
			for (CartDTO cartDTO : cart) {
				log.info("상품번호:===> " + cartDTO.getGoods_num());
				log.info("회원정보:===> " + cartDTO.getMember_id());
				GoodsDTO gDto = gService.goodsone(cartDTO.getGoods_num());
				gList = attachMapper.findByBno(cartDTO.getGoods_num());
				for (GoodsAttachDTO gAttachDTO : gList) {
					String path = gAttachDTO.getUploadpath();
					gDto.setUploadpath(path.replaceAll("\\\\", "/"));
				}
				
				gDto.setAttachList(gList);
				cartgoods.add(gDto);
			}
		}
		log.info("세션 값: " + session.getAttribute("cart"));
		for (GoodsDTO goodsDTO : cartgoods) {
			log.info("장바구니 총 정보:==>" + goodsDTO);
		}
		
		model.addAttribute("cart", cartgoods);
		return "/product/cart";
	}
	
	@RequestMapping(value = "/maincart", method = RequestMethod.POST)
	public String maincart(CartDTO cDto, HttpSession session) throws Exception{
		
		if (cDto.getGoods_num() != null) {
			List<CartDTO> basket = (ArrayList)session.getAttribute("cart");
			if (basket == null) {
				basket = new ArrayList<CartDTO>();
				session.setAttribute("cart", basket);
			}
			basket.add(cDto);
		}
		log.info("세션 값: " + session.getAttribute("cart"));
		
		return "redirect:/main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/deletecart", method = RequestMethod.POST)
	public void deletecart(String goods_num, HttpSession session) throws Exception{
		log.info("삭제할 상품 번호: " + goods_num);
		log.info("현재 세션 정보: " + session.getAttribute("cart"));
		List<CartDTO> cartsession = (ArrayList)session.getAttribute("cart");
		Iterator<CartDTO> it = cartsession.iterator();
		while (it.hasNext()) {
			CartDTO cartDTO = (CartDTO) it.next();
			if (cartDTO.getGoods_num() == Integer.parseInt(goods_num)) {
				it.remove();
			}
			
		}
		session.setAttribute("cart", cartsession);
		log.info("삭제한 List: " + cartsession);
		log.info("삭제하고 남은 세션 담기" + session.getAttribute("cart"));
	}

}
