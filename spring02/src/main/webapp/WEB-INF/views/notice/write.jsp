<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/js/commons.js"></script>
<!-- ckeditor의 라이브러리 -->
<script src="${path}/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function(){
	
	$("#btnSave").click(function(){
		var str="";
		var str2="";
		var title=$("#title").val();
		var content=$("#content").val();
		var notice=$("#notice").val();
		
		if(!$("#notice").is(":checked")) {
			alert("체크박스를 확인하세요!");
			document.form1.notice.focus();
			return;
		}
		
		if(title=="") {
			alert("제목을 입력하세요.");
			document.form1.title.focus();
			return;
		}
		/* if(content==""){
			alert("내용을 입력하세요.");
			document.form1.content.focus();
			return;
		} */

		// uploadedList 내부의 .file 태그 각각 반복
		$("#uploadedList .file").each(function(i){
			console.log(i);
			/* var Name = $(this).val();
			var fdir = Name.lastIndexOf("_");
			var index = Name.lastIndexOf("-");
			var fullName = Name.substring(fdir+1, index); */
			
			//hidden 태그 구성
			str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
		});
		
		$("#uploadedList .file2").each(function(j) {
			console.log(j);
			str2 += "<input type='hidden' name='fileSize["+j+"]' value='"+$(this).val()+"'>";
		});
		
		//폼에 hidden 태그들을 붙임
		$("#form1").append(str, str2);
		document.form1.submit();
	});
	
	//드래그 기본 효과를 막음
	$(".fileDrop").on("dragenter dragover", function(e){
		e.preventDefault();
	});
	$(".fileDrop").on("drop",function(e){
		//drop이 될 때 기본 효과를 막음
		e.preventDefault();
		//첨부파일 배열
		var files=e.originalEvent.dataTransfer.files;
		var file=files[0]; //첫번째 첨부파일
		var formData=new FormData(); //폼 객체
		formData.append("file",file); //폼에 file 변수 추가

		//서버에 파일 업로드(백그라운드에서 실행됨)
		// contentType: false => multipart/form-data로 처리됨
		$.ajax({
			type: "post",
			url: "/upload/uploadAjax",
			data: formData,
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(data){
				console.log("data:"+data); //업로드된 파일 이름
				console.log(data.fullName);
				var files = decodeURIComponent(data.fullName);
				console.log(files);
				//data : 업로드한 파일 정보와 Http 상태 코드
				var fileInfo=getFileInfo(data.fullName);
				var fileName=fileInfo.fileName;
				var fullName=fileInfo.fullName;
				var fileSize=data.fileSize;
				
				//console.log(fileInfo);
				var html="<div><a href='"+fileInfo.getLink+"'>"
						+fileName+"</a>&nbsp;&nbsp;";
	
				html+="<a href='#' class='fileDel' data-src='"
					+data+"'>[삭제]</a>&nbsp;&nbsp;";
				
				html+="파일용량 : "+fileSize+"(byte)";
				
				html += "<input type='hidden' class='file' value='"
					+fullName+"'>";
				
				html += "<input type='hidden' class='file2' value='"
					+fileSize+"'></div>";
				
				alert("업로드 Success!!");
				$("#uploadedList").append(html);
				
			},
			error: function(data) {
				alert("실패");
			}
		});
	}); //fileDrop 함수
	
	$('#fileUp').on("click", function() {
		var form = new FormData(document.getElementById('uploadForm'));
		console.log("uploadForm:"+form);

		//서버에 파일 업로드(백그라운드에서 실행됨)
		// contentType: false => multipart/form-data로 처리됨
		$.ajax({
			type: "post",
			url: "/upload/uploadAjax",
			data: form,
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(data){
				console.log("data:"+data); //업로드된 파일 이름
				
				//console.log(data);
				//data : 업로드한 파일 정보와 Http 상태 코드
				var fileInfo=getFileInfo(data.fullName);
				var fileName=fileInfo.fileName;
				var fullName=fileInfo.fullName;
				var fileSize=data.fileSize;
				
				//console.log(fileInfo);
				var html="<div><a href='"+fileInfo.getLink+"'>"
						+fileName+"</a>&nbsp;&nbsp;";
	
				html+="<a href='#' class='fileDel' data-src='"
					+data+"'>[삭제]</a>&nbsp;&nbsp;";
				
				html+="파일용량 : "+fileSize+"(byte)";
				
				html += "<input type='hidden' class='file' value='"
					+fullName+"'>";
				
				html += "<input type='hidden' class='file2' value='"
					+fileSize+"'></div>";
				alert("업로드 Success!!");
				$("#uploadedList").append(html);
				
			},
			error: function(data) {
				alert("실패");
			}
		});
	});

	 //첨부파일 삭제 함수
	$("#uploadedList").on("click", ".fileDel", function(e){
		//현재 클릭한 태그
		var that=$(this);
//data: "fileName="+$(this).attr("data-src"),		
		$.ajax({
			url: "/upload/deleteFile",
			type: "post",
			data: {
				fileName: $(this).attr("data-src")
			},
			dataType: "text",
			success: function(result){
				if(confirm('해당 파일을 삭제 하시겠습니까?')){
					if(result=="deleted") {
						that.parent("div").remove();
					}
				} else {
					
				}
			}
		});
	});
	 
});

//-------------------------------------------------------	

</script>




</head>

<style>
.fileDrop {
	width: 60%;
	height: 100%;
	border: 1px dotted gray;
	background-color: white;
}
</style>

<body>
<%@ include file="../include/menu.jsp" %>

<div class="container" style="width:100%; overflow: scroll;">
<h2 class="text-center">글쓰기</h2><br><br>
<form id="form1" name="form1" method="post"
action="/notice/insert.do" enctype="multipart/form-data">
	<div>
	
	<table border="1" class="table table-hover">
		<tr>
			<td>
				제목
			</td>
			<td>
				<input name="title" id="title" size="60"
					placeholder="제목을 입력하세요">
			</td>
		</tr>
		
		<tr>
			<td>
				체크
			</td>
			<td>
				<input type="checkbox" name="notice" id="notice">공지글로 등록
			</td>
		</tr>
		
		<tr>
			<td>
				내용  
			</td>
			<td>
				<textarea id="content" name="content"
				rows="3" cols="80" placeholder="내용을 입력하세요"></textarea>
				<script>
					// ckeditor 적용
					CKEDITOR.replace("content",{
						filebrowserUploadUrl: "/imageUpload.do"
					});
				</script>
			</td>
		</tr>
	</table>
	
	</div>

	<div style="width:700px; text-align:center;" class="container">
		<button type="button" id="btnSave"  class="btn btn-default btn-primary">확인</button>
	</div>
</form>
<br><hr><br>
	<div class="container" align="center">
		<form id="uploadForm" enctype="multipart/form-data" method="post"
		action="/upload/uploadAjax">
			<input type="file" name="file" class="btn btn-default btn-info">
		</form>
		<button id="fileUp" class="btn btn-default btn-primary">업로드</button>
		
		<div class="fileDrop">
			<div align="center">
				<div align="center" style="font-style: normal; color: gray; "><img src="/images/upload.png"> 마우스로 파일을 끌어오세요.</div>
			</div>
			<div id="uploadedList" class="container" align="left"></div>
		</div>
	</div>

	<br>	<br>	<br>	<br>
</div>
</body>
</html>



















