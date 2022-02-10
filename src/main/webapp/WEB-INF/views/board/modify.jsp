<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="https://malsup.github.io/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/css/service.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<style>

a{
	color: #fff;
}
a:hover{
	color: gray;
	text-decoration: none;
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
   align-content: center;
   text-align: center;
}

.uploadResult ul li img {
   width: 100px;
}

.uploadResult ul li span {
   color: white;
}

.bigPictureWrapper {
   position: absolute;
   display: none;
   justify-content: center;
   align-items: center;
   top: 0%;
   width: 100%;
   height: 100%;
   background-color: gray;
   z-index: 100;
   background: rgba(255,255,255,0.5);
}

.bigPicture {
   position: relative;
   display: flex;
   justify-content: center;
   align-items: center;
}

.bigPicture img {
   width: 600px;
}
</style>

<div class="container">
	<div class="row">
	  <div class="col-lg-12">
	    <div class="panel panel-default">
	
	      <!-- /.panel-heading -->
	      <div class="panel-body">
	
	        <form role="form" action="/board/edit?member_id=${member_id}" method="post" enctype="multipart/form-data" onsubmit="return edit();">
	          <div class="form-group">
	            <label>글 번호</label>
	            <input class="form-control" name="notice_num" value="${read.notice_num}" readonly="readonly">
	          </div>
	          
	          <div class="form-group">
	            <label>글 제목</label> 
	            <input class="form-control" maxlength="20" name="notice_title" value="${read.notice_title}">
	          </div>
	
	          <div class="form-group">
	            <label>글 내용</label>
	            <textarea class="form-control" rows="3" name="notice_contents" maxlength="200">${read.notice_contents}</textarea>
	          </div>
	
	          <div class="form-group">
	            <label>작성자</label> <input class="form-control" name="member_id" value="${read.member_id}" readonly="readonly">
	          </div>
	          <input type="hidden" name="sort" value="${read.sort}">
	          <div class="imgedit"></div>
				<input type="submit" class="btn btn-default" value="글 수정하기">
				
	          	<!-- 글 이미지 등록 -->
				<div class="row" style="margin-top: 10px;">
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

<script>

function edit() {
	var title = $("input[name=notice_title]").val();
	var contents = $("textarea[name=notice_contents]").val();
	
	if (title == null || title == "") {
		alert("제목을 작성해주세요");
		return false;
	} else if (contents == null || contents == "") {
		alert("내용을 작성해주세요");
		return false;
	} else {
		var str = "";
	    
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		    
			console.dir(jobj);
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		});
		console.log(str);
		$(".imgedit").append(str);
		return true;
	}
};


$(document).ready(function() {
	
/* 	var formObj = $("form");
	$("button").on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		
		if (operation === 'modify') {
			
			var title = $("input[name=notice_title]").val();
			var contents = $("textarea[name=notice_contents]").val();
			alert("title: " + title + ", contents: " + contents);
			
			if (title == null && title == "") {
				alert("제목을 작성해주세요");
				return false;
			} else if (contents == null && contents == "") {
				alert("내용을 작성해주세요");
				return false;
			} else {
				var str = "";
			    
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
				    
					console.dir(jobj);
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
				});
				console.log(str);
				formObj.append(str);
				formObj.submit();
			}
		}
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
	}
	
	$("input[type='file']").change(function(e){

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
	
		var bno = "<c:out value='${read.notice_num}'/>";
		
		$.getJSON("/board/getAttachList", {bno : bno}, function(arr) {
			console.log(arr);
			
			var str = "";
			$(arr).each(function(i, attach) {
				//image type
				if (attach.filetype) {
						var fileCallPath = encodeURIComponent(attach.uploadpath+ "/s_" + attach.uuid + "_" + attach.fileName);
						str += "<li data-path='" + attach.uploadpath + "'";
						str +=" data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype + "'"
						str +" ><div>";
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' "
						str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str +"</li>";
					} else {
						var fileCallPath = encodeURIComponent(attach.uploadpath + "/" + attach.uuid + "_" + attach.fileName);			      
					    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						      
						str += "<li "
						str += "data-path='" + attach.uploadpath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.filetype + "' ><div>";
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str +"</li>";
					}
			});
			
			
			$(".uploadResult ul").html(str);
		});
	
	$(".uploadResult").on("click", "button", function(e) {
	    
		console.log("delete file");
		
		if (confirm("사진을 삭제하시겠습니까?")) {
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	
});
</script>
