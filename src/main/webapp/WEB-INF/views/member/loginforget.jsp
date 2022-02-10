<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<link type="text/css" rel="stylesheet" href="/resources/css/loginforget.css">
<script type="text/javascript">
$(document).ready(function() {
	$(".email-signup").hide();
	$("#signup-box-link").click(function(){
	  $(".email-login").fadeOut(100);
	  $(".email-signup").delay(100).fadeIn(100);
	  $("#login-box-link").removeClass("active");
	  $("#signup-box-link").addClass("active");
	  $(".login-box").css("height", "300px");
	});
	$("#login-box-link").click(function(){
	  $(".email-login").delay(100).fadeIn(100);;
	  $(".email-signup").fadeOut(100);
	  $("#login-box-link").addClass("active");
	  $("#signup-box-link").removeClass("active");
	  $(".login-box").css("height", "300px");
	});
});
</script>

	<div class="bigsign">
	  <div class="login-box">
	    <div class="lb-header">
	      <a href="#" class="active" id="login-box-link">아이디 찾기</a>
	      <a href="#" id="signup-box-link">비밀번호 찾기</a>
	    </div>
	    <form class="email-login">
	      <div class="u-form-group">
	        <input type="text" placeholder="이름"/>
	      </div>
	      <div class="u-form-group">
	        <input type="email" placeholder="이메일"/>
	      </div>
	      <div class="u-form-group">
	        <button>인증번호 전송</button>
	      </div>
	    </form>
	    <form class="email-signup">
	      <div class="u-form-group">
	        <input type="text" placeholder="이름"/>
	      </div>
	      <div class="u-form-group">
	        <input type="email" placeholder="jiwonmall에 가입된 이메일"/>
	      </div>
			<ul style="color:#888; font-size: 10px; width: 325px; margin: 0 auto; text-align: left;">
				<li>비밀번호의 경우 암호화 저장되어 분실 시 찾아드릴 수 없는 정보입니다.</li>
				<li>본인 확인을 통해 비밀번호를 재설정 하실 수 있습니다.</li>
			</ul>
	      <div class="u-form-group" style="margin-top: 10px;">
	        <button>비밀번호 찾기</button>
	      </div>
	    </form>
	  </div>
	</div>

<%@ include file="../common/footer.jsp" %>