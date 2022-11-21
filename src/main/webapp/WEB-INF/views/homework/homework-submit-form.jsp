<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="${root }/WEB-INF/views/includes/header.jsp" />
<html>
<head>
    <title>과제 제출하기</title>
    <style>
        body{
            height: 100%;
        }
        .submit{
            width : 60vw;
            min-height: 100%;
        }
        form{
            margin : 40px 0;
        }
        footer{
            padding: 0;
        }
        .btn{
            margin : 5px;
        }
        .form-row{
            margin : 10px 0;
        }
        textarea{
            resize: none;
        }
    </style>

</head>

<body>
<div class="container submit">
  <form action="${root}/homework/submit" class="submit" method="post" enctype="multipart/form-data">
          <div class="form-row">
              <div class="form-group col-md-6">
                  <label for="mentorId">멘토</label>
                  <input type="text" class="form-control" id="mentorId" name="mentorId" value="${homeWorkInfo.hwInfoMentor}" readonly>
              </div>
          </div>
          <div class="form-row">
              <div class="form-group col-md-6">
                  <label for="hwDeadLine">제출기한</label>
                  <input type="text" class="form-control" id="hwDeadLine" name="hwDeadLine" value="${homeWorkInfo.hwInfoDeadline}" readonly>
              </div>
          </div>

          <div class="form-row">
              <div class="form-group col-md-6">
                  <label for="hwUserId">제출자(멘티)</label>
                  <input type="text" class="form-control" id="hwUserId" name="hwUserId" value="${sessionScope.loginUser.userId}" readonly>
              </div>
          </div>
          <div class="form-row">
              <div class="form-group col-md-6">
                  <label for="hwInfoName">과제명</label>
                  <input type="text" class="form-control" id="hwInfoName" name="hwInfoName" value="${homeWorkInfo.hwInfoName}" readonly>
              </div>
          </div>
          <div class="form-row">
              <label for="hwContent">과제내용 / 멘토에게 전할말</label>
              <textarea type="text" rows="15" class="form-control" id="hwContent" name="hwContent" placeholder="과제 내용을 입력해주세요"></textarea>
          </div>
          <div class="form-row">
              <label for="uploadFile">파일 첨부</label>
              <input type="file" class="form-control" id="uploadFile" name="uploadFile" placeholder="첨부파일(5MB 용량제한)">
              <input type="file" class="form-control" name="uploadFile" placeholder="첨부파일">
              <input type="file" class="form-control" name="uploadFile" placeholder="첨부파일">
          </div>
          <input type="hidden" name="hwStudyNum" value="${sessionScope.loginUser.studyNum}"/>
          <button id="submitButton" class="btn btn-primary">제출</button>
          <button type="reset" class="btn btn-primary">다시작성</button>
      </form>
</div>
<script src="/resources/js/jquery3.6.1.js"></script>
<script>

    let maxSize = 5242880; // 5mb

    function checkFile(fileSize){
        if(fileSize >= maxSize){
            alert("파일 사이즈가 너무 큽니다")
            return false
        }

        if(fileSize===0){
            return confirm("첨부된 파일의 내용이 없습니다. 등록하시겠습니까?");
        }

        return true;
    }

    $("#submitButton").on("click", function (e){

        let inputFile = $("input[name='uploadFile']");
        let files = inputFile[0].files;
        let content =  $("#hwContent").val()
        console.log(files);
        let fileSize = 0;

        for(let i=0; i<files.length; i++){
            fileSize +=  inputFile[i].files[0].size
        }

        console.log("업로드 되는 파일사이즈", fileSize);

        if(!checkFile(fileSize)) e.preventDefault();

        if(content.length<1) {
            alert("내용을 입력해주세요");
            e.preventDefault();
            return false;
        }

        return true;
    })

</script>
</body>
</html>
<c:import url="${root }/WEB-INF/views/includes/footer.jsp" />
