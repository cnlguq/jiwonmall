package com.jiwonmall.jiwon;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import com.jiwonmall.jiwon.product.domain.CartDTO;
import com.jiwonmall.jiwon.product.mapper.CartMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebListener
@Log4j
public class Sessionconfig implements HttpSessionListener{

	
	@Setter(onMethod_ = @Autowired)
	private CartMapper cartMapper;
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		log.info("세션 생성");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		List<CartDTO> cart = new ArrayList<CartDTO>();
		log.info("세션 종료");
		log.info("세션 null 체크: " + se.getSession().getAttribute("cart"));
		if (se.getSession().getAttribute("cart") != null) {
			cart = (ArrayList)se.getSession().getAttribute("cart");
			if (cart.size() > 0) {
				log.info(cart);
				for (CartDTO cDto : cart) {
					try {
//					cartMapper.insertCart(cDto);
						getcartMapper(se).insertCart(cDto);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	private CartMapper getcartMapper(HttpSessionEvent se) {
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(
				se.getSession().getServletContext());
		return (CartMapper)context.getBean("cartMapper");
	}
	

}
