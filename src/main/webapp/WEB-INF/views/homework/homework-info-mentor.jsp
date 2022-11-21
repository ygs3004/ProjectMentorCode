<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../includes/header.jsp"/>
<html>
<head>
    <title>과제 정보</title>
    <script type="text/javascript" src="/resources/js/homeworkScript.js"></script>
</head>
<style>

    @media (min-width: 768px) {
        .containerHere {
            width: 750px;
        }
    }

    @media (min-width: 992px) {
        .containerHere {
            width: 940px;
        }
    }

    .containerHere {
        margin:auto;
    }

    .study-informartion {
        margin-top: 40px;
        margin-bottom: 40px;
        width: 70%;
    }

    table {
        height: 70%;
        width: 70%;
    }

    th, td {
        vertical-align: middle;
    }

    th {
        text-align: center;
        width: 30%;
    }

    textarea {
        resize: none;
    }

    ul, li {
        list-style: none;
        padding-left: 0;
        margin-bottom: 15px;
    }

    .modifyInfo{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .fileLink{
        color:black;
    }
</style>
<body>
<div class="containerHere">
    <div class="container-sm study-informartion">
        <table class="table">
            <thead class="thead-dark">
            <tr style="background-color: rgba(0, 0, 0, 0.9)">
                <th scope="col" colspan="2" style="color:white">과제 정보</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">과제 이름</th>
                <td class="hwInfoName" id="hwInfoName"><c:out value="${homeWorkInfo.hwInfoName}"/></td>
            </tr>
            <tr>
                <th scope="row">제출기한</th>
                <td class="hwInfoDeadline" id="hwInfoDeadline"> <c:out value="${homeWorkInfo.hwInfoDeadline}"/> </td>
            </tr>
            <tr>
                <th scope="row">과제내용</th>
                <td class="hwInfoContent" id="hwInfoContent">
                    <c:out value="${homeWorkInfo.hwInfoContent}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">제출인원 / <br> 스터디인원</th>
                <td> <c:out value="${homeWorkInfo.hwInfoComplete} / ${study.studyNowCapacity} 명" /> </td>
            </tr>
            <tr>
                <th scope="row">제출자 명단</th>
                <td>
                    <ul class="uploadedHwList">
                        <%--ajax 출력--%>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="modifyInfo" >
        <div style="text-align: center; margin-bottom: 1%;">
            <button type="button" class="btn btn-outline-success btn-sm modifyInfoBtn">과제 내용 수정 / 삭제</button>
            <button type="button" class="btn btn-outline-success btn-sm" onclick="history.back()">뒤로</button>
        </div>
    </div>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
        integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
        crossorigin="anonymous"></script>
<script>

    const uploadedHwList = $(".uploadedHwList");

    function showUploadedHwList(uploadedHwResultArr){

        let str = "";

        $(uploadedHwResultArr).each((i, obj) =>{

            str += "<li> 제출자 : " + obj.hwUserId + " 제출일 : " + obj.hwRegDate + "</li>";
            str += "<textarea rows='5' cols='40' readonly>" + obj.hwContent + "</textarea>"

            if(obj.hwFilename) {
                let uploadPathArr = obj.hwUploadPath.split(",");
                let filenameArr = obj.hwFilename.split(",");

                for(let j=0; j<filenameArr.length; j++){
                    if(filenameArr[j].length>0) {
                        let fileCallPath = encodeURIComponent(uploadPathArr[j]);
                        str += "<li><a class='fileLink' href='/homework/downloadHw?filename=" + fileCallPath + "'> 첨부파일 : " + filenameArr[j] + "</a></li>";
                    }
                }
            }

        })

        uploadedHwList.append(str);
    }

    let hwInfoMentor = '<c:out value="${homeWorkInfo.hwInfoMentor}"/>';
    let studyNum = '<c:out value="${sessionScope.loginUser.studyNum}"/>';

    $(function(){
        $.getJSON("/homework/homeWorkList", {hwInfoMentor}, function(hwList) {
            console.log(hwList);
            showUploadedHwList(hwList);
        });

        const hwInfoName = $(".hwInfoName");
        const hwInfoDeadline = $(".hwInfoDeadline");
        const hwInfoContent = $(".hwInfoContent");
        const modifyAndDeleteButton = $(".modifyInfo");

        $(".modifyInfoBtn").on("click", () =>{

            const hwInfoNameInput = "<input id='hwInfoName' name='hwInfoName' value='<c:out value="${homeWorkInfo.hwInfoName}"/>'/>"
            const hwInfoDeadlineInput = "<input id='hwInfoDeadline' name='hwInfoDeadline' type='date' value='<c:out value="${homeWorkInfo.hwInfoDeadline}"/>'/>"
            const hwInfoContentTextarea = "<textarea id='hwInfoContent' rows='10' cols='40'><c:out value='${homeWorkInfo.hwInfoContent}'/></textarea>"
            const divideButton = "<button type='button' class='btn btn-outline-success btn-sm' data-oper='modify'>수정완료</button>"
                                + "&nbsp;&nbsp;<button type='button' class='btn btn-outline-success btn-sm' data-oper='delete'>삭제</button>"
                                + "&nbsp;&nbsp;<button type='button' class='btn btn-outline-success btn-sm' onclick='location.reload()'>수정 취소</button>"

            console.log("수정 요청")
            hwInfoName.html(hwInfoNameInput);
            hwInfoDeadline.html(hwInfoDeadlineInput);
            hwInfoContent.html(hwInfoContentTextarea);
            modifyAndDeleteButton.html(divideButton);
        })

        $(document).on("click", "button[data-oper='modify']", () =>{
            console.log("수정 완료 요청")
            if(!checkSubmit()) return;

            const hwInfo = {hwInfoName: $("input[id='hwInfoName']").val(),
                hwInfoDeadline: $("input[id='hwInfoDeadline']").val(),
                hwInfoContent: $("textarea[id='hwInfoContent']").val()}

            console.log("요청된 정보 : ", hwInfo)

            hwInfoModifyAjax(hwInfo, hwInfoMentor, () => {
                alert("수정되었습니다")
                location.reload();
            })
        })

        $(document).on("click", "button[data-oper='delete']", () =>{
            if(confirm("정말로 삭제하시겠습니까?")) {
                console.log("삭제 요청")
                hwInfoDeleteAjax(hwInfoMentor,
                    () => {
                    alert("삭제완료");
                    location.href="/study/info"
                    },
                    () => {
                        alert("삭제에 실패했습니다.")
                    })
            }
        })
    })


</script>

</html>
<c:import url="../includes/footer.jsp"/>