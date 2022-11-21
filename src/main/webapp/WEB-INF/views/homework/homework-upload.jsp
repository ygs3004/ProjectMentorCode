<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../includes/header.jsp"/>
<html>
<head>
    <title>UploadHomeWork</title>
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

    .containerHere{
        margin:auto;
    }

    label{
        margin-top : 20px;
    }

</style>

<body>
<div class="containerHere">
<form action="/homework/upload-success" method="post">
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="hwInfoName">과제명</label>
            <input type="text" class="form-control" id="hwInfoName" placeholder="과제1" name="hwInfoName" >
        </div>
    </div>
    <div class="form-group col-md-6">
        <label for="hwInfoDeadline">제출기한</label>
        <input type="date" class="form-control" id="hwInfoDeadline" name="hwInfoDeadline">
    </div>
    <div class="form-group">
        <label for="hwInfoContent">과제내용</label>
        <textarea type="text" class="form-control" id="hwInfoContent" name="hwInfoContent" rows="15" cols="70"></textarea>
    </div>
    <br>
    <input type="hidden" name="hwInfoComplete" value="0">
    <button type="submit" class="btn btn-primary" onclick="return checkSubmit()">과제 게시하기</button>
</form>
</div>
</body>
</html>


<c:import url="../includes/footer.jsp"/>