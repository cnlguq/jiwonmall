<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<link type="text/css" rel="stylesheet" href="/resources/css/signin.css">
<script>
function check() {
	var pwd = $("#pwd").val();
	var userpwd = $("#member_pwd").val();
 	if (pwd == userpwd) {
 	 	$("#member_pwd").css("border","1px solid blue");
		return true;
	}
 	$("#member_pwd").css("border","1px solid red");
 	return false

};
</script>

	<div class="bigsign">
		<div class="login-box">
			<form class="email-login" action="${contextPath}/member/membermodify" method="get" name="frm" onclick="return check();">
			<h1 style="color: black;">회원정보확인</h1>
				<div class="u-form-group">
					<input type="email" name="member_id" placeholder="이메일" value="${loginUser.member_id}" readonly="readonly"/>
				</div>
				<div class="u-form-group">
					<input type="password" name="member_pwd" id="member_pwd" placeholder="비밀번호"/><br>
					<span id="pwpwd"></span>
					<input type="hidden" name="pwd" id="pwd" value="${loginUser.member_pwd}">
				</div>
				<div class="u-form-group">
					<button type="submit" style="cursor: pointer;">확인</button>
				</div>
			</form>
	</div>
	</div>
	
	
	    
<%@ include file="../common/footer.jsp" %>