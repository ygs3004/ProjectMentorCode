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
        applyMentorId:null
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
        getStudyinfo();
        getlist();
        approveAndRefuseList();
    });

    function getStudyinfo(){
        $.ajax({
            url: "/study/getstudy",
            type: "get",
            accept: "application/json",
            success: function(studyinfo) {
                $('#title').attr("value", studyinfo.studyTitle);
                $('#capacitybar').attr("aria-valuenow", studyinfo.studyCapacity);
                $('#capacitybar').attr("aria-valuemax", studyinfo.studyNowCapacity);
                $('#capacitybar').attr("style", 'width:'+(studyinfo.studyNowCapacity/studyinfo.studyCapacity)*100+'%');
                $('#capacityrate').html(studyinfo.studyNowCapacity+'/'+studyinfo.studyCapacity);
            }})
    }

    function getlist() {
        $.ajax({
            url: "/apply/getlist",
            type: "get",
            accept: "application/json",
            success: function(res) {
                let html = '';
                if(res[0].applyMentorId == null){
                    html += '<div class="shadow p-3 mb-5 bg-white rounded">'+
                            '<div class="card-body">'+
                            '<table style="text-align: center; margin: auto;">'+
                            '<tr><td>스터디 가입을 요청한 멘티가 없습니다.</td></tr>'+
                            '</table></div></div>';
                }else{
                    for(const apply of res) {
                            html +=
                            '<div class="shadow p-3 mb-5 bg-white rounded" id="'+ apply.applyNum +'">'+
                            '<div class="card-body">'+
                            '<table><tr><td style="font-weight: bold">요청멘티 id ( '+ apply.applyMenteeId +' )</td><td></td></tr><tr>'+
                            '<td><textarea class="form-control" cols="100" rows="3" style="resize: none; background-color: #ffffff" readonly>'+ apply.applyMsg +'</textarea ></td>'+
                            '<td><input type="button" class="btn btn-primary" value="승인" style="margin:3px" onclick="approve('+apply.applyNum+','+`'`+apply.applyMenteeId+`'`+')"><br>'+
                            '<input type="button" class="btn btn-danger" style="margin:3px" value="거절" onclick="refuse('+apply.applyNum+','+`'`+apply.applyMenteeId+`'`+')">' +
                            '</td></tr></table></div></div>';
                    }
                }
                $('#applierlist').html(html);
                },
            error: function(errorThrown) {
                alert(errorThrown.statusText);
            }
            })
    }

    function approveAndRefuseList(){
        $.ajax({
            url: "/apply/getapproveList",
            type: "get",
            data : approvePage,
            accept: "application/json",
            success: function(list) {
                const approve = list.list;
                let html = '';
                if(approve.length==0){
                    html += '<table style="text-align: center; margin: auto;">'+
                        '<tr><td>스터디에 가입된 멘티가 없습니다.</td></tr>'+
                        '</table>';
                }else{
                    for(const mentee of approve) {
                        html += '<li class="list-group-item"><span data-bs-toggle="modal" data-bs-target="#approve'+mentee.applyMenteeId+'">' +
                            mentee.applyMenteeId +
                            '</span></li>';

                        html+='<div class="modal fade" id="approve'+mentee.applyMenteeId+'" tabindex="-1" aria-labelledby="approve'+mentee.applyMenteeId+'Label" aria-hidden="true">'+
                            '<div class="modal-dialog">'+
                            '<div class="modal-content">'+
                            '<div class="modal-header">'+
                            '<h1 class="modal-title fs-5" id="approve'+mentee.applyMenteeId+'Label">'+mentee.applyMenteeId+'</h1>'+
                            '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'+
                            '</div> <div class="modal-body">'+mentee.applyMsg+'</div>'+
                            '<div class="modal-footer">'+
                            '<input type="button" class="btn btn-danger" style="margin:3px" value="수락취소" onclick="approveToRefuse('+mentee.applyNum+','+`'`+mentee.applyMenteeId+`'`+')">'+
                            '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>'+
                            '</div></div></div></div>';
                    }
                }

                $('#approveList').html(html);

            },
            error: function(errorThrown) {
                alert(errorThrown.statusText);
            }})

        $.ajax({
                url: "/apply/getrefuseList",
                type: "get",
                data : refusePage,
                accept: "application/json",
                success: function(refuselist) {
                    const refuse = refuselist.list;
                    let html = '';
                    if(refuse.length==0){
                        html += '<table style="text-align: center; margin: auto;">'+
                            '<tr><td>가입 거절된 멘티가 없습니다.</td></tr>'+
                            '</table>';
                    }else {
                        for (const mentee of refuse) {
                            html += '<li class="list-group-item"><span data-bs-toggle="modal" data-bs-target="#approve' + mentee.applyMenteeId + '">' +
                                mentee.applyMenteeId +
                                '</span></li>';

                            html += '<div class="modal fade" id="approve' + mentee.applyMenteeId + '" tabindex="-1" aria-labelledby="approve' + mentee.applyMenteeId + 'Label" aria-hidden="true">' +
                                '<div class="modal-dialog">' +
                                '<div class="modal-content">' +
                                '<div class="modal-header">' +
                                '<h1 class="modal-title fs-5" id="approve' + mentee.applyMenteeId + 'Label">' + mentee.applyMenteeId + '</h1>' +
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
                                '</div> <div class="modal-body">' + mentee.applyMsg + '</div>' +
                                '<div class="modal-footer">' +
                                '<input type="button" class="btn btn-primary" value="재승인" style="margin:3px" onclick="refuseToApprove(' + mentee.applyNum + ',' + `'` + mentee.applyMenteeId + `'` + ')">' +
                                '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>' +
                                '</div></div></div></div>';
                        }
                    }
                    $('#refuseList').html(html);

                },
                error: function(errorThrown) {
                    alert(errorThrown.statusText);
                }})
    }

    function refuseToApprove(num, menteeid){
        apply.applyNum = num;
        const studyCapacity = $('#capacitybar').attr("aria-valuenow");
        const studyNowCapacity = $('#capacitybar').attr("aria-valuemax");
            if (confirm( "'"+menteeid +"' 님의 스터디 가입 요청을 승인하시겠습니까?") == true){
                if(studyCapacity<=studyNowCapacity){
                    alert('수용할 수 있는 인원이 마감되었습니다. \r\n 모집인원 수정 혹은 기존인원 거절을 통해 받아주세요.');
                }else{
                $.ajax({
                    url: "/apply/refuseToApprove",
                    type: 'POST',
                    data : JSON.stringify(apply),
                    accept: "application/json",
                    contentType:'application/json',
                    success: function(res) {
                        if(res ==1){
                            alert('승인했습니다.');
                            window.location.reload();
                        }
                    }
                })
            }
            }else{   //취소
        return false;
        }
    }

    function approveToRefuse(num, menteeid){
        apply.applyNum = num;
        if (confirm( "'"+menteeid +"' 님의 스터디 가입 요청을 거절하시겠습니까?") == true){//확인
            $.ajax({
                url: "/apply/approveToRefuse",
                type: 'POST',
                data : JSON.stringify(apply),
                accept: "application/json",
                contentType:'application/json',
                success: function(res) {
                    if(res ==1){
                        alert('거절했습니다.');
                        window.location.reload();
                    }
                }
            })
        }else{   //취소
            return false;
        }
    }

    function approve(num, menteeid){
        apply.applyNum = num;
        const studyCapacity = $('#capacitybar').attr("aria-valuenow");
        const studyNowCapacity = $('#capacitybar').attr("aria-valuemax");
        if (confirm( "'"+menteeid +"' 님의 스터디 가입 요청을 승인하시겠습니까?") == true){//확인
            if(studyCapacity<=studyNowCapacity){
                alert('수용할 수 있는 인원이 마감되었습니다. \r\n 모집인원 수정 혹은 기존인원 거절을 통해 받아주세요.');
            }else{
            $.ajax({
                url: "/apply/approve",
                type: 'POST',
                data : JSON.stringify(apply),
                accept: "application/json",
                contentType:'application/json',
                success: function(res) {
                    if(res ==1){
                        alert('승인했습니다.');
                        window.location.reload();
                    }
                }
            })
            }
        }else{   //취소
            return false;
        }
    }

    function refuse(num,menteeid) {
        apply.applyNum = num;
        if (confirm("'" + menteeid + "' 님의 스터디 가입 요청을 거절하시겠습니까?") == true) {
            $.ajax({
                url: "/apply/refuse",
                type: 'POST',
                data: JSON.stringify(apply),
                contentType: 'application/json',
                accept: "application/json",
                success: function (res) {
                    if (res == 1) {
                        alert('거절하였습니다.');
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

    <div class="progress" style="margin-top: 3%; margin-bottom: 3%;">
        <div class="progress-bar progress-bar-striped bg-warning" id="capacitybar" role="progressbar" aria-label="Example with label"  style="" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0"><span id="capacityrate"></span></div>
    </div>

    <div class="accordion " id="accordionExample" style="margin-bottom: 3%; margin-top: 3%;">
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingOne">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    가입 수락 목록
                </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body" >
                        <ul class="list-group list-group-flush" id="approveList">




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
                    가입 거절 목록
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

    <div id="applierlist">


    </div>
</div>

<%@ include file="../includes/footer.jsp"%>
