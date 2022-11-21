<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/includes/header.jsp"/>
<html>
<head>
    <title>과제 수정</title>
    <style>
        body {
            height: 100%;
        }

        .submit {
            width: 60vw;
            min-height: 100%;
        }

        form {
            margin: 40px 0;
        }

        footer {
            padding: 0;
        }

        .btn {
            margin: 5px;
        }

        .form-row {
            margin: 10px 0;
        }

        textarea {
            resize: none;
        }

        .uploadedFileList{
            padding: 5px;
        }
        .uploadedFileWrapper{
            margin : 15px 0;
        }
        .fileLink{
            color:black;
        }
    </style>
</head>
<body>

<%-- 아래로 수정 필요--%>
<div class="container submit">
    <form action="/homework/${sessionScope.loginUser.userId}" class="submit" method="post" enctype="multipart/form-data">
       <div class="form-row">
            <div class="form-group col-md-6">
                <label for="mentorId">멘토</label>
                <input type="text" class="form-control" id="mentorId" name="mentorId" value="${homeWorkInfo.hwInfoMentor}"
                       readonly>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="hwDeadLine">제출기한</label>
                <input type="text" class="form-control" id="hwDeadLine" name="hwDeadLine" value="${homeWorkInfo.hwInfoDeadline}"
                       readonly>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="user_id">제출자(멘티)</label>
                <input type="text" class="form-control" id="user_id" name="user_id" value="${sessionScope.loginUser.userId}"
                       readonly>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="hwName">과제명</label>
                <input type="text" class="form-control" id="hwName" name="hwName" value="${homeWorkInfo.hwInfoName}" readonly>
            </div>
        </div>
        <div class="form-row">
            <label for="hwContent">과제내용 / 멘토에게 전할말</label>
            <textarea type="text" rows="15" class="form-control" id="hwContent" name="hwContent"
                      placeholder=""></textarea>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6 uploadedFileWrapper">
                <label>기존 첨부파일<strong style="color:red">(과제 수정시 파일을 다시 첨부해주세요)</strong></label>
            <ul class="uploadedFileList">
                현재 첨부된 파일이 없습니다
            </ul>
            </div>
        </div>
        <div class="form-row">
            <label for="uploadFile">파일 첨부</label>
            <input type="file" class="form-control" id="uploadFile" name="uploadFile" placeholder="첨부파일(5MB 용량제한)">
            <input type="file" class="form-control" name="uploadFile" placeholder="첨부파일">
            <input type="file" class="form-control" name="uploadFile" placeholder="첨부파일">
        </div>
        <button type="submit" id="submitButton" class="btn btn-primary" data-oper="modify">수정</button>
        <button type="reset" class="btn btn-primary" data-oper="delete">삭제</button>
        <button type="button" class="btn btn-primary" onclick="history.go(-1)">뒤로가기</button>
    </form>
</div>
</body>
<script type="text/javascript" src="/resources/js/homeworkScript.js"></script>
<script>

    const studyNum = '<c:out value="${sessionScope.loginUser.studyNum}"/>';

    $(function(){
        $.getJSON("/homework/getHomeWork", {studyNum}, function(homeWork) {
            console.log(homeWork);
            showUploadedHw(homeWork);
        });
    })

    const showUploadedHw = (homeWork) => {
        $("#hwContent").html(homeWork.hwContent);
        const filenames = homeWork.hwFilename.split(",");
        const uploadPath = homeWork.hwUploadPath.split(",");
        let filelist = "";

        if(homeWork.hwFilename != null){
            for(let i=0; i<filenames.length; i++){

                if(!(uploadPath[i].length==0 || filenames[i].length==0)){
                    console.log(uploadPath[i]);
                    let fileCallPath = encodeURIComponent(uploadPath[i]);
                    console.log(fileCallPath)
                    filelist += '<a class="fileLink" href="/homework/downloadHw?filename='+fileCallPath+'"><li>'+filenames[i]+'</li></a>';
                }
            }
            $(".uploadedFileList").html(filelist);
        }

    }

    const maxSize = 5242880; // 5mb

    function checkFile(fileSize) {
        if (fileSize >= maxSize) {
            alert("파일 사이즈가 너무 큽니다")
            return false
        }

        if (fileSize === 0) {
            return confirm("첨부된 파일의 내용이 없습니다. 등록하시겠습니까?");
        }

        return true;
    }

    /**
     * HomeWork 삭제
     */
    $("button[data-oper='delete']").on("click", (e)=>{
        e.preventDefault();
        if(confirm("정말로 삭제하시겠습니까?")) {
            hwDeleteAjax("${sessionScope.loginUser.userId}", () => {
                alert("삭제되었습니다.")
                location.href = '${root}/homework/info-mentee'
            })
        }
    })

    /**
     * HomeWork 수정
     */
    $("#submitButton").on("click", function (e) {
        e.preventDefault();
        console.log("수정 클릭");
        if(!confirm("과제 수정시 기존 첨부파일은 삭제 됩니다.")) {
            e.preventDefault();
            return;
        }

        let loginUserId = '<c:out value="${sessionScope.loginUser.userId}"/> '
        const hwContent = $("textarea[id='hwContent']").val();
        let data = new FormData();

        const appendFunction = (files) => {
            data.append("uploadFiles", files);
        }

        let inputFile = $("input[name='uploadFile']");

        console.log(inputFile);

        let totalFileSize = 0 ;

        for(let i=0; i<=2; i++){
            if(inputFile[i].value){
                let file = inputFile[i].files;
                console.log(file[0]);
                totalFileSize += file[0].size
                appendFunction(file[0]);
            }
        }

        if (!checkFile(totalFileSize)) {
            e.preventDefault();
            return false;
        }

        data.append("hwContent", hwContent);

        console.log("수정 data : " , data);
        hwModifyAjax(data, loginUserId, () => {
            alert("수정되었습니다.")
            location.reload();
        })

    })

</script>
</html>
<c:import url="/WEB-INF/views/includes/footer.jsp"/>