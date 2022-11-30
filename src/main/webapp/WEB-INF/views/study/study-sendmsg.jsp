<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/study/apply-styles.css">
<script>
    $(document).ready(function (){
        var message = '${message}';
        var url = '${url}';
        if(message.trim().length!=0){
        }
        getstudy();
    });

    function getstudy(){
        $.ajax({
            type : 'GET',
            url : '/study/get/${param.studynum}',
            accept : "application/json",
            success : function(res) {
                if(res){
                    $('#studyTitle').val(res.studyTitle);
                    $('#mentorInfo').val(res.studyUserId);
                    alert("이미 전송된 요청메세지가 존재합니다.");
                    history.back();
                }else{
                    $('#studyTitle').val(res.studyTitle);
                    $('#mentorInfo').val(res.studyUserId);
                }
            },
            error: function(errorThrown) {
                alert(errorThrown.statusText);
            }
        })
    }

    function sendMSG(){
        const apply = {};
        apply['applyMentorId'] = $('#mentorInfo').val();
        apply['applyMsg'] = $('#msg').val();

        $.ajax({
            type : 'POST',
            url : '/apply/send-msg',
            accept : "application/json",
            contentType:'application/json',
            data : JSON.stringify(apply),
            success : function(res) {
                if (res == 1) {
                    alert('정상적으로 요청 메세지를 보냈습니다.');
                    location.href='/study/list';
                }
            }
        })
    }

</script>
<section class="formHeader">
    <span id="formTitle"><b>스터디 가입 요청</b></span>
    <p id="formDes">멘토에게 가입 요청 메세지를 보내볼까요</p>
</section>
<div class="shadow p-3 mb-5 bg-white rounded formbody">
<div class="input"> <label for="studyTitle">스터디명</label><br>
    <span class="json" ><input type="text" id="studyTitle" class="form-control" value="" readonly></span>
</div>
<div class="input">
    <label for="mentorInfo">멘토명(id)</label><br>
    <span class="json">
        <input type="text" id="mentorInfo" class="form-control" value="" readonly>
    </span>
</div>
<div class="input">
    <label for="msg"><span class="title">멘토에게 보낼 메세지</span></label>
    <textarea class="form-control" id="msg" name="msg" rows="3" style="resize: none;"></textarea>
</div>
    <div class="input" style="text-align: center; margin-bottom: 2%;">
        <input type="button" class="btn btn-primary" value="보내기" onclick="sendMSG()" > &nbsp;&nbsp;
        <input type="button" class="btn btn-primary" value="뒤로가기" onclick="history.back();">
    </div>
</div>
<%@ include file="../includes/footer.jsp"%>