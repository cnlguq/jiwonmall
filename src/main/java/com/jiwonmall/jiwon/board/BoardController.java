package com.jiwonmall.jiwon.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jiwonmall.jiwon.board.domain.NoticeAttachDTO;
import com.jiwonmall.jiwon.board.domain.NoticeDTO;
import com.jiwonmall.jiwon.board.mapper.NoticeAttachMapper;
import com.jiwonmall.jiwon.board.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {
	
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper noticeMapper;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeAttachMapper attachMapper;

	@RequestMapping(value = "/service", method = RequestMethod.GET)
	public void service(Model model, String member_id, String tab, String q) throws Exception {
		Map<String, String> search = new HashedMap<>();
		search.put("q", q);
		List<NoticeDTO> noticeview = noticeMapper.noticeview(search);
		List<NoticeDTO> faqview = noticeMapper.faqview();
		attachMapper.noticeList();
		attachMapper.faqList();
		List<NoticeAttachDTO> noticeList = attachMapper.noticeList();
		List<NoticeAttachDTO> faqList = attachMapper.faqList();
		for (NoticeAttachDTO notice : noticeList) {
			String path = notice.getUploadpath();
			notice.setUploadpath(path.replaceAll("\\\\", "/"));
		}
		for (NoticeAttachDTO faq : faqList) {
			String path = faq.getUploadpath();
			faq.setUploadpath(path.replaceAll("\\\\", "/"));
		}
		model.addAttribute("noticeview", noticeview);
		model.addAttribute("faqview", faqview);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("faqList", faqList);
		model.addAttribute("member_id", member_id);
		model.addAttribute("tab", tab);
		model.addAttribute("scrollq", q);
	}
	
	@ResponseBody
	@PostMapping("/scroll")
	public Map<String, Object> scroll(String cnt, String scrq) throws Exception {
		Map<String, Object> search = new HashedMap<>();
		search.put("q", scrq);
		search.put("cnt", 10*Integer.parseInt(cnt));
		log.info(search);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Map<String, Object> scroll = new HashedMap<>();
		List<NoticeDTO> nList = noticeMapper.scrollnotice(search);
		for (NoticeDTO nDto : nList) {
			nDto.setDate(simpleDateFormat.format(nDto.getNotice_date()));
		}
		List<NoticeAttachDTO> noticeattachscroll = attachMapper.noticeattachscroll(search);
		for (NoticeAttachDTO nAttachDTO : noticeattachscroll) {
			String path = nAttachDTO.getUploadpath();
			nAttachDTO.setUploadpath(path.replaceAll("\\\\", "/"));
		}
		for (NoticeDTO noticeDTO : nList) {
			List<NoticeAttachDTO> query = new ArrayList<NoticeAttachDTO>();
			for (NoticeAttachDTO noticeAttachDTO : noticeattachscroll) {
				noticeDTO.getNotice_num();
				noticeAttachDTO.getBno();
				if (noticeDTO.getNotice_num() == noticeAttachDTO.getBno()) {
					query.add(noticeAttachDTO);
				}
			}
			noticeDTO.setAttachList(query);
		}
		
//		for (NoticeDTO noticeDTO : nList) {
//			log.info("최종 map에 저장: " + noticeDTO);
//		}

		scroll.put("noticeview", nList);
		scroll.put("allcnt", noticeMapper.cntNotice());
		return scroll;
	}
	@ResponseBody
	@PostMapping("/scrollfaq")
	public Map<String, Object> scrollfaq(String cntfaq) throws Exception {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Map<String, Object> scrollfaq = new HashedMap<>();
		
		List<NoticeDTO> nList = noticeMapper.scrollfaq(10*Integer.parseInt(cntfaq));
		for (NoticeDTO nDto : nList) {
			nDto.setDate(simpleDateFormat.format(nDto.getNotice_date()));
		}
		
		List<NoticeAttachDTO> faqattachscroll = attachMapper.faqattachscroll(10*Integer.parseInt(cntfaq));
		for (NoticeAttachDTO faqAttachDTO : faqattachscroll) {
			String path = faqAttachDTO.getUploadpath();
			faqAttachDTO.setUploadpath(path.replaceAll("\\\\", "/"));
		}
		
		for (NoticeDTO noticeDTO : nList) {
			List<NoticeAttachDTO> query = new ArrayList<NoticeAttachDTO>();
			for (NoticeAttachDTO faqAttachDTO : faqattachscroll) {
				noticeDTO.getNotice_num();
				faqAttachDTO.getBno();
				if (noticeDTO.getNotice_num() == faqAttachDTO.getBno()) {
					query.add(faqAttachDTO);
				}
			}
			noticeDTO.setAttachList(query);
		}
		
		for (NoticeDTO noticeDTO : nList) {
			log.info("최종 map에 저장 FAQ: " + noticeDTO);
		}
		
		scrollfaq.put("faqview", nList);
		scrollfaq.put("allcntfaq", noticeMapper.cntFAQ());
		scrollfaq.put("faqattachscroll", attachMapper.faqattachscroll(10*Integer.parseInt(cntfaq)));
		return scrollfaq;
	}
	
	@RequestMapping(value = "/noticeadd", method = RequestMethod.POST)
	public String noticeadd(NoticeDTO nDto, String notice_title5, String notice_contents5, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response) throws Exception {
		nDto.setNotice_title(notice_title5);
		nDto.setNotice_contents(notice_contents5);
		noticeMapper.createNotice(nDto);
		
		log.info("글 등록" + nDto);
		for (NoticeAttachDTO nlist : nDto.getAttachList()) {
			String result = StringUtils.deleteWhitespace(nlist.getFileName());
			nlist.setFileName(result);
			log.info("nlist:----------  " + nlist);
		}
		log.info("글 제목: " + notice_title5 + ", 글 내용: " + notice_contents5);
		if (nDto.getAttachList() == null || nDto.getAttachList().size() <= 0) {
			return "redirect:/board/service?member_id=" + nDto.getMember_id();
		}
		if (nDto.getAttachList() != null) {
			nDto.getAttachList().forEach(attach -> log.info(nDto));
		}
		nDto.getAttachList().forEach(attach -> {
			log.info("글 사진 등록:  " + attach);
			attach.setBno(nDto.getNotice_num());
			attachMapper.insert(attach);
		});
		
		return "redirect:/board/service?member_id=" + nDto.getMember_id();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(NoticeDTO nDto, String member_id, NoticeAttachDTO nAttachDTO) throws Exception{
		log.info("nDto: "+ nDto);
		log.info("nAttachDTO: " + nAttachDTO);
		attachMapper.deleteN(nAttachDTO.getBno());
		noticeMapper.delete(nDto);
		return "redirect:/board/service?member_id=" + member_id;
	}
	
	@RequestMapping(value = "/deletefaq", method = RequestMethod.POST)
	public String deletefaq(NoticeDTO nDto, String member_id, NoticeAttachDTO nAttachDTO) throws Exception{
		log.info("nDto: "+ nDto);
		log.info("nAttachDTO: " + nAttachDTO);
		attachMapper.deleteF(nAttachDTO.getBno());
		noticeMapper.deletefaq(nDto);
		return "redirect:/board/service?member_id=" + member_id;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET() throws Exception{

	}
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public void modifyPOST(NoticeDTO nDto, String member_id, NoticeAttachDTO nAttachDTO, Model model) throws Exception{
		log.info("nDto" + nDto.getNotice_num());
		log.info("nAttachDTO" + nAttachDTO.getBno());
		log.info("읽어오기 =====>" + noticeMapper.read(nDto.getNotice_num()));
		model.addAttribute("read", noticeMapper.read(nDto.getNotice_num()));
		model.addAttribute("member_id" + member_id);
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<NoticeAttachDTO>> getAttachList(int bno) throws Exception{
		log.info("getAttachList" + bno);
		return new ResponseEntity<List<NoticeAttachDTO>>(attachMapper.findByBno(bno), HttpStatus.OK);
	}
	
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String edit(NoticeDTO nDto, String member_id) throws Exception{
		for (NoticeAttachDTO attachDTO : nDto.getAttachList()) {
			String result = StringUtils.deleteWhitespace(attachDTO.getFileName());
			attachDTO.setFileName(result);
		}
		log.info("nDto:" + nDto);
		attachMapper.deleteAll(nDto.getNotice_num());
		boolean modifyResult = noticeMapper.update(nDto) == 1;
		if (modifyResult && nDto.getAttachList() != null && nDto.getAttachList().size() > 0) {
			nDto.getAttachList().forEach(attach -> {
				attach.setBno(nDto.getNotice_num());
				attachMapper.insert(attach);
			});
		}
		
		return "redirect:/board/service?member_id=" + member_id;
	}
	
}
	