<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script> -->
<link rel="stylesheet" href="/resources/css/service.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<script type="text/javascript">
function notice() {
	/* e.preventDefault(); */
	console.log("submit clicked");
	var str1 = "";
	var title = $("input[name=notice_title5]").val();
	var content = $("textarea[name=notice_contents5]").val();
	if (title == null || title == "") {
		alert("제목을 입력해주세요");
		return false;
	} else if (content == null || content == "") {
		alert("내용을 입력해주세요");
		return false;
	} else {
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		    
			console.dir(jobj);
			console.log("-------------------------");
			console.log(jobj.data("filename"));
	
	 		str1 += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str1 += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str1 += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
			str1 += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		});
		console.log(str1);
		$(".insert").append(str1);
		return true;
	}
}
$(document).ready(function(){
	var rank = "${sessionScope.loginUser.member_rank}";
	if (rank != 3) {
		$("#notice").hide();
	} else {
		$("#notice").show();
	}
	
 	$('ul.tabs li').on("click" , function(){
		var tab_id = $(this).attr('data-tab');
		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');
		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	});
 	
 	if ("${tab}" == 2) {
		$("#index1").removeClass('current');
		$('#tab-1').removeClass('current');
		$("#index2").addClass("current");
		$("#tab-2").addClass("current");
	} else if ("${tab}" == 3) {
		$("#index1").removeClass('current');
		$('#tab-1').removeClass('current');
		$("#index3").addClass("current");
		$("#tab-3").addClass("current");
	} else if ("${tab}" == 4) {
		$("#index1").removeClass('current');
		$('#tab-1').removeClass('current');
		$("#index4").addClass("current");
		$("#tab-4").addClass("current");
	}
});

$(document).on("click","#notice_title", function() {
	    if ($(this).hasClass('on')) {
	        slideUp();
	    } else {
	        slideUp();
	        $(this).addClass('on').next().slideDown();
	    }
	    function slideUp() {
	        $('dt').removeClass('on').next().slideUp();
	    };
});
$(document).on("click","#faq_title", function() {
	    if ($(this).hasClass('on')) {
	        slideUp();
	    } else {
	        slideUp();
	        $(this).addClass('on').next().slideDown();
	    }
	    function slideUp() {
	        $('dt').removeClass('on').next().slideUp();
	    };
});

$(document).ready(function() {
	
		  
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
		  
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		    
		if(regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	};
	
	$("input[id='detail']").change(function(e){

		var formData = new FormData();
		    
		var inputFile = $("input[name='uploadFile']");
		    
		var files = inputFile[0].files;
		    
		for(var i = 0; i < files.length; i++){

			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		    
		$.ajax({
			url: "${contextPath}/uploadAjaxAction",
			processData: false, 
			contentType: false,data: 
			formData,type: "POST",
			dataType:"json",
			success: function(result){
				console.log(result); 
				showUploadResult(result); 
			}
		}); //$.ajax
	});  
	//파일 업로르된 결과를 화면에 섬네일 등 만들어서 처리 함수
	function showUploadResult(uploadResultArr) {
		    
	    if(!uploadResultArr || uploadResultArr.length == 0) {
	    	return;
	    }
		    
	    var uploadUL = $(".uploadResult ul");
	    var str ="";
		    
	    $(uploadResultArr).each(function(i, obj) {
			if(obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<li data-path='" + obj.uploadPath + "'";
				str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'"
				str +" ><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='${contextPath}/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str +"</li>";
			} else {
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);			      
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				      
				str += "<li "
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='${contextPath}/resources/img/attach.png'></a>";
				str += "</div>";
				str +"</li>";
			}
		});
		    
		uploadUL.append(str);
	}

	$(".uploadResult").on("click", "button", function(e) {
		    
		console.log("delete file");
		      
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		    
		$.ajax({
			url: "${contextPath}/deleteFile",
			data: {fileName: targetFile, type:type},
			dataType:"text",
			type: "POST",
			success: function(result){
				alert(result);
		           
				targetLi.remove();
			}
		}); //$.ajax
	});

});


function dele1(obj) {
	var notice_id = $("input[name=notice_id]").val();
	if (notice_id == "${member_id}") {
		if (confirm("글을 삭제하시겠습니까?")) {
			obj.action = "/board/delete?member_id=${member_id}";
			obj.submit();
		}
	} else {
		alert("글 작성자가 아닙니다.");
	}
};
function dele2(obj) {
	var notice_id = $("input[name=faq_id]").val();
	if (notice_id == "${member_id}") {
		if (confirm("글을 삭제하시겠습니까?")) {
			obj.action = "/board/deletefaq?member_id=${member_id}";
			obj.submit();
		}
	} else {
		alert("글 작성자가 아닙니다.");
	}
};

function modify1(obj) {
	var notice_id = $("input[name=notice_id]").val();
	if (notice_id == "${member_id}") {
			obj.action = "/board/modify?member_id=${member_id}";
			obj.submit();
	} else {
		alert("글 작성자가 아닙니다.");
	}
};

function modify2(obj) {
	var notice_id = $("input[name=faq_id]").val();
	if (notice_id == "${member_id}") {
			obj.action = "/board/modify?member_id=${member_id}";
			obj.submit();
	} else {
		alert("글 작성자가 아닙니다.");
	}
};

function search(obj) {
	var service = $("#service").val();
	var tab1 = $("#tab-1").attr("class");
	var tab2 = $("#tab-2").attr("class");
	var tab3 = $("#tab-3").attr("class");
	var tab4 = $("#tab-4").attr("class");
	var equals = "tab-content current";
	if (service == "service") {
		if (tab1 == equals) {
			obj.action = "/board/service?member_id=${member_id}&tab=1";
			obj.submit();
			return true;
		}
	}
		return false;
}

$(function() {
	var rank = $("input[type=button]").data("rank");
	var member_rank = "${sessionScope.loginUser.member_rank}";
	if (rank != member_rank) {
		$(".crudbtn").hide();
		$(".crudbtn_faq").hide();
	} else {
		$(".crudbtn").show();
		$(".crudbtn_faq").show();
	}
});
</script>
<style type="text/css">
a{
	color: #fff;
}
a:hover{
	color: gray;
	text-decoration: none;
}
.accordion-toggle:hover{
	color: black;
}
.panel-heading .accordion-toggle:after {
    font-family: 'Glyphicons Halflings';
    content: "\e114"; /* adjust as needed, taken from bootstrap.css */
    float: right;
    color: grey;
}
.panel-heading .accordion-toggle.collapsed:after {
    content: "\e080"; /* adjust as needed, taken from bootstrap.css */
}


.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}

.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicutre img {
	width: 600px;
}

* { margin: 0; padding: 0; }
dl { }
dt, dd { padding: 15px; }
dt { background-color: #f5f5f5; margin-bottom: 5px; font-size: 20px;}
dt span { display: inline-block; width: 10px; height: 5px; background-color: #f5f5f5;
    vertical-align: middle; margin-right: 10px; }
dt.on span { background-color: red; }
dd { background-color: #fff; margin-bottom: 5px; display: none; }
img {
	width: 30%;
}
#edit{
width: 100px;
height: 30px;
border: 1px solid gray;
margin: 3px;
}
#dele{
width: 100px;
height: 30px;
border: 1px solid gray;
margin: 3px;
}
#addBtn{
color: #0089ff;
text-align: center;
padding: 5px;
font-size: 20px;
text-decoration: none;
}
</style>
	<div class="service">
		<input type="hidden" value="service" id="service">
		<input type="hidden" value="${scrollq}" id="scrollq">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1" id="index1"><a style="color: black;" href="#">공지사항</a></li>
			<li class="tab-link" data-tab="tab-2" id="index2"><a style="color: black;" href="#" id="asd">FAQ</a></li>
			<li class="tab-link" data-tab="tab-3" id="index3"><a style="color: black;" href="#">질문하기</a></li>
			<li class="tab-link" data-tab="tab-4" id="index4"><a style="color: black;" href="#">문의내역</a></li>
			<li class="tab-link" data-tab="tab-5" style="float: right;" id="notice">공지글쓰기</li>
		</ul>
	
		<div id="tab-1" class="tab-content current">
			<div class = "container">
					<div class="panel-group" id="accordion1" >
						<c:choose>
							<c:when test="${empty noticeview}">
								<dt>등록된 글이 없습니다.</dt>
								<dd>등록된 글이 없습니다.</dd>
							</c:when>
		 					<c:otherwise>
								<c:forEach items="${noticeview}" var="noticeview">
									<form action="#" name="frm" method="post">
										<dt id="notice_title">${noticeview.notice_title}</dt>
										<dd>${noticeview.notice_contents} <br>
											<c:forEach items="${noticeList}" var="noticeList">
											<c:set value="${noticeList.bno}" var="bno"></c:set>
												<c:if test="${noticeview.notice_num eq bno}">
													<img alt="첨부 이미지" src="${contextPath}/resources/fileUpload/${noticeList.uploadpath}/${noticeList.uuid}_${noticeList.fileName}">
													<input type="hidden" name="bno" value="${noticeList.bno}">
												</c:if>
											</c:forEach>
										<span style="float: right;"><fmt:formatDate value="${noticeview.notice_date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										<div class="crudbtn">
										<input type="button" value="수정하기" id="edit" onclick="modify1(this.form)" data-rank="3">
										<input type="button" id="dele" value="삭제하기" onclick="dele1(this.form);">
										</div>
										</dd>
										<input type="hidden" name="notice_num" value="${noticeview.notice_num}">
										<input type="hidden" name="notice_id" value="${noticeview.member_id}">
									</form>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
			</div>
		</div>
		<div id="tab-2" class="tab-content">
			<div class = "container">
				<div class="panel-group" id="accordion2">
						<c:choose>
							<c:when test="${empty faqview}">
								<dt>등록된 글이 없습니다.</dt>
								<dd>등록된 글이 없습니다.</dd>
							</c:when>
		 					<c:otherwise>
								<c:forEach items="${faqview}" var="faqview">
									<form action="#" name="frmfaq" method="post">
										<dt id="faq_title">${faqview.notice_title}</dt>
										<dd>${faqview.notice_contents} <br>
											<c:forEach items="${faqList}" var="faqList">
											<c:set value="${faqList.bno}" var="bno"></c:set>
												<c:if test="${faqview.notice_num eq bno}">
													<img alt="첨부 이미지" src="${contextPath}/resources/fileUpload/${faqList.uploadpath}/${faqList.uuid}_${faqList.fileName}">
													<input type="hidden" name="bno" value="${faqList.bno}">
												</c:if>
											</c:forEach>
										<span style="float: right;"><fmt:formatDate value="${faqview.notice_date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										<div class="crudbtn_faq">
										<input type="button" value="수정하기" id="edit" onclick="modify2(this.form)" data-rank="3">
										<input type="button" id="dele" value="삭제하기" onclick="dele2(this.form);">
										</div>
										</dd>
										<input type="hidden" name="notice_num" value="${faqview.notice_num}">
										<input type="hidden" name="faq_id" value="${faqview.member_id}">
									</form>
								</c:forEach>
							</c:otherwise>
						</c:choose>
				</div>
			</div>
		</div>
		<div id="tab-3" class="tab-content">
			<div class = "container">
				<div class="row">
				  <div class="col-lg-12">
				    <div class="panel panel-default">
			
				      <!-- /.panel-heading -->
				      <div class="panel-body">
				
				        <form action="#" method="post" enctype="multipart/form-data">
				          <div class="form-group">
							<span>주문내역 선택</span>
							<select name="sort" class="opsel" style="padding: 3px;">
					        	<option value="1" style="color: black;">결제하고</option>
					        	<option value="2">결제부터</option>
					        </select><br>
				            <label>제목</label>
				            <input class="form-control" maxlength="20" name="notice_title3">
				          </div>
				
				          <div class="form-group">
				            <label>질문 내용</label>
				            <textarea class="form-control" rows="20" name="notice_contents3" maxlength="200" ></textarea>
				          </div>
				
				          <div class="form-group">
				            <label>작성자</label> <input class="form-control" name="member_id" value="${sessionScope.loginUser.member_id}" readonly="readonly">
				          </div>
				          
				          <input type="submit" class="btn btn-default" value="질문 등록">
				          <button type="reset" class="btn btn-default">Reset</button>
				          	<!-- 상품 이미지 등록 -->
							<div class="row" style="margin-top: 5px;">
							  <div class="col-lg-12">
							    <div class="panel panel-default">
							
							      <div class="panel-heading">이미지 첨부</div>
							      <!-- /.panel-heading -->
							      <div class="panel-body">
							        <div class="form-group uploadDiv">
							            <input type="file" name="uploadFile3" multiple>
							        </div>
							        
							        <div class="uploadResult3">
							        	<div class="insert"></div>
							          <ul>
							          
							          </ul>
							        </div>
							      </div>
							      <!--  end panel-body -->
							
							    </div>
							    <!--  end panel-body -->
							  </div>
							  <!-- end panel -->
							</div>
				        </form>
				
				      </div>
				      <!--  end panel-body -->
				
				    </div>
				    <!--  end panel-body -->
				  </div>
				  <!-- end panel -->
				</div>
				<!-- /.row -->
				
			</div>
		</div>
		<div id="tab-4" class="tab-content">
			<dl>
				<dt>제목1<img alt="" src="/resources/images/icon/arrowbot.png" id="arrow" style="width: 10px;height: 10px; float: right;"></dt>
				<dd>내용1</dd>
				<dt>제목2</dt>
				<dd>내용2</dd>
			</dl>
		</div>
		<div id="tab-5" class="tab-content">
			<div class = "container">
				<div class="row">
				  <div class="col-lg-12">
				    <div class="panel panel-default">
			
				      <!-- /.panel-heading -->
				      <div class="panel-body">
				
				        <form action="${contextPath}/board/noticeadd" method="post" enctype="multipart/form-data" onsubmit="return notice();">
				          <div class="form-group">
							<span>카테고리</span>
							<select name="sort" class="opsel" style="padding: 3px;">
					        	<option value="1" style="color: black;">공지사항</option>
					        	<option value="2">FAQ</option>
					        </select><br>
				            <label>
				            	제목
				            </label> <input class="form-control" maxlength="20" name="notice_title5" id="titleinsert">
				          </div>
				
				          <div class="form-group">
				            <label>글 내용</label>
				            <textarea class="form-control" rows="20" name="notice_contents5" maxlength="200" ></textarea>
				          </div>
				
				          <div class="form-group">
				            <label>작성자</label> <input class="form-control" name="member_id" value="${sessionScope.loginUser.member_id}" readonly="readonly">
				          </div>
				          
				          <input type="submit" class="btn btn-default" value="글 등록" name="noticeadd">
				          <button type="reset" class="btn btn-default">Reset</button>
				          	<!-- 상품 이미지 등록 -->
							<div class="row" style="margin-top: 5px;">
							  <div class="col-lg-12">
							    <div class="panel panel-default">
							
							      <div class="panel-heading">글 이미지</div>
							      <!-- /.panel-heading -->
							      <div class="panel-body">
							        <div class="form-group uploadDiv">
							            <input type="file" name="uploadFile" id="detail" multiple>
							        </div>
							        
							        <div class="uploadResult">
							        	<div class="insert"></div>
							          <ul>
							          
							          </ul>
							        </div>
							      </div>
							      <!--  end panel-body -->
							
							    </div>
							    <!--  end panel-body -->
							  </div>
							  <!-- end panel -->
							</div>
				        </form>
				
				      </div>
				      <!--  end panel-body -->
				
				    </div>
				    <!--  end panel-body -->
				  </div>
				  <!-- end panel -->
				</div>
				<!-- /.row -->
				
			</div>
		</div>
	</div>
	
<script>


$(function(){
    var cnt = 0;
    var cntfaq = 0;
	var dtcnt = $("dt[id=notice_title]").length;
	var dtcntfaq = $("dt[id=faq_title]").length;
	var scrollq = $("#scrollq").val();
    $(window).scroll(function(event) {
        var scrolltop = parseInt ( $(window).scrollTop() );
        if( scrolltop >= $(document).height() - $(window).height() - 5 ){
			var tab1 = $("#tab-1").attr("class");
			var tab2 = $("#tab-2").attr("class");
			var tab3 = $("#tab-3").attr("class");
			var tab4 = $("#tab-4").attr("class");
			var equals = "tab-content current";
			if (tab1 == equals) {
	        	cnt++;
				var pageall = Number(cnt*10) + Number(dtcnt);
				var allcnt = Number($("#allcnt").val());
				if (Number(pageall) > Number(allcnt) + 10) {
					
				} else {
			   		$.ajax({
						type : 'post',	// 요청 method 방식 
						url : '/board/scroll',// 요청할 서버의 url
						dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
						data : { // 서버로 보낼 데이터 명시 
							"cnt" : cnt,
							"scrq": scrollq
						},
						success : function(data){// ajax 가 성공했을시에 수행될 function이다.
							var result = "";
							console.log(data);
							if(data != ""){
								$(data.noticeview).each(
									function(){
										var str = "";
										var str1 = "";
										var str2 = "";
										str +=		"<form action=" + "'#'" + "name=" + "'frm'" + "method=" + "'post'" + ">"
										    +	 	"<dt id=" + "'notice_title'" + ">"
											+		this.notice_title
											+		"</dt>"
											+		"<dd>"
											+		this.notice_contents + "<br>";
											if (!jQuery.isEmptyObject(this.attachList)) {
												$(this.attachList).each(function() {
													str1 += "<img src=${contextPath}/resources/fileUpload/" + this.uploadpath + "/" 
														 +  this.uuid + "_" + this.fileName + ">"
														 +  "<input type=" + "'hidden'" + "name=" + "'bno'" + "value=" + "'" + this.bno + "'" + ">";
												});
											}
										str2+=		"<span style='float: right;'>" + this.date + "</span>"
											+		"<div class='crudbtn'>"
											+		"<input type=" + "'button'" + "value=" + "'수정하기'" + "id=" + "'edit'"
											+		"onclick=" + "'modify1(this.form)'" + "data-rank=" + "'3'" + ">"
											+		"<input type=" + "'button'" + "value=" + "'삭제하기'" + "id=" + "'dele'" 
											+		"onclick=" + "'dele1(this.form);'" + ">"
											+		"</div>"
											+		"</dd>"
											+		"<input type=" + "'hidden'" + "value=" + "'" + data.allcnt + "'" + "id=" + "'allcnt'" + ">"
											+		"<input type=" + "'hidden'" + "name=" + "'notice_num'" + "value=" + "'" + this.notice_num + "'" + ">"
											+		"<input type=" + "'hidden'" + "name=" + "'notice_id'" + "value=" + "'" + this.member_id + "'" + ">";
											+		"</form>"
										result += str + str1 + str2;
									});// each
								$("#accordion1").append(result);
							}
						}// success
					});
			   		return true;
				}
			} else if (tab2 == equals) {
	        	cntfaq++;
				var pageall = Number(cntfaq*10) + Number(dtcntfaq);
				var allcntfaq = Number($("#allcntfaq").val());
				if (Number(pageall) > Number(allcntfaq) + 10) {
					
				} else {
			   		$.ajax({
						type : 'post',	// 요청 method 방식 
						url : '/board/scrollfaq',// 요청할 서버의 url
						dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
						data : { // 서버로 보낼 데이터 명시 
							"cntfaq" : cntfaq
						},
						success : function(data){// ajax 가 성공했을시에 수행될 function이다.
							var result = "";
							console.log(data);
							if(data != ""){
								$(data.faqview).each(
									function(){
										var str = "";
										var str1 = "";
										var str2 = "";
										str +=		"<form action=" + "'#'" + "name=" + "'frmfaq'" + "method=" + "'post'" + ">"								    +	 	"<dt id=" + "'faq_title'" + ">"
											+		this.notice_title
											+		"</dt>"
											+		"<dd>"
											+		this.notice_contents + "<br>";
											if (!jQuery.isEmptyObject(this.attachList)) {
												$(this.attachList).each(function() {
													str1 += "<img src=${contextPath}/resources/fileUpload/" + this.uploadpath + "/"
														 +  this.uuid + "_" + this.fileName + ">"
													 	 +  "<input type=" + "'hidden'" + "name=" + "'bno'" + "value=" + "'" + this.bno + "'" + ">";
												});
											}
										str2+=		"<span style='float: right;'>" + this.date + "</span>"
											+		"<div class='crudbtn_faq'>"
											+		"<input type=" + "'button'" + "value=" + "'수정하기'" + "id=" + "'edit'"
											+		"onclick=" + "'modify2(this.form)'" + "data-rank=" + "'3'" + ">"
											+		"<input type=" + "'button'" + "value=" + "'삭제하기'" + "id=" + "'dele'" 
											+		"onclick=" + "'dele2(this.form);'" + ">"
											+		"</div>"
											+		"</dd>"
											+		"<input type=" + "'hidden'" + "value=" + "'" + data.allcntfaq + "'" + "id=" + "'allcntfaq'" + ">"
											+		"<input type=" + "'hidden'" + "name=" + "'notice_num'" + "value=" + "'" + this.notice_num + "'" + ">"
											+		"<input type=" + "'hidden'" + "name=" + "'faq_id'" + "value=" + "'" + this.member_id + "'" + ">"
											+		"</form>";
											result += str + str1 + str2;
									});// each
								$("#accordion2").append(result);
									console.log("result: " + result);
							}
						}// success
					});
			   		return true;
				}
			} else {
		    	event.preventDefault();
		    	event.stopPropagation();
		    	return false;
			}
        }
    });
});


</script>
<%@ include file="../common/footer.jsp" %>