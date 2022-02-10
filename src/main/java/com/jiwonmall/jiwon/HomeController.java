package com.jiwonmall.jiwon;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jiwonmall.jiwon.product.domain.CartDTO;
import com.jiwonmall.jiwon.product.domain.GoodsAttachDTO;
import com.jiwonmall.jiwon.product.mapper.GoodsAttachMapper;
import com.jiwonmall.jiwon.product.service.IGoodsService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	@Autowired
	private IGoodsService gService;
	
	@Setter(onMethod_ = @Autowired)
	private GoodsAttachMapper attachMapper;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("hello world");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model, String q) throws Exception {
		Map<String, String> search = new HashedMap<>();
		search.put("q", q);
		List<GoodsAttachDTO> gList = attachMapper.goodsAll();
		for (GoodsAttachDTO gDto : gList) {
			String path = gDto.getUploadpath();
			gDto.setUploadpath(path.replaceAll("\\\\", "/"));
		}
		model.addAttribute("gDtosimg", gList);
		model.addAttribute("gDtos", gService.goodslist(search));
		model.addAttribute("rangeq", q);
		return "common/main";
	}
	
	@RequestMapping(value = "facebook", method = RequestMethod.GET)
	public void facebook () {
		
	}
	@RequestMapping(value = "detailpage", method = RequestMethod.GET)
	public void detailpage () {
		
	}
	
}
