package com.jiwonmall.jiwon.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jiwonmall.jiwon.mail.Mail;
import com.jiwonmall.jiwon.member.domain.MemberDTO;
import com.jiwonmall.jiwon.member.service.IMemberService;
import com.jiwonmall.jiwon.product.domain.CartDTO;
import com.jiwonmall.jiwon.product.mapper.CartMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private IMemberService mService;
	
	@Setter(onMethod_ = @Autowired)
	private CartMapper cartMapper;
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public void signinGet(String sign, Model model) throws Exception {
		model.addAttribute("sign", sign);
		log.info("signin get......................");
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String signinPost(String user_id, String user_pwd, HttpSession session) throws Exception {
		log.info("signin post......................");
		MemberDTO mDto = mService.signin(user_id.toLowerCase());
		if (mDto != null) {
			if (mDto.getMember_pwd().equals(user_pwd)) {
				if (mDto.getMember_useyn().equals("Y")) {
					session.removeAttribute("id");
					session.setAttribute("loginUser", mDto);
					log.info(mDto);
					log.info("로그인 성공");
					session.setAttribute("cart", cartMapper.userCart(user_id));
					cartMapper.deleteCart(user_id);
					return "redirect:/main";
				}
			}
		}
		return "member/signin_fail";
	}
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signup(String email1, String email2, String member_pwd, String member_name, String member_tel,
			String member_zip_num, String member_addr1, String member_addr2, String member_event) throws Exception {
		MemberDTO mDto = new MemberDTO();
		String member_id1 = email1+"@"+email2;
		String member_id = member_id1.toLowerCase();
		mDto.setMember_id(member_id);
		mDto.setMember_pwd(member_pwd);
		mDto.setMember_name(member_name);
		mDto.setMember_tel(member_tel);
		mDto.setMember_zip_num(member_zip_num);
		mDto.setMember_address(member_addr1 + member_addr2);
		mDto.setMember_event(member_event);
		log.info(mDto.toString());
		mService.signup(mDto);
		log.info("회원가입 성공");
		Mail mail = new Mail(member_id, "지원몰 가입을 위해 링크를 클릭해주세요", "http://192.168.4.203:9090/member/useyn?email="+member_id);
		
		return "member/signin";
	}
	
	@RequestMapping(value = "/useyn")
	public String useyn(String email) throws Exception {
		log.info(email);
		mService.useynMember(email);
		return "member/signin";
	}
	
	@RequestMapping(value = "/idcheck")
	public void idcheck(String mail, HttpServletResponse response) throws Exception {
		String member_id = mail.trim().toLowerCase();
		log.info(member_id);
		int message = mService.idchk(member_id);
		JSONObject jObject = new JSONObject();
		jObject.put("message", message);
		jObject.put("id", member_id);
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(jObject);
	}
	@RequestMapping("/loginforget")
	public String loginforget() {
		return "member/loginforget";
	}
	@RequestMapping(value = "/membermodify", method = RequestMethod.GET)
	public String membermodifyGet() {
		return "member/membermodify";
	}
	@RequestMapping(value = "/membermodify", method = RequestMethod.POST)
	public String membermodifyPost(String member_id, String member_pwd1, String member_name,
			String member_zip_num, String member_addr1, String member_addr2) throws Exception {
		MemberDTO mDto = new MemberDTO();
		mDto.setMember_id(member_id);
		mDto.setMember_pwd(member_pwd1);
		mDto.setMember_name(member_name);
		mDto.setMember_zip_num(member_zip_num);
		mDto.setMember_address(member_addr1+member_addr2);
		mService.updateMember(mDto);
		return "common/main";
	}
	
	@RequestMapping("/dropmember")
	public String dropmember(String member_id, HttpSession session) throws Exception {
		mService.dropMember(member_id);
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping(value = "membercheck", method = RequestMethod.GET)
	public String membercheckGet() {
		return "member/membercheck";
	}
	@RequestMapping(value = "membercheck", method = RequestMethod.POST)
	public void membercheckPost() {
	}
	@RequestMapping("useterms")
	public String useterms() {
		return "member/useterms";
	}
	@RequestMapping("privacy")
	public String privacy() {
		return "member/privacy";
	}
	@RequestMapping("signout")
	public String signout(HttpSession session) throws Exception {
//		List<CartDTO> cart = new ArrayList<CartDTO>();
//		cart = (ArrayList)session.getAttribute("cart");
//		if (cart.size() > 0) {
//			for (CartDTO cDto : cart) {
//				cartMapper.insertCart(cDto);
//			}
//		}
		session.invalidate();
		return "redirect:/main";
	}

}
