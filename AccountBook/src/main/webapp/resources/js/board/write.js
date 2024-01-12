$(function() {
	
	// 파일 크기와 확장자 확인
	$.checkExtension = function(fileName, fileSize) {
		var reg = new RegExp("(.*?)\.(jpg|png|jpeg)$"); // 사진만 업로드 가능
		var maxSize = 5242880; // 5MB
		
		if(fileSize >= maxSize) { // 용량 초과 시
			alert("용량이 큰 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		if(!reg.test(fileName)) { // 사진 형식이 아닌 경우
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	// 파일 업로드 보여주기
	$.showUploadFile = function(uploadResultArr) {
		var str = "";
		$(uploadResultArr).each(function(i, obj) {
			if(obj.image) { // 파일이 이미지라면
				var fileCallPath = encodeURIComponent(obj.uploadpath + "\\s_" + obj.uuid + "_" + obj.filename);
				
				str += "<li data-path='" + obj.uploadpath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.filename + "' data-type='" + obj.image + "'>";
				str += "<span>" + obj.filename + "</span><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'>x</button>" +
						"<img id='upload-files' src='display?filename=" + fileCallPath + "'></li>";
			}
		});
		$("#upload-list-div ul").append(str);
	}
	
	// 파일 업로드
	$(document).on("change", "#filename", function() {
		var cloneObj = $("#upload-div").clone();
		
		var formData = new FormData();
		var inputFile = $("#filename");
		var files = inputFile[0].files;
		
		for(var i = 0; i < files.length; i++) {
			if(!$.checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			
			formData.append("filename", files[i]);
		}
		
		$.ajax({
			type : "post",
			url : "uploadFile",
			processData : false,
			contentType : false,
			data : formData,
			dataType : "json",
			success : function(x) {
				$.showUploadFile(x);
				$("#upload-div").html(cloneObj.html());
			}
		})
	})
	
	// 업로드한 파일 삭제
	$("#upload-list-div").on("click", "button", function() {
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		$.ajax({
			type :"post",
			url : "deleteFile",
			data : {
				filename : targetFile,
				type : type
			},
			success : function(x) {
				targetLi.remove();
			}
		})
	})


	// 작성 완료 버튼
	$(document).on("click", "#submit-btn", function() {
		var formObj = $("#insert-board-form");
		var str = "";
		
		$("#upload-list-div ul li").each(function(i, obj) {
			var jobj = $(obj);
			str += "<input type='hidden' name='fileList[" + i + "].filename' value='" + jobj.data("filename") + "'>";
			str += "<input type='hidden' name='fileList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
			str += "<input type='hidden' name='fileList[" + i + "].uploadpath' value='" + jobj.data("path") + "'>";
			str += "<input type='hidden' name='fileList[" + i + "].image' value='" + jobj.data("type") + "'>";
		});
		
		formObj.append(str).submit();
	})
})