<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 답글 페이지</title>
    <link rel="icon" type="image/x-icon" href="/resources/assets/favicons.ico"/>
    <c:import url="/WEB-INF/views/common/import.jsp"></c:import>
    <meta charset="UTF-8">
    <title>게시글 답글 페이지</title>
    <style>
        .shadow {
            margin-bottom: 70px;
        }
    </style>
</head>
<body>
<c:import url="/WEB-INF/views/includes/header.jsp"/>
<div class="container" style="margin-top: 100px">
    <div class="container" id="shadow">

        <div>
            <div class="card shadow">
                <div class="card-body">
                    <h1 align="center">게시판 답글 페이지</h1>
                    <form method="POST" action="/boards" id="form">
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col">제목</th>
                                <td><input type="text" name="boardTitle" id="boardTitle">
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">작성자</th>
                                <td>${loginUser.userName}</td>
                            </tr>
                            <tr>
                                <th scope="col">내용</th>
                                <td><textarea name="boardContent" id="boardContent"
                                              style="width:75%; height:191px;"></textarea></td>
                            </tr>
                            <tr>
                                <th colspan="2">

                                    <div style="text-align: right; margin-bottom: 1%;">
                                        <button type="button" class="btn btn-outline-success btn-sm"
                                                onclick="insertBoard()">등록
                                        </button>
                                        &nbsp;
                                        <button type="button" class="btn btn-outline-success btn-sm"
                                                onclick="history.back()">뒤로가기
                                        </button>
                                    </div>
                                </th>
                            </tr>
                            </thead>
                        </table>
                        <input type="hidden" name="boardParentNum" value="${param.boardNum}">
                        <input type="hidden" name="creusr" value="${loginUser.userIdx}">
                        <input type="hidden" name="modusr" value="${loginUser.userIdx}">
                    </form>
                    <script>
                        function insertBoard() {
                            const data = {};
                            $('[name]').each(function (idx, item) {
                                data[item.name] = item.value;
                            })
                            console.log(data);
                            $.ajax({
                                type: 'POST',
                                url: '/boards',
                                contentType: 'application/json',
                                data: JSON.stringify(data),
                                success: function (res) {
                                    if (res == 1) {
                                        alert('정상 등록 되었습니다.');
                                        location.href = '/views/board/board-list';
                                    }
                                }
                            })
                        }
                    </script>
                </div>
            </div>
            <div></div>
        </div>
    </div>
</div>
<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>