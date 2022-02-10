<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link type="text/css" rel="stylesheet" href="/resources/css/signin.css">
<script>
window.onload = function post_zip(){
    document.getElementById("address_kakao").addEventListener("click", function (){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("member_zip_num").value = data.zonecode; // 우편번호 넣기
                document.querySelector("input[name=member_zip_num]").focus(); //상세입력 포커싱
                document.getElementById("member_addr1").value = data.address; // 주소 넣기
                document.querySelector("input[name=member_addr1]").focus(); //상세입력 포커싱
            }
        }).open();
    });
};

function check(modi) {
	var reg = /[\s]/g; // 공백 체크
	var reg1  =  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일
	var reg2 = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[!@#$?])(?!.*[^a-zA-z0-9!@#$?]).{8,16}$/;
	//비밀번호 영어 숫자 특수문자 조합의 8~16자
	var reg3  = /^\d{2,3}-\d{3,4}-\d{4}$/; //번호
	var reg4  = /^[ㄱ-ㅎ가-힣]+$/; // 한글만
	var reg5 = /^[0-9]{9,12}$/; // 숫자만
	var member_pwd = $("#member_pwd").val();
	var member_pwd1 = $("#member_pwd1").val();
	var member_pwd2 = $("#member_pwd2").val();
	var userpwd = $("#userpwd").val();
	var member_name = $("#member_name").val();
	var member_tel = $("#member_tel").val();
	var member_zip_num = $("#member_zip_num").val();

	if (userpwd != member_pwd) {
		alert("비밀번호가 틀렸습니다.");
		$("#member_pwd").focus();
	} else if (member_pwd1 == "") {
		alert("새 비밀번호를 입력해주세요");
		$("#member_pwd1").focus();
	} else if (!reg2.test(member_pwd1)) {
		alert("영어 숫자 특수문자 조합의 8~16자의 비밀번호를 입력해주세요 !@#$%");
		$("#member_pwd1").focus();
	} else if (member_pwd2 == "") {
		alert("새 비밀번호 확인을 입력해주세요");
		$("#member_pwd2").focus();
	} else if (member_pwd1 != member_pwd2) {
		alert("새 비밀번호를 일치시켜주세요");
		$("#member_pwd2").focus();
	} else if (member_name == "") {
		alert("이름을 입력해주세요");
		$("#member_name").focus();
	} else if (reg.test(member_name)||!reg4.test(member_name)||member_name.length>5||member_name.length<2) {
		alert("2-5자의 한글을 입력해주세요");
		$("#member_name").focus();
	} else if (member_tel == "") {
		alert("전화번호를 입력해주세요");
		$("#member_tel").focus();
	} /* else if (!reg5.test(member_tel)) {
		alert("전화번호를 입력해주세요");
		$("#member_tel").focus();
		return false
	} */ else if (member_zip_num == "") {
		alert("주소를 입력해주세요");
		$("#member_zip_num").focus();
	} else {
		alert("회원정보가 수정되었습니다");
	    modi.action = "/member/membermodify";
	    modi.submit();
	}
	
};

function drop(user) {
	alert("회원탈퇴에 성공했습니다.");
	user.action = "/member/dropmember";
	user.submit();
}



$(document).ready(function() {
	$(".login-box").css("height", "720px");
	
});
</script>


	<div class="bigsign">
		<div class="login-box">
			<form class="email-signup" action="#" onsubmit="return check();" method="post" name="frm">
					<h3 style="color: black;">회원정보 수정</h3>
			      <div class="u-form-group" style="color: black;">
			        <input type="text" placeholder="이메일" name="member_id" id="member_id" value="${loginUser.member_id}" readonly="readonly"/>
			      </div>
			      <div class="u-form-group">
			        <input type="password" placeholder="현재 비밀번호" id="member_pwd" name="member_pwd" maxlength="20"/>
			        <input type="hidden" value="${loginUser.member_pwd}" id="userpwd">
			      </div>
			      <div class="u-form-group">
			        <input type="password" placeholder="새 비밀번호" id="member_pwd1" name="member_pwd1" maxlength="20"/>
			      </div>
			      <div class="u-form-group">
			        <input type="password" placeholder="새 비밀번호 확인" id="member_pwd2" name="member_pwd2" maxlength="20"/>
			      </div>
			      <div class="u-form-group">
			        <input type="text" placeholder="이름" value="${loginUser.member_name}" name="member_name" id="member_name" maxlength="10"/>
			        <input type="hidden" value="${loginUser.member_name}" id="user_name">
			      </div>
			      <div class="u-form-group">
			        <input type="text" placeholder="휴대폰번호를 입력해주세요" name="member_tel" id="member_tel" value="${loginUser.member_tel}" readonly="readonly"/>
			      </div>
			      <div class="u-form-group">
			        <input type="text" placeholder="우편번호" readonly="readonly" id="member_zip_num" name="member_zip_num" value="${loginUser.member_zip_num}" style="width: 140px;"/>
			        <input type="button" value="주소찾기" id="address_kakao" style="cursor: pointer;"><br>
			      </div>
			      <div class="u-form-group">
			        <input type="text" placeholder="주소" readonly="readonly" id="member_addr1" name="member_addr1" value="${loginUser.member_address}"/><br>
			      </div>
			      <div class="u-form-group">
			        <input type="text" placeholder="상세주소를 입력해주세요" id="member_addr2" name="member_addr2" maxlength="30"/><br>
			      </div>
			      <div class="u-form-group">
			        <button type="button" style="cursor: pointer;" onclick="check(frm);">회원정보 수정</button><br>
			        <input type="button" value="회원탈퇴" style="color: white; background-color: black; float: right; cursor: pointer;" onclick="drop(frm)">
			      </div>
					
			</form>
		</div>
	</div>

<%@ include file="../common/footer.jsp" %>