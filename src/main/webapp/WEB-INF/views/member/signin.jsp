<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link type="text/css" rel="stylesheet" href="/resources/css/signin.css">
<link type="text/css" rel="stylesheet" href="/resources/css/terms.css">

<script type="text/javascript">
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

$(document).ready(function() {
	$("#idcheck").hide();
	$("#idcheckbtn").click(function(){
		var member_id = $("#email1").val();
		var member_domain = $("#email2").val();
		var mail = member_id+"@"+member_domain;
		var reg1  =  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일
        if (mail == "@") {
           $("#msg").html("필수 입력 항목 입니다.").css("color", "red");
        }else {
           $.ajax({
              type : "post",
              url : "/member/idcheck",
              dataType : "json",
              data : "mail=" + mail,
              success : function(data){
                 if (data.message == "-1") {
                    $("#msg").html("이미 존재하는 아이디입니다.").css("color","red");
                    $("#idcheck").attr("checked", false);
                 } else if (mail == "@") {
                	$("#idcheck").attr("checked", false);
				 } else if (!reg1.test(mail)) {
	                $("#idcheck").attr("checked", false);
	                $("#msg").html("이메일을 형식에 맞게 입력해주세요").css("color","red");
				 } else {
                    $("#msg").html("사용 가능한 아이디입니다.").css("color","blue");
                	$("#idcheck").attr("checked", true);
                 }
              },
              fail : function(){
                 alert("system error");
              }
           });
        }
     });
});

function join() {
	var reg = /[\s]/g; // 공백 체크
	var reg1  =  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일
	var reg2 = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[!@#$?])(?!.*[^a-zA-z0-9!@#$?]).{8,16}$/;
	//비밀번호 영어 숫자 특수문자 조합의 8~16자
	var reg3  = /^\d{2,3}-\d{3,4}-\d{4}$/; //번호
	var reg4  = /^[ㄱ-ㅎ가-힣]+$/; // 한글만
	var reg5 = /^[0-9]{9,12}$/; // 숫자만
	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/; //휴대폰 번호 정규식
	var member_id = $("#email1").val();
	var member_domain = $("#email2").val();
	var member_pwd = $("#member_pwd").val();
	var member_pwd1 = $("#member_pwd1").val();
	var member_name = $("#member_name").val();
	var member_tel = $("#member_tel").val();
	var mail = member_id+"@"+member_domain;
	var member_zip_num = $("#member_zip_num").val();
	var member_addr2 = $("#member_addr2").val();
  	var chk = $("input:checkbox[id='on']");
  	var idchk = $("input:checkbox[id='idcheck']");
	if (member_id == "") {
		alert("이메일을 입력해주세요.");
		$("#email1").focus();
		return false;
	} else if (member_domain == "") {
		alert("도메인을 입력해주세요.");
		$("#email2").focus();
		return false;
	} else if (!reg1.test(mail)) {
		alert("이메일을 형식에 맞게 입력해주세요");
		$("#email1").focus();
		return false;
	}  else if (!idchk.is(":checked")) {
		alert("아이디 중복확인을 눌러주세요");
		$("#idcheckbtn").focus();
		$("#idcheckbtn").css("border","1px solid black");
		return false
	}  else if (member_pwd == "") {
		alert("비밀번호를 입력해주세요");
		$("#member_pwd").focus();
		return false;
	} else if (!reg2.test(member_pwd)) {
		alert("영어 숫자 특수문자 조합의 8~16자의 비밀번호를 입력해주세요 !@#$");
		$("#member_pwd").focus();
		return false;
	} else if (member_pwd != member_pwd1) {
		alert("비밀번호를 일치시켜주세요");
		$("#member_pwd1").focus();
		return false
	} else if (member_name == "") {
		alert("이름을 입력해주세요");
		$("#member_name").focus();
		return false
	} else if (reg.test(member_name)||!reg4.test(member_name)||member_name.length>5||member_name.length<2) {
		alert("이름을 입력해주세요");
		$("#member_name").focus();
		return false
	} else if (member_tel == "") {
		alert("전화번호를 입력해주세요");
		$("#member_tel").focus();
		return false
	}  else if (!regPhone.test(member_tel)) {
		alert("올바른 전화번호를 입력해주세요");
		$("#member_tel").focus();
		return false
	}  else if (member_zip_num == "") {
		alert("주소를 입력해주세요");
		$("#member_zip_num").focus();
		return false
	}  else if (!chk.is(":checked")) {
		alert("약관에 동의해주세요");
		$("#agree").css({"color":"red"});
		return false
	} 
	alert("회원가입을 위해 이메일을 확인해주세요");
	return true
};

function signin() {
	var user_id = $("#user_id").val();
	var user_pwd = $("#user_pwd").val();
	if (user_id == "") {
		alert("아이디를 이메일로 적어주세요");
		return false;
	} else if (user_pwd == "") {
		alert("영어 숫자 특수문자 조합의 8~16자의 비밀번호를 입력해주세요 !@#$");
		return false;
	} else {
		return true;
	}
};


$(document).ready(function() {
	$(".email-signup").hide();
	$("#signup-box-link").click(function(){
	  $(".email-login").fadeOut(100);
	  $(".email-signup").delay(100).fadeIn(100);
	  $("#login-box-link").removeClass("active");
	  $("#signup-box-link").addClass("active");
	  $(".login-box").css("height", "650px");
	});
	$("#login-box-link").click(function(){
	  $(".email-login").delay(100).fadeIn(100);
	  $(".email-signup").fadeOut(100);
	  $("#login-box-link").addClass("active");
	  $("#signup-box-link").removeClass("active");
	  $(".login-box").css("height", "380px");
	});
	
	if ("${sign}" == 2) {
		$(".email-login").fadeOut(100);
		$(".email-signup").delay(100).fadeIn(100);
		$("#login-box-link").removeClass("active");
		$("#signup-box-link").addClass("active");
		$(".login-box").css("height", "650px");
	}
	
	/* 전체선택 */
	$(".join_box").on("click", "#chkAll", function () {
		  var checked = $(this).is(":checked");

		  if(checked){
			document.getElementById("submit").style.cursor= "pointer";
			$("#submit").css({"background-color": "black"});
			$('#submit').prop('disabled', false);
		  	$(this).parents(".join_box").find('input').prop("checked", true);
		  } else {
			document.getElementById("submit").style.cursor= "default";
			$("#submit").css({"background-color": "lightsalmon"});
			$('#submit').prop('disabled', true);
		  	$(this).parents(".join_box").find('input').prop("checked", false);
		  }
		});
	/* 부분해제 */
	$(".join_box").on("click", ".chk", function() {
		  var checked = $(this).is(":checked");

		  if (!checked) {
		  	$("#chkAll").prop("checked", false);
		  }
		});
	/* 부분선택 */
	$(".join_box").on("click", ".chk", function() {
	    var is_checked = true;
	    $(".join_box .chk").each(function(){
	        is_checked = is_checked && $(this).is(":checked");
	    });
	    $("#chkAll").prop("checked", is_checked);
	});
	
	$(".join_box").on("click", "#chk", function() {
		var checked = $(this).is(":checked");
		if(checked){
			document.getElementById("submit").style.cursor= "pointer";
			$('#submit').prop('disabled', false);
			 
		} else {
			$('#submit').prop('disabled', true);
		}
	});
	$("#chk1, #chk2").on("click", function () {
		  var checked1 = $("#chk1").is(":checked");
		  var checked2 = $("#chk2").is(":checked");
		  if(checked1 && checked2){
				document.getElementById("submit").style.cursor= "pointer";
				$("#submit").css({"background-color": "black"});
				$('#submit').prop('disabled', false);
			  } else {
				document.getElementById("submit").style.cursor= "default";
				$("#submit").css({"background-color": "lightsalmon"});
				$('#submit').prop('disabled', true);
			  }
	});
	
	$("#btemail").click(function () {
		let str = ''
		for (let i = 0; i < 5; i++) {
			str += Math.floor(Math.random() * 10)
		}
		$("input#ramdoncode").val(str);
	});

	
});

function openModal(width, height, hypervisor, instance) {

	$('#modal').css("width", width);
	$('#modal').css("height", height);
	$('#modal_back').css("display", "block");
	$("body").css("background","#5D5D5D");
};
function closeModal() {
	$('#modal_back').css("display", "none");
	$("body").css("background","#bdc3c7");
	$("#on").attr("checked", true);
  	var chk = $("input:checkbox[id='chk4']");
  	if (chk.is(":checked")) {
		$("input#event").val("Y");
	} else {
		$("input#event").val("N");
	}
};

function selectEmail(ele){
	var $ele = $(ele);
	var $email2 = $('input[name=email2]');
	// '1'인 경우 직접입력
	if($ele.val() == "1"){
		$email2.attr('readonly', false);
		$email2.val(''); 
	} else {
		$email2.attr('readonly', true);
		$email2.val($ele.val()); 
	} 
};


</script>


	<div class="bigsign">
	  <div class="login-box">
	    <div class="lb-header">
	      <a href="#" class="active" id="login-box-link">로그인</a>
	      <a href="#" id="signup-box-link">회원가입</a>
	    </div>
<!-- 	    <div class="social-login">
	      <a href="#">
	        <i class="fa fa-facebook-plus fa-lg"></i>
				페이스북
	      </a>
	      <a href="#">
	        <i class="fa fa-google-plus fa-lg"></i>
				네이버
	      </a>
 	      <a href="#">
	        <i class="fa fa-google-plus fa-lg"></i>
				카카오
	      </a>
	      <a href="#">
	        <i class="fa fa-google-plus fa-lg"></i>
				구글
	      </a>
	    </div> -->
	    <form class="email-login" action="${contextPath}/member/signin" method="post" name="frmin" onsubmit="return signin();">
	      <div class="u-form-group">
	        <input type="email" name="user_id" id="user_id" placeholder="이메일" value="cnlguq@gmail.com"/>
	      </div>
	      <div class="u-form-group">
	        <input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호" value="1234"/>
	      </div>
	      <div class="u-form-group">
	        <button type="submit" style="cursor: pointer;">로그인</button>
	      </div>
	      <div class="u-form-group">
	        <a href="${contextPath}/member/loginforget" class="forgot-password">Forgot password?</a>
	      </div>
	      <div style="color: black; text-transform: lowercase;">관리자 계정: cnlguq@gmail.com , 비밀번호: 1234</div>
	    </form>
	    <form class="email-signup" action="${contextPath}/member/signup" onsubmit="return join();" method="post" name="frm">
	      <div class="u-form-group" style="color: black;">
	      	<span id="msg" style="float: left; margin-left: 40px; margin-right: 80px;"></span><br>
	      	<input type="checkbox" name="idcheck" id="idcheck" disabled="disabled">
	        <input type="button" value="중복확인" id="idcheckbtn" style="float: right;">
	        <input type="text" placeholder="이메일" name="email1" id="email1" style="width: 100px;" maxlength="20"/>@
	        <input type="text" name="email2" id="email2" style="width: 150px;" maxlength="20">
	        <select name="select_email" class="opsel" onchange="selectEmail(this)">
	        	<option value="" selected="selected">선택하세요</option>
	        	<option value="naver.com" style="color: black;">naver.com</option>
	        	<option value="gmail.com">gmail.com</option>
	        	<option value="hanmail.net">hanmail.net</option>
	        	<option value="1">직접입력</option>
	        </select>
	      </div>
	      <div class="u-form-group">
	        <input type="password" placeholder="비밀번호" id="member_pwd" name="member_pwd" maxlength="20"/>
	      </div>
	      <div class="u-form-group">
	        <input type="password" placeholder="비밀번호 확인" id="member_pwd1" maxlength="20"/>
	      </div>
	      <div class="u-form-group">
	        <input type="text" placeholder="이름" name="member_name" id="member_name" maxlength="10"/>
	      </div>
	      <div class="u-form-group">
	        <input type="text" placeholder="휴대폰번호를 입력해주세요" name="member_tel" id="member_tel" maxlength="15"/>
	      </div>
	      <div class="u-form-group">
	        <input type="text" placeholder="우편번호" readonly="readonly" id="member_zip_num" name="member_zip_num" style="width: 140px;"/>
	        <input type="button" value="주소찾기" id="address_kakao" style="cursor: pointer;"><br>
	      </div>
	      <div class="u-form-group">
	        <input type="text" placeholder="주소" readonly="readonly" id="member_addr1" name="member_addr1"/><br>
	      </div>
	      <div class="u-form-group">
	        <input type="text" placeholder="상세주소를 입력해주세요" id="member_addr2" name="member_addr2" maxlength="30"/><br>
	      </div>
	      <div class="u-form-group">
				<input type="checkbox" name="termchk" id="on" disabled="disabled">
				<a href="javascript:openModal(540, 850)" style="color: black;" id="agree">이용약관에 동의해주세요</a><br>
				<input type="hidden" id="event" value="" name="member_event">
				<input type="hidden" id="emailchk" value="" name="emailchk" class="emailchk">
	        <button type="submit" id="member_signup" style="cursor: pointer;">회원가입</button>
	      </div>
			
	    </form>

	  </div>
	</div>
		    <div id="modal_back">
			<div id="modal">
						<ul class="join_box">
							<li class="checkBox check01">
								<ul class="clearfix">
				                	<li>이용약관, 개인정보 수집 및 이용<!-- , 위치정보 이용약관(선택), 프로모션 안내
				                   		메일 수신(선택) -->에 모두 동의합니다.
				                   	</li>
				                	<li class="checkAllBtn">
				                       <input type="checkbox" name="chkAll" id="chkAll" class="chkAll">
				                	</li>
								</ul>
							</li>
							<li class="checkBox check02">
								<ul class="clearfix">
				                   <li>이용약관 동의(필수)</li>
									<li class="checkBtn">
										<input type="checkbox" name="chk" id="chk1" class="chk"> 
									</li>
								</ul>
								<textarea>여러분을 환영합니다.지원몰 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다.
				  					본 약관은 다양한 지원몰 서비스의 이용과 관련하여 지원몰 서비스를 제공하는 
				  					지원몰 주식회사(이하 ‘지원몰’)와 이를 이용하는 지원몰 서비스 회원(이하 ‘회원’) 
				  					또는 비회원과의 관계를 설명하며, 아울러 여러분의 지원몰 서비스 이용에 도움이 될 수 있는 
				  					유익한 정보를 포함하고 있습니다.
								</textarea>
							</li>
							<li class="checkBox check03">
								<ul class="clearfix">
									<li>개인정보 수집 및 이용에 대한 안내(필수)</li>
									<li class="checkBtn">
										<input type="checkbox" name="chk" id="chk2" class="chk">
									</li>
								</ul>
				
								<textarea>여러분을 환영합니다.
									지원몰 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 
									본 약관은 다양한 지원몰 서비스의 이용과 관련하여 지원몰 서비스를 제공하는 지원몰
									주식회사(이하 ‘지원몰’)와 이를 이용하는 지원몰 서비스 회원(이하 ‘회원’) 
									또는 비회원과의 관계를 설명하며, 아울러 여러분의 지원몰 서비스 이용에 도움이
									될 수 있는 유익한 정보를 포함하고 있습니다.
								</textarea>
							</li>
				 			<li class="checkBox check03">
								<ul class="clearfix">
									<li>위치정보 이용약관 동의(선택)</li>
									<li class="checkBtn">
										<input type="checkbox" name="chk1" id="chk3" class="chk">
									</li>
								</ul>
				
								<textarea>여러분을 환영합니다.
									지원몰 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 
									본 약관은 다양한 지원몰 서비스의 이용과 관련하여 지원몰 서비스를 제공하는 
									지원몰 주식회사(이하 ‘지원몰’)와 이를 이용하는 지원몰 서비스 회원(이하 ‘회원’)
									 또는 비회원과의 관계를 설명하며, 아울러 여러분의 지원몰 서비스 이용에 도움이 
									 될 수 있는 유익한 정보를 포함하고 있습니다.
								</textarea>
							</li>
							<li class="checkBox check04">
								<ul class="clearfix">
									<li>이벤트 등 프로모션 알림 메일 수신(선택</li>
									<li class="checkBtn">
										<input type="checkbox" name="chk2" id="chk4" class="chk">
									</li>
								</ul>
							</li>
						</ul>
						<ul class="footBtwrap clearfix">
							<li>
								<button type="button" class="fpmgBt2" disabled="disabled" id="submit" onclick="javascript:closeModal()" style="cursor: pointer;">
									확인
								</button>
							</li>
						</ul>
			</div>
			</div>

<%@ include file="../common/footer.jsp" %>