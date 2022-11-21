<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script>

    $(document).ready(function()  {
        getlists()
    })

    function getlists() {
        $.ajax({
            url: "/apply/getlist",
            type: "get",
            accept: "application/json",
            success: function(res) {
                let html = '';
                // const applylist = res.list;
                for(const apply of res) {
                    console.log(apply);
                    html+=
                        '<div class="shadow p-3 mb-5 bg-white rounded" id="'+ apply.applyNum +'">'+
                        '<div class="card-body">'+
                        '<table><tr><td style="font-weight: bold">요청멘티 id ( '+ apply.applyMenteeId +' )</td><td></td></tr><tr>'+
                        '<td><textarea class="form-control" cols="100" rows="3" style="resize: none;">'+ apply.applyMsg +'</textarea ></td>'+
                        '<td><input type="button" class="btn btn-primary" value="승인" style="margin:3px" onclick="approve('+apply.applyNum +')"><br>'+
                        '<input type="button" class="btn btn-outline-danger" style="margin:3px" value="거절" onclick="refuse('+apply.applyNum +')">' +
                        '</td></tr></table></div></div>'
                    }
                $('#applyerlist').html(html);
                $('#title').attr("value", res[0].studyTitle);
                }
            })
    }


    function approve(num){
        const data = { applyNum : num };
        $.ajax({
            url: "/apply/approve/",
            type: 'POST',
            data : JSON.stringify(data),
            accept: "application/json",
            contentType:'application/json',
            success: function(res) {
                if(res ==1){
                    alert('승인되었습니다');
                    // $(event.target).remove();
                }
            }
        })
    }

    function refuse(num){
        const data = { applyNum : num };
        $.ajax({
            url: "/apply/refuse",
            type: 'POST',
            data : JSON.stringify(data),
            contentType:'application/json',
            accept: "application/json",
            success: function(res) {
                if(res ==1){
                    alert('거절되었습니다');
                    // $(event.target).remove();
                }
            }
        })
    }

    // function delAct(e) {
    //     const event = e || window.event;
    //     const targetElement = event.target.parentElement;
    //     targetElement.remove();
    // }

</script>
<div id="applyform" style="width: 800px; display:block; margin: 5vh auto 5vh auto; align:center;">

<section class="formHeader">
    <span id="formTitle"><b>스터디 가입 요청 목록</b></span>
    <p id="formDes">스터디에 지원한 멘티들입니다.</p>
</section>
<div class="shadow p-3 mb-5 bg-white rounded">
    <div class="user_name">
        <span style="font-weight: bold"> ${loginUser.getUserName()} 님 (${loginUser.getUserId()})</span>
    </div>
    <div>
        <label for="title"><span>스터디 이름</span></label>
        <input type="text" class="form-control" id="title" name="studyTitle" value="" readonly>
    </div>
</div>
    <div id="applyerlist">

    </div>
</div>
</div>
</div>


<%@ include file="../includes/footer.jsp"%>
