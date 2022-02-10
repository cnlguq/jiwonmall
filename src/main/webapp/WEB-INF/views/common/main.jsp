<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<style>
/* 메인 이미지 시작 */
.glyphicon { margin-right:5px; }
.thumbnail
{
    margin-bottom: 20px;
    padding: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
}

.item.list-group-item
{
    float: none;
    width: 100%;
    background-color: #fff;
    margin-bottom: 10px;
}
.item.list-group-item:nth-of-type(odd):hover,.item.list-group-item:hover
{
    background: #428bca;
}

.item.list-group-item .list-group-image
{
    margin-right: 10px;
}
.item.list-group-item .thumbnail
{
    margin-bottom: 0px;
}
.item.list-group-item .caption
{
    padding: 9px 9px 0px 9px;
}
.item.list-group-item:nth-of-type(odd)
{
    background: #eeeeee;
}

.item.list-group-item:before, .item.list-group-item:after
{
    display: table;
    content: " ";
}

.item.list-group-item img
{
    float: left;
}
.item.list-group-item:after
{
    clear: both;
}
.list-group-item-text
{
    margin: 0 0 11px;
}
body {
	color: black;
}
.thumbnail img:hover {
      -webkit-transform: scale(1.05, 1.05);
         transform: scale(1.05, 1.05);
         transition: all 0.3s ease 0s;
}

.filter-item__range input[type=range] {
  box-sizing: border-box;
  appearance: none;
  width: 100%;
  margin: 0;
  padding: 0 2px;
  overflow: hidden;
  border: 0;
  border-radius: 1px;
  outline: none;
  background: linear-gradient(#dbdbdb, grey) no-repeat center;
  background-size: 100% 2px;
  pointer-events: none;
}
.filter-item__range input[type=range]:active, .filter-item__range input[type=range]:focus {
  outline: none;
}
.filter-item__range input[type=range]::-webkit-slider-thumb {
  height: 15px;
  width: 15px;
  border-radius: 50%;
  box-shadow: 1px 2px 6px rgba(0, 0, 0, 0.28);
  background: #dbdbdb;
  position: relative;
  margin: 5px 0;
  cursor: pointer;
  appearance: none;
  -webkit-appearance: none;
  pointer-events: all;
  z-index: 2;
}
.filter-item__range input[type=range]::-webkit-slider-thumb::before {
  content: " ";
  display: block;
  position: relative;
  top: 13px;
  left: 100%;
  width: 2000xp;
  height: 2px;
  background: #1bae73;
}
.filter-item__range .multirange {
  position: relative;
  height: 25px;
}
.filter-item__range .multirange input[type=range] {
  position: absolute;
}
.filter-item__range .multirange input[type=range]:nth-child(1)::-webkit-slider-thumb::before {
  background-color: #1bae73;
}
/* .filter-item__range .multirange input[type=range]:nth-child(2) {
  background: none;
} */
.filter-item__range .multirange input[type=range]:nth-child(2)::-webkit-slider-thumb::before {
  background-color: #979797;
}
.filter-item__range .result {
  display: flex;
  justify-content: space-between;
}
.filter-item__range input[type=range]:active {
  background: linear-gradient(#dbdbdb, gray) no-repeat center;
  background-size: 100% 10px;
}
input{border:none;padding:10px;border-radius:20px}

</style>
<script>
$(document).ready(function() {
    $('#list').click(function(event){event.preventDefault();
    $('#products .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();
    $('#products .item').removeClass('list-group-item');
    $('#products .item').addClass('grid-group-item');});
    
    let foundRanges = document.querySelectorAll(".filter-item__range");

    let rangeFunction = (range) => {
      let lower = range.querySelector(".lower");
      let upper = range.querySelector(".upper");
      let resultL = range.querySelector(".result-l");
      let resultU = range.querySelector(".result-u");

      let lowerVal = parseInt(lower.value);
      let upperVal = parseInt(upper.value);

      let lowMin = parseInt(lower.getAttribute("min"));
      let lowMax = parseInt(lower.getAttribute("max"));

      let upMin = parseInt(upper.getAttribute("min"));
      let upMax = parseInt(upper.getAttribute("max"));

      lower.addEventListener("input", function () {
        lowerVal = parseInt(lower.value);
        upperVal = parseInt(upper.value);

        if (upperVal <= lowerVal + 1) {
          upper.value = lowerVal + 2;
          if (lowerVal == lowMin) {
            upper.value = lowerVal + 2;
          }
        }

        lower.setAttribute("value", lowerVal);
        resultL.textContent = lowerVal;
        resultU.textContent = upperVal;
      });

      upper.addEventListener("input", function () {
        lowerVal = parseInt(lower.value);
        upperVal = parseInt(upper.value);

        if (lowerVal >= upperVal - 1) {
          lower.value = upperVal - 2;
          if (upperVal == upMax) {
            lower.value = upperVal - 2;
          }
        }

        upper.setAttribute("value", upperVal);
        resultL.textContent = lowerVal;
        resultU.textContent = upperVal;
      });
    };

    for (let i = 0; i < foundRanges.length; i++) {
      foundRanges[i].addEventListener(
        "click",
        rangeFunction(foundRanges[i]),
        false
      );
      foundRanges[i].addEventListener(
        "mousemove",
        rangeFunction(foundRanges[i]),
        false
      );
      foundRanges[i].addEventListener(
        "change",
        rangeFunction(foundRanges[i]),
        false
      );
    }

});
function search(obj) {
	var main = $("#mainsearch").val();
	if (main == "main") {
		obj.action = "/main";
		obj.submit();
		return true;
	}
	return false;
}

function maincart(obj) {
	var user = "${sessionScope.loginUser}";
	if (user == null || user == "") {
		alert("로그인을 해주세요");
		location.href = "/member/signin?sign=1";
	} else {
		if (!confirm("장바구니 페이지로 이동하시겠습니까?")) {
			obj.action = "/product/maincart";
			obj.submit();
		} else {
			obj.action = "/product/cart";
			obj.submit();
		}
	}
}
function maincart2(obj) {
	var user = "${sessionScope.loginUser}";
	if (user == null || user == "") {
		alert("로그인을 해주세요");
		location.href = "/member/signin?sign=1";
		return false;
	} else {
		if (!confirm("장바구니 페이지로 이동하시겠습니까?")) {
			obj.action = "/product/maincart";
			obj.submit();
		} else {
			obj.action = "/product/cart";
			obj.submit();
		}
	}
}
</script>
<!-- 메인페이지 메인이미지 시작 -->
<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/resources/images/main2.jfif" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/images/main3.jfif" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/images/main.jfif" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev " type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev" style="background-color: rgba( 255, 255, 255, 0 ); border: none;">
<!--     <span class="carousel-control-prev-icon" aria-hidden="true"></span> -->

  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next" style="background-color: rgba( 255, 255, 255, 0 ); border: none;">
<!--     <span class="carousel-control-next-icon" aria-hidden="true"></span> -->

  </button>
</div>
	<!-- 메인 이미지 끝 -->
	
	<!-- 메인 페이지 이미지들 -->
<div class="container">
	<input type="hidden" value="main" id="mainsearch">
	<div class="well well-sm">
        <strong>Display</strong>
        <div class="btn-group">
            <a href="#" id="list" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-th-list">
            </span>List</a> <a href="#" id="grid" class="btn btn-default btn-sm"><span
                class="glyphicon glyphicon-th"></span>Grid</a>
        </div>
        
        <!-- multirange sliderbar -->
        <form action="" method="get" name="range">
			<div class="col-xs-3 col-lg-3 col-xl-3">
				<h3>Price</h3><div class="filter-item__range">
					<div class="multirange">
						<input type="range" id="range1" min="0" max="100000000" value="0" class="lower">
						<input type="range" id="range2" min="0" max="100000000" value="1000000000" class="upper">
					</div>
					<div class="result">
						<p>₩<span class="result-l">0</span> </p>
						<p>₩<span class="result-u">1000000000</span> </p>
					</div>
				</div>
			</div> 
        </form>
	</div>
	
	
    <div id="products" class="row list-group flex-row">
    	<input type="hidden" value="${rangeq}" id="rangeq">
    	<c:forEach items="${gDtos}" var="gDtos">
			<c:set value="1" var="i"></c:set>
    		<c:forEach items="${gDtosimg}" var="gDtosimg">
				<c:set value="${gDtosimg.bno}" var="bno"></c:set>
				<c:set value="${gDtosimg.fileName}" var="fileName"></c:set>
    			<c:choose >
    				<c:when test="${empty gDtos.goods_image}">
   						<c:if test="${i eq 1}">
			    			<div class="item  col-xs-4 col-lg-6 col-xl-4">
						        <div class="thumbnail">
						        	<a href="${contextPath}/product/productdetail?goods_num=${gDtos.goods_num}">
						            <img class="group list-group-image" src="${contextPath}/resources/img/default.jpg" style="width: 350px; height: 250px;"/>
						            </a>
						            <div class="caption">
						                <h4 class="group inner list-group-item-heading">${gDtos.goods_name}</h4>
						                <p class="group inner list-group-item-text">
						                	${gDtos.goods_contents}
						                </p>
						                <div class="row">
						                    <div class="col-xs-12 col-md-6">
						                        <p class="lead">
						                        	<fmt:formatNumber value="${gDtos.goods_cost}" pattern="#,###"/>원
						                        </p>
						                    </div>
						                    <div class="col-xs-12 col-md-6">
							                    <form action="#" name="frm" method="post">
							                        <input class="btn btn-success" type="button" value="장바구니 담기" onclick="maincart(this.form);">
							                        <input type="hidden" name="goods_num" value="${gDtos.goods_num}">
							                        <input type="hidden" name="member_id" value="${sessionScope.loginUser.member_id}">
							                    </form>
						                    </div>
						                </div>
						            </div>
						        </div>
							</div>
   						</c:if>
						<c:set value="${i + 1}" var="i"></c:set>
    				</c:when>
    				<c:otherwise>
    					<c:if test="${gDtos.goods_num eq bno}">
    						<c:if test="${gDtos.goods_image eq fileName}">
							    <div class="item  col-xs-4 col-lg-6 col-xl-4">
							        <div class="thumbnail">
							        	<a href="${contextPath}/product/productdetail?goods_num=${gDtos.goods_num}">
							            <img class="group list-group-image" src="${contextPath}/resources/fileUpload/${gDtosimg.uploadpath}/${gDtosimg.uuid}_${gDtos.goods_image}" style="width: 350px; height: 250px;"/>
							            </a>
							            <div class="caption">
							                <h4 class="group inner list-group-item-heading">${gDtos.goods_name}</h4>
							                <p class="group inner list-group-item-text">
							                	${gDtos.goods_contents}
							                </p>
							                <div class="row">
							                    <div class="col-xs-12 col-md-6">
							                        <p class="lead">
							                        	<fmt:formatNumber value="${gDtos.goods_cost}" pattern="#,###"/>원
							                        </p>
							                    </div>
							                    <div class="col-xs-12 col-md-6">
								                    <form action="#" name="frm2" method="post">
								                        <input class="btn btn-success" type="button" value="장바구니 담기" onclick="maincart2(this.form);">
								                        <input type="hidden" name="goods_num" value="${gDtos.goods_num}">
								                        <input type="hidden" name="member_id" value="${sessionScope.loginUser.member_id}">
								                    </form>
							                    </div>
							                </div>
							            </div>
							        </div>
								</div>
							</c:if>
    					</c:if>
    				</c:otherwise>
    			</c:choose>
			</c:forEach>
		</c:forEach>
    </div>
</div>
	
<script>
$(function() {
	var rangeq = $("#rangeq").val();
	$("input[type=range]").mouseup(function() {
		var range1 = $("input[id=range1]").val();
		var range2 = $("input[id=range2]").val();
 		$.ajax({
			type : "post",
			url : "/product/range",
			datatype : "json",
			data : {
				"range1" : range1,
				"range2" : range2,
				"rangeq" : rangeq
			},
			success : function(data) {
				var str = "";
				console.log(data);
				$("#products").empty();
				$(data.rangeList).each(function() {
					if (this.goods_image == null || this.goods_image == "") {
						str += "<div class='item col-xs-4 col-lg-6 col-xl-4'>"
							+  "<div class='thumbnail'>"
							+  "<a href=" + "'/product/productdetail?goods_num=" + this.goods_num + "'>"
							+  "<img class='group list-group-image' src=" + '/resources/img/default.jpg '
							+  "style='width: 350px; height: 250px;'>"
							+  "</a>"
							+  "<div class='caption'>"
							+  "<h4 class='group inner list-group-item-heading'>" + this.goods_name + "</h4>"
							+  "<p class='group inner list-group-item-text'>" + this.goods_contents + "</p>"
							+  "<div class='row'>"
							+  "<div class='col-xs-12 col-md-6'>"
							+  "<p class='lead'>" + this.costformat + "원</p>"
							+  "</div>"
							+  "<div class='col-xs-12 col-md-6'>"
							+  "<a class='btn btn-success'" + "href=''>" + "장바구니 담기" + "</a>"
							+  "</div>"
							+  "</div>"
							+  "</div>"
							+  "</div>"
							+  "</div>";
					} else {
						if (this.goods_image == this.fileName) {
							str += "<div class='item col-xs-4 col-lg-6 col-xl-4'>"
								+  "<div class='thumbnail'>"
								+  "<a href=" + "'/product/productdetail?goods_num=" + this.goods_num + "'>"
								+  "<img class='group list-group-image' src=" + "'" + "/resources/fileUpload/" + this.uploadpath + "/" + this.uuid + "_" + this.goods_image + "'"
								+  "style='width: 350px; height: 250px;'>"
								+  "</a>"
								+  "<div class='caption'>"
								+  "<h4 class='group inner list-group-item-heading'>" + this.goods_name + "</h4>"
								+  "<p class='group inner list-group-item-text'>" + this.goods_contents + "</p>"
								+  "<div class='row'>"
								+  "<div class='col-xs-12 col-md-6'>"
								+  "<p class='lead'>" + this.costformat + "원</p>"
								+  "</div>"
								+  "<div class='col-xs-12 col-md-6'>"
								+  "<a class='btn btn-success'" + "href=''>" + "장바구니 담기" + "</a>"
								+  "</div>"
								+  "</div>"
								+  "</div>"
								+  "</div>"
								+  "</div>";
						}
					}
				});
				$("#products").append(str);
			},
			error: function(error) {
				alert("data error");
			}
			
		});
	});
	
});
</script>


<%@ include file="./footer.jsp" %>