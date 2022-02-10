<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="https://malsup.github.io/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/css/service.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<style>
input{border:none;padding:10px;border-radius:20px}
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
.uploadResult ul li:first-child{
	border: 5px solid darkgray;
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
#addExcelImpoartBtn{
margin-top: 10px;
}
</style>

<script>
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }
};

function insertgoods() {
	var goods_name = $("input[name=goods_name]").val();
	var goods_contents = $("textarea[name=goods_contents]").val();
	var goods_company = $("input[name=goods_company]").val();
	var goods_origin = $("input[name=goods_origin]").val();
	var goods_cost = $("input[name=goods_cost]").val();
	var str = "";
	var strmain = "";
	if (goods_name == "" || goods_name == null) {
		alert("상품명을 입력해주세요");
		return false;
	} else if (goods_contents == "" || goods_contents == null) {
		alert("상품 상세를 입력해주세요");
		return false;
	} else if (goods_company == "" || goods_company == null) {
		alert("제조사를 입력해주세요");
		return false;
	} else if (goods_origin == "" || goods_origin == null) {
		alert("원산지를 입력해주세요");
		return false;
	} else if (goods_cost == "" || goods_cost == null) {
		alert("가격을 입력해주세요");
		return false;
	} else {
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		      
			console.dir(jobj);
			console.log("-------------------------");
			console.log(jobj.data("filename"));
		      
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
			strmain += "<input type='hidden' name='goods_image"+i+"' value='"+ jobj.data("filename")+"'>";
		});
		$(".imghidden").append(str);
		$(".imghidden").append(strmain);
		return true;
	}
};

$(document).ready(function() {
	
/*  	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		    
		console.log("submit clicked");
		var str = "";
		    
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		      
			console.dir(jobj);
			console.log("-------------------------");
			console.log(jobj.data("filename"));
		      
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
			str += "<input type='hidden' name='goods_image' value='"+ jobj.data("filename")+"'>";
		});
		    
		console.log(str);
		formObj.append(str).submit();
	}); */
		  
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

</script>
<script>
function exceldown() {
	location.href="/product/excel?member_id=${sessionScope.loginUser.member_id}";
};
function defaultexceldown() {
	location.href="/product/excel";
};

function checkFileType(filePath) {
    var fileFormat = filePath.split(".");
    if (fileFormat.indexOf("xls") > -1 || fileFormat.indexOf("xlsx") > -1) {
    	return true
    } else {
		return false;
	}
};
function check() {
	var file = $("#excelFile").val();
	if (file == "" || file == null) {
		alert("파일을 선택해주세요.");
		return false;
	} else if (!checkFileType(file)) {
		alert("엑셀 파일만 업로드 가능합니다.");
		return false;
    }

    if (confirm("업로드 하시겠습니까?")) {
		var options = {
			success : function(data) {
            	console.log(data);
				alert("모든 데이터가 업로드 되었습니다.");
        	},
        	error: function(data) {
				alert("aaasd");
			}
        };
			type : "POST"
		$("#excelUploadForm").ajaxSubmit(options);
		return false;
	}
};


</script>
<div class="container">
	<div class="row">
	  <div class="col-lg-12">
	    <div class="panel panel-default">
	
			<!--excel 업로드  -->
			<div class="row">
			  <div class="col-lg-12">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			      	excel 등록
				      <button style="float: right; margin: 1px;" onclick="defaultexceldown();">excel 양식 다운받기</button>
				      <button style="float: right; margin: 1px;" onclick="exceldown();">등록상품 excel로 받기</button>
			      </div>
			      <!-- /.panel-heading -->
			      <div class="panel-body">
			        <div class="form-group uploadDiv">
				      <form action="/product/excelinsert?member_id=${sessionScope.loginUser.member_id}" id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post">
				      	<input type="file" value="excel 등록" id="excelFile" name="excelFile">
				      	<button type="button" id="addExcelImpoartBtn" class="btn btn-default" onclick="check();"><span>excel 등록</span></button>
				      </form>
			        </div>
			      </div>
			      <!--  end panel-body -->
			    </div>
			    <!--  end panel-body -->
			  </div>
			  <!-- end panel -->
			</div>

	      <!-- /.panel-heading -->
	      <div class="panel-body">
	
	        <form  action="${contextPath}/product/insertproduct" method="post" enctype="multipart/form-data" onsubmit="return insertgoods();">
	          <div class="form-group">
				<span>카테고리</span>
				<select name="goods_kind" class="opsel" style="padding: 3px;">
		        	<option value="1" style="color: black;">패션의류</option>
		        	<option value="2">식품</option>
		        	<option value="3">가전디지털</option>
		        	<option value="4">스포츠레저</option>
		        	<option value="5">도서음반</option>
		        	<option value="6">문구오피스</option>
		        	<option value="7">뷰티</option>
		        </select><br>
	            <label>
	            	상품명
	            </label> <input class="form-control" maxlength="20" name="goods_name">
	          </div>
	
	          <div class="form-group">
	            <label>상품 상세</label>
	            <textarea class="form-control" rows="3" name="goods_contents" maxlength="900"></textarea>
	          </div>
	
	          <div class="form-group">
	            <label>제조사</label> <input class="form-control" maxlength="10" name="goods_company">
	          </div>
	          <div class="form-group">
	            <label>원산지</label> <input class="form-control" maxlength="10" name="goods_origin">
	          </div>
	          <div class="form-group">
	            <label>가격</label> <input class="form-control" type="number" name="goods_cost" maxlength="8" oninput="maxLengthCheck(this)">
	          </div>
	          <div class="form-group">
	            <label>작성자</label> <input class="form-control" name="member_id" value="${sessionScope.loginUser.member_id}" readonly="readonly">
	          </div>
	          
	          <div class="imghidden">
	          </div>
	          
	          <button type="submit" class="btn btn-default">상품등록</button>
	          <button type="reset" class="btn btn-default">Reset</button>
	        </form>
	
	      </div>
	      <!--  end panel-body -->
	
	    </div>
	    <!--  end panel-body -->
	  </div>
	  <!-- end panel -->
	</div>
	<!-- /.row -->
	
	<!-- 상품 이미지 등록 -->
	<div class="row">
	  <div class="col-lg-12">
	    <div class="panel panel-default">
	
	      <div class="panel-heading">상세 이미지</div>
	      <!-- /.panel-heading -->
	      <div class="panel-body">
	        <div class="form-group uploadDiv">
	            <input type="file" name="uploadFile" id="detail" multiple>
	        </div>
	        
	        <div class="uploadResult"> 
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
</div>

<%@ include file="../common/footer.jsp" %>