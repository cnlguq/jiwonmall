<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<script src="/resources/js/bootstrap.bundle.js" ></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/resources/js/jquery3.6/jquery-3.6.0.min.js"></script>
<script src="/resources/js/jquery-ui.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/header.js"></script>
    Bootstrap Core CSS
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    MetisMenu CSS
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    DataTables CSS
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    DataTables Responsive CSS
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    Custom CSS
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    Custom Fonts
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->

</head>
<style>
.selector-for-some-widget {
  box-sizing: content-box;
}
*, *:before, *:after {-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;margin:0;padding:0}
body{background:#f9fafb;line-height:1.5;font-family:sans-serif;text-transform:uppercase;font-size:16px;color:#fff}
a{text-decoration:none;color:#fff}
#header{background:#1E262D;width:100%;position:relative}
#header:after{content:"";clear:both;display:block}
.search{float:right;padding:30px}
.logo{float:left;padding:26px 0 26px}
.logo a{font-size:28px;display:block;padding:0 0 0 20px}
nav{float:right;}
nav>ul{float:left;position:relative}
nav li{list-style:none;float:left}
nav .dropdown{position:relative}
nav li a{float:left;padding:35px}
nav li a:hover{background:#2C3E50}
nav li ul{display:none}
nav li:hover ul{display:inline}
nav li li{float:none;}
nav .dropdown ul{position:absolute;left:0;top:100%;background:#fff;padding:20px 0;border-bottom:3px solid #34495e; z-index: 100;}
nav .dropdown li{white-space:nowrap;z-index: 100;}
nav .dropdown li a{padding:10px 35px;font-size:13px;min-width:200px;z-index: 100;}
nav .mega-dropdown{width:100%;position:absolute;top:100%;left:0;background:#fff;overflow:hidden;padding:20px 35px;border-bottom:3px solid #34495e;z-index: 100;}
nav li li a{float:none;color:#333;display:block;padding:8px 10px;border-radius:3px;font-size:13px}
nav li li a:hover{background:#bdc3c7;background:#FAFBFB}
.mega-col{width:25%;float:left}
#menu-icon{position:absolute;right:0;top:50%;margin-top:-12px;margin-right:30px;display:none}
#menu-icon span{border:2px solid #fff ;width:30px;margin-bottom:5px;display:block;-webkit-transition:all .2s;transition:all .1s}
@media only screen and (max-width: 1170px) {
  nav >ul>li >a{padding:35px 15px}
}
@media only screen and (min-width: 960px) {
  nav{display:block!important}
}
@media only screen and (max-width: 959px) {
  nav{display:none;width:100%;clear:both;float:none;max-height:500px;overflow-y:scroll}
  #menu-icon{display:inline;top:45px;cursor:pointer}
  #menu-icon.active .first{transform:rotate(45deg);-webkit-transform:rotate(45deg);margin-top:10px}
  #menu-icon.active .second{transform:rotate(135deg);-webkit-transform:rotate(135deg);position:relative;top:-9px;}
  #menu-icon.active .third{display:none}
  .search{float:none}
  .search input{width:100%}
  nav{padding:10px}
  nav ul{float:none}
  nav li{float:none;}
  nav ul li a{float:none;padding:8px;display:block;}
  #header nav ul ul{display:block;position:static;background:none;border:none;padding:0}
  #header nav a{color:#fff;padding:8px}
  #header nav a:hover{background:#fff;color:#333;border-radius:3px;}
  #header nav ul li li a:before{content:"- "}
  .mega-col{width:100%}
}
a:hover {
	color: gray;
}

</style>


<script>


/* window.addEventListener('beforeunload', (event) => {
	  event.preventDefault();
	  // Chrome에서는 returnValue 설정이 필요함
	  alert("aaa");
	  event.returnValue = '';
	}); */
/* $(window).bind("beforeunload", function (e){
	alert("aaa");
	return "창을 닫으실래요?";
}); */

$(document).ready(function() {
	$('#header').prepend('<div id="menu-icon"><span class="first"></span><span class="second"></span><span class="third"></span></div>');

	$("#menu-icon").on("click", function(){
	$("nav").slideToggle();
	$(this).toggleClass("active");
	});
});

function goPost(){
    let f = document.createElement('form');
    f.setAttribute('method', 'post');
    f.setAttribute('action', '/product/cart');
    document.body.appendChild(f);
    f.submit();
}
</script>
<body>
	<!-- 메인 헤더 시작 -->
	<div id="header">
		<div class="logo">
		<a href="${contextPath}/main">JiwonMall</a>
		</div>  
		<nav>
			<form class="search" name="search" method="get" onsubmit="return search(this.form);"> 
				<input name="q" placeholder="검색어를 입력해주세요" type="search" style="font-size: 15px;">
			</form>
			<ul>
				<li>
					<a href="${contextPath}/main">Home</a>
				</li>      
				<c:choose>
					<c:when test="${empty sessionScope.loginUser}">
					<li class="dropdown">
						<a href="${contextPath}/member/signin?sign=1">로그인</a>
					</li>
					<li class="dropdown">
						<a href="${contextPath}/member/signin?sign=2">회원가입</a>
					</li>
	      			</c:when>
		      		<c:otherwise>
			      		<li class="dropdown">
			      			<a style="color: orange;" href="${contextPath}/member/membercheck">${sessionScope.loginUser.member_name}님</a>
							<c:choose>
			      				<c:when test="${loginUser.member_rank eq '1'}">
									<ul>
										<li><a href="${contextPath}/member/membercheck">회원정보 수정</a></li>
										<li><a href="${contextPath}/product/cart">장바구니</a></li>
									</ul>
			      				</c:when>
			      				<c:when test="${loginUser.member_rank eq '2'}">
			      					<ul>
							            <li><a href="${contextPath}/member/membercheck">회원정보 수정</a></li>
										<li><a href="${contextPath}/product/insertproduct">상품등록</a></li>
										<li><a href="${contextPath}/product/cart">장바구니</a></li>
									</ul>
			      				</c:when>
			      				<c:when test="${loginUser.member_rank eq '3'}">
			      					<ul>
							            <li><a href="${contextPath}/member/membercheck">회원정보 수정</a></li>
							            <li><a href="${contextPath}/product/insertproduct">상품등록</a></li>
							            <li><a href="javascript:void(0)" onclick="javascript:goPost()">장바구니</a></li>
									</ul>
			      				</c:when>
			      			</c:choose>
			      		</li>
						<li class="dropdown">
							<a href="${contextPath}/member/signout">로그아웃</a>
						</li>
					</c:otherwise>
				</c:choose>
				<li class="dropdown">
					<a href="${contextPath}/board/service?member_id=${sessionScope.loginUser.member_id}">고객센터</a>
					<ul>
						<li><a href="${contextPath}/board/service?member_id=${sessionScope.loginUser.member_id}&tab=1">공지사항</a></li>
			            <li><a href="${contextPath}/board/service?member_id=${sessionScope.loginUser.member_id}&tab=2">FAQ</a></li>
			            <li><a href="${contextPath}/board/service?member_id=${sessionScope.loginUser.member_id}&tab=3">Q&amp;A</a></li>
			            <li><a href="${contextPath}/board/service?member_id=${sessionScope.loginUser.member_id}&tab=4">1:1문의내역</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
<!-- 메인 헤더 끝-->