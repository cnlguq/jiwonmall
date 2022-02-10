<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){


});
</script>
<style>

/*****************globals*************/
body {
  font-family: 'open sans';
  overflow-x: hidden; 
}

img {
  max-width: 100%; }

.preview {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -webkit-flex-direction: column;
      -ms-flex-direction: column;
          flex-direction: column; }
  @media screen and (max-width: 996px) {
    .preview {
      margin-bottom: 20px; } }

.preview-pic {
  -webkit-box-flex: 1;
  -webkit-flex-grow: 1;
      -ms-flex-positive: 1;
          flex-grow: 1; }

.preview-thumbnail.nav-tabs {
  border: none;
  margin-top: 15px; }
  .preview-thumbnail.nav-tabs li {
    width: 18%;
    margin-right: 2.5%; }
    .preview-thumbnail.nav-tabs li img {
	    width: 100px;
		height: 60px;
      max-width: 100%;
      display: block; }
    .preview-thumbnail.nav-tabs li a {
      padding: 0;
      margin: 0; }
    .preview-thumbnail.nav-tabs li:last-of-type {
      margin-right: 0; }

.tab-content {
  overflow: hidden; }
  .tab-content img {
    width: 100%;
    height: 337px;
    -webkit-animation-name: opacity;
            animation-name: opacity;
    -webkit-animation-duration: .3s;
            animation-duration: .3s; }

.card {
color: black;
margin-top: 200px;
margin-bottom: 300px;
background: #eee;
padding: 3em;
line-height: 1.5em;
padding: 100px;}

@media screen and (min-width: 997px) {
  .wrapper {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex; } }

.details {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -webkit-flex-direction: column;
      -ms-flex-direction: column;
          flex-direction: column; }

.colors {
  -webkit-box-flex: 1;
  -webkit-flex-grow: 1;
      -ms-flex-positive: 1;
          flex-grow: 1; }

.product-title, .price, .sizes, .colors {
  text-transform: UPPERCASE;
  font-weight: bold; }

.checked, .price span {
  color: #ff9f1a; }

.product-title, .rating, .product-description, .price, .vote, .sizes {
  margin-bottom: 15px; }

.product-title {
  margin-top: 0; }

.size {
  margin-right: 10px; }
  .size:first-of-type {
    margin-left: 40px; }

.color {
  display: inline-block;
  vertical-align: middle;
  margin-right: 10px;
  height: 2em;
  width: 2em;
  border-radius: 2px; }
  .color:first-of-type {
    margin-left: 20px; }

.add-to-cart, .like {
  background: #ff9f1a;
  padding: 1.2em 1.5em;
  border: none;
  text-transform: UPPERCASE;
  font-weight: bold;
  color: #fff;
  -webkit-transition: background .3s ease;
          transition: background .3s ease; }
  .add-to-cart:hover, .like:hover {
    background: #b36800;
    color: #fff; }

.not-available {
  text-align: center;
  line-height: 2em; }
  .not-available:before {
    font-family: fontawesome;
    content: "\f00d";
    color: #fff; }

.orange {
  background: #ff9f1a; }

.green {
  background: #85ad00; }

.blue {
  background: #0076ad; }

.tooltip-inner {
  padding: 1.3em; }

@-webkit-keyframes opacity {
  0% {
    opacity: 0;
    -webkit-transform: scale(3);
            transform: scale(3); }
  100% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1); } }

@keyframes opacity {
  0% {
    opacity: 0;
    -webkit-transform: scale(3);
            transform: scale(3); }
  100% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1); } }
.preview-thumbnail nav nav-tabs li img{
width: 100px;
height: 60px;
}
a:hover{
cursor: pointer;
}
</style>
	<div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						
						<div class="preview-pic tab-content">
							<c:if test="${empty gDtosimg}">
								<div class="tab-pane active" id="pic-1"><img src="${contextPath}/resources/img/default.jpg"/></div>
							</c:if>
							<c:forEach items="${gDtosimg}" var="gDtosimg" begin="0" end="0" step="1" varStatus="status">
								<div class="tab-pane active" id="pic-1">
								<img src="${contextPath}/resources/fileUpload/${gDtosimg.uploadpath}/${gDtosimg.uuid}_${gDtosimg.fileName}" />
								</div>
							</c:forEach>
							<c:set value="1" var="i"></c:set>
    						<c:forEach items="${gDtosimg}" var="gDtosimg">
								<div class="tab-pane" id="pic-${i}"><img src="${contextPath}/resources/fileUpload/${gDtosimg.uploadpath}/${gDtosimg.uuid}_${gDtosimg.fileName}"/></div>
							<c:set value="${i + 1}" var="i"></c:set>
							</c:forEach>
						</div>
						<ul class="preview-thumbnail nav nav-tabs">
							<c:set value="1" var="i"></c:set>
    						<c:forEach items="${gDtosimg}" var="gDtosimg">
								<li><a data-target="#pic-${i}" data-toggle="tab"><img src="${contextPath}/resources/fileUpload/${gDtosimg.uploadpath}/${gDtosimg.uuid}_${gDtosimg.fileName}"/></a></li>
							<c:set value="${i + 1}" var="i"></c:set>
							</c:forEach>
						</ul>
						
					</div>
					<div class="details col-md-6">
						<h3 class="product-title">${gDtos.goods_name}</h3>
<!-- 						별정 디자인
						<div class="rating">
							<div class="stars">
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star"></span>
								<span class="fa fa-star"></span>
							</div>
							<span class="review-no">41 reviews</span>
						</div> -->
						<p class="product-description">${gDtos.goods_contents}</p>
						<h4 class="price">상품 가격: <span><fmt:formatNumber value="${gDtos.goods_cost}" pattern="#,###"/>&nbsp;₩</span></h4>
						<h6 class="price">상품 제조사: <span>${gDtos.goods_company}</span></h6>
						<h6 class="price">상품 원산지: <span>${gDtos.goods_origin}</span></h6>
						<div class="action ">
							<form action="" name="cartfrm" method="post">
								<input type="hidden" name="goods_num" value="${gDtos.goods_num}">
								<input type="hidden" name="member_id" value="${sessionScope.loginUser.member_id}">
							</form>
							<button class="add-to-cart btn btn-default" data-oper="cartdetail" type="button">장바구니 담기</button>
							<button class="add-to-cart btn btn-default" type="button">바로 구매</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
$(document).ready(function() {
	var operForm = $("form[name=cartfrm]");
	var user = "${sessionScope.loginUser}";
	$("button[data-oper='cartdetail']").on("click", function(e){
		if (user == null || user == "") {
			alert("로그인을 해주세요");
			location.href = "/member/signin?sign=1";
		} else {
		  	operForm.attr("action","${contextPath}/product/cart").submit();
		}
	});
});
</script>



<%@ include file="../common/footer.jsp" %>