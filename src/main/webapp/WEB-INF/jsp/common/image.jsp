<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Daum에디터 - 이미지 첨부</title> 
<script src="../resources/daumeditor/js/popup.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../resources/daumeditor/css/popup.css" type="text/css"  charset="utf-8"/>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../resources/daumeditor/js/trex/jquery.form.js"></script>
<script type="text/javascript">
// <![CDATA[
	$(function() {
        $("#saveBtn").click(function() {
            $("#frm").submit();
        });
        
        //ajax form submit
        $('#frm').ajaxForm({
            beforeSubmit: function (data, form, option) {
            	//validation체크 
                //막기위해서는 return false를 잡아주면됨
                return true;
            },
            success: function(response, status) {
            	//성공후 서버에서 받은 데이터 처리
                done(response);
            },
            error: function() {
                //에러발생을 위한 code페이지
                alert("error!!");
            }                               
        });
    });
    
    function done(response) {
        if (typeof(execAttach) == 'undefined') { //Virtual Function
            return;
        }
        
        var url = location.protocol + "//" + location.host + "/purple/";
        
        var _mockdata = {
	        'filename': response.map.filename,
	        'filesize': response.map.filesize,
 	        'imageurl': url + response.map.imageurl,	        
	        'imagealign': response.map.imagealign,
	        'originalurl': url + response.map.imageurl,
	        'thumburl': url + response.map.imageurl
       	};

        execAttach(_mockdata);
        closeWindow();
    }
 
    function initUploader() {
        var _opener = PopupUtil.getOpener();
        if (!_opener) {
            alert('잘못된 경로로 접근하셨습니다.');
            return;
        }
         
        var _attacher = getAttacher('image', _opener);
        registerAction(_attacher);
    }
// ]]>
</script>
</head>
<body onload="initUploader();">
<div class="wrapper">
    <div class="header">
        <h1>사진 첨부</h1>
    </div>    
    <div class="body">
        <dl class="alert">
            <dt>사진 첨부 확인</dt>
            <dd>
            <form id="frm" action="/purple/common/uploadImage" method="post" enctype="multipart/form-data">
                <input type="file" name="file"/>
            </form>
            </dd>
        </dl>
    </div>
    <div class="footer">
        <ul>
            <li class="submit"><a href="#" id="saveBtn" title="등록" class="btnlink">등록</a> </li>
            <li class="cancel"><a href="#" onclick="closeWindow();" title="취소" class="btnlink">취소</a></li>
        </ul>
    </div>
</div>
</body>
</html>