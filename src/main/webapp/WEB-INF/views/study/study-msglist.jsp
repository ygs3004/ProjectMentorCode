<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<%--<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>--%>
<style>
    .formHeader{width: 70%; margin: 4% auto 4% auto; display: block; text-align: center;}
    #formTitle{font-size: 40px; font-weight: bold;}
</style>
<script>

    const apply = {
        applyNum:null,
        applyMentorId:null,
        applyMsg:null
    };

    const approvePage = {
        page: 1,
        pageSize: 5
    };

    const refusePage = {
        page: 1,
        pageSize: 5
    };

    $(document).ready(function()  {
        getlist();
        // refuseList();
    });


    function getlist() {
        $.ajax({
            url: "/apply/getmsglist",
            type: "get",
            accept: "application/json",
            success: function(res) {
                let html = '';
                if(res.list.length == 0){
                    html += '<table style="text-align: center; margin: auto;">'+
                        '<tr><td>보낸 메세지가 없습니다.</td></tr>'+
                        '</table>';
                }else{
                    for(const msg of res.list) {
                        html += '<li class="list-group-item"><span data-bs-toggle="modal" data-bs-target="#msglist'+msg.applyMentorId+'">' +
                            msg.studyTitle +' ('+msg.applyMentorId+')'+
                            '</span></li>';
                        html+='<div class="modal fade" id="msglist'+msg.applyMentorId+'" tabindex="-1" aria-labelledby="msglist'+msg.applyMentorId+'Label" aria-hidden="true">'+
                            '<div class="modal-dialog">'+
                            '<div class="modal-content">'+
                            '<div class="modal-header">'+
                            '<h1 class="modal-title fs-5" id="msglist'+msg.applyMentorId+'Label">'+msg.studyTitle+' ('+msg.applyMentorId+') </h1>'+
                            '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'+
                            '</div> <div class="modal-body"><textarea id="'+msg.applyNum+msg.applyMentorId+'msg" class="form-control" cols="100" rows="3" style="resize: none; background-color: #ffffff">'+ msg.applyMsg +'</textarea></div>'+
                            '<div class="modal-footer">'+
                            '<input type="button" class="btn btn-primary" style="margin:3px" value="수정" onclick="modify('+msg.applyNum+','+`'`+msg.applyMentorId+`'`+')">'+
                            '<input type="button" class="btn btn-danger" style="margin:3px" value="전송취소" onclick="deletemsg('+msg.applyNum+')">'+
                            '</div></div></div></div>';

                    }
                }
                $('#sendlist').html(html);
                },
            error: function(errorThrown) {
                alert(errorThrown.statusText);
            }
            })
    }
    //
    // function refuseMsgList(){
    //     $.ajax({
    //             url: "/apply/getrefuseMsgList",
    //             type: "get",
    //             data : refusePage,
    //             accept: "application/json",
    //             success: function(refuselist) {
    //                 const refuse = refuselist.list;
    //                 let html = '';
    //                 if(refuse.length==0){
    //                     html += '<table style="text-align: center; margin: auto;">'+
    //                         '<tr><td>가입 거절된 멘티가 없습니다.</td></tr>'+
    //                         '</table>';
    //                 }else {
    //                     for (const mentee of refuse) {
    //                         html += '<li class="list-group-item"><span data-bs-toggle="modal" data-bs-target="#approve' + mentee.applyMenteeId + '">' +
    //                             mentee.applyMenteeId +
    //                             '</span></li>';
    //
    //                         html += '<div class="modal fade" id="approve' + mentee.applyMenteeId + '" tabindex="-1" aria-labelledby="approve' + mentee.applyMenteeId + 'Label" aria-hidden="true">' +
    //                             '<div class="modal-dialog">' +
    //                             '<div class="modal-content">' +
    //                             '<div class="modal-header">' +
    //                             '<h1 class="modal-title fs-5" id="approve' + mentee.applyMenteeId + 'Label">' + mentee.applyMenteeId + '</h1>' +
    //                             '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
    //                             '</div> <div class="modal-body">' + mentee.applyMsg + '</div>' +
    //                             '<div class="modal-footer">' +
    //                             '<input type="button" class="btn btn-primary" value="재승인" style="margin:3px" onclick="refuseToApprove(' + mentee.applyNum + ',' + `'` + mentee.applyMenteeId + `'` + ')">' +
    //                             '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>' +
    //                             '</div></div></div></div>';
    //                     }
    //                 }
    //                 $('#refuseList').html(html);
    //
    //             },
    //             error: function(errorThrown) {
    //                 alert(errorThrown.statusText);
    //             }})
    // }
    //

    function modify(num, mentorid){
        apply.applyNum = num;
        apply.applyMsg = $('#'+num+mentorid+'msg').val();
        if (confirm( "스터디 가입 요청 메세지를 수정하시겠습니까?") == true){//확인
            $.ajax({
                url: "/apply/modifyMsg",
                type: 'POST',
                data : JSON.stringify(apply),
                accept: "application/json",
                contentType:'application/json',
                success: function(res) {
                    if(res ==1){
                        alert('메세지가 수정되었습니다.');
                        window.location.reload();
                    }
                }
            })
            } else{   //취소
            return false;
        }
    }

    function deletemsg(num) {
        apply.applyNum = num;
        if (confirm("보낸 메세지를 취소하시겠습니까?") == true) {
            $.ajax({
                url: "/apply/deleteMsg",
                type: 'POST',
                data: JSON.stringify(apply),
                contentType: 'application/json',
                accept: "application/json",
                success: function (res) {
                    if (res == 1) {
                        alert('보낸 메세지가 삭제되였습니다.');
                        window.location.reload();
                    }
                }
            })
        } else {   //취소
            return false;
        }
    }


</script>
<div id="applyform" style="width: 800px; display:block; margin: 5vh auto 5vh auto; align:center;">

<section class="formHeader">
    <span id="formTitle"><b>보낸 메세지 목록</b></span>
    <p id="formDes">스터디 가입 요청 메세지 목록입니다.</p>
</section>
<div class="shadow p-3 mb-5 bg-white rounded">
    <div class="user_name">
        <span style="font-weight: bold; margin-left: 2%;">${loginUser.getUserName()} 님 (${loginUser.getUserId()})</span>
    </div>

    <div class="accordion " id="accordionExample" style="margin-bottom: 3%; margin-top: 3%;">
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingOne">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    가입 요청중인 목록
                </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body" >
                        <ul class="list-group list-group-flush" id="sendlist">




                        </ul>

<%--                        <nav aria-label="approvePage" style="text-align: center; display: block; margin: 2% auto 3% auto;">--%>
<%--                            <ul class="pagination">--%>
<%--                                <li class="page-item">--%>
<%--                                    <a class="page-link" href="#" aria-label="Previous">--%>
<%--                                        <span aria-hidden="true">&laquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                                <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
<%--                                <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
<%--                                <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
<%--                                <li class="page-item">--%>
<%--                                    <a class="page-link" href="#" aria-label="Next">--%>
<%--                                        <span aria-hidden="true">&raquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </ul>--%>
<%--                        </nav>--%>
                    </div>
                </div>


            </div>
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingTwo">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                    가입 거절된 스터디 목록
                </button>
            </h2>


            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                <div class="accordion-body" >
                    <ul class="list-group list-group-flush" id="refuseList">



                        </ul>

<%--                        <nav aria-label="refusePage" style="text-align: center; display: block; margin: 2% auto 3% auto;">--%>
<%--                            <ul class="pagination">--%>
<%--                                <li class="page-item">--%>
<%--                                    <a class="page-link" href="#" aria-label="Previous">--%>
<%--                                        <span aria-hidden="true">&laquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                                <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
<%--                                <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
<%--                                <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
<%--                                <li class="page-item">--%>
<%--                                    <a class="page-link" href="#" aria-label="Next">--%>
<%--                                        <span aria-hidden="true">&raquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </ul>--%>
<%--                        </nav>--%>
                </div>
            </div>
        </div>
        </div>
    </div>

<%--    <div id="sendlist">--%>


<%--    </div>--%>
</div>

<%@ include file="../includes/footer.jsp"%>
