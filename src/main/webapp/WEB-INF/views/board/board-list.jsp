<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
    <link rel="icon" type="image/x-icon"
          href="/resources/assets/favicons.ico"/>
    <c:import url="/WEB-INF/views/common/import.jsp"></c:import>
    <meta charset="UTF-8">
    <title>게시글 목록창</title>
    <style>
        .shadow {
            margin-bottom: 70px;
        }

        li {
            list-style: none;
        }
        .pagingBox{
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px;
        }
        #searchType{
            height: 30px;
        }
        .board-list-title {
            margin : 30px 0;
        }
        .table{
            margin-top : 15px;
        }
        a{
            cursor:pointer;
        }
        .nowPageLocation{
            color:blue;
        }
    </style>
    <link rel=stylesheet href="/resources/css/bootstrap.css">
</head>
<body>
<c:import url="/WEB-INF/views/includes/header.jsp"/>
<div class="container" style="margin-top: 100px">
    <div class="container" id="shadow">
        <div>
            <div class="card shadow">
                <div class="card-body">
                    <h1 class="board-list-title" align="center">게시글 목록</h1>
                    <select id="searchType">
                        <option value="boardTitle">제목</option>
                        <option value="crename">작성자</option>
                    </select>
                    <input type="text" placeholder="검색어를 작성해주세요" id="searchStr">
                    <button class="btn btn-outline-success btn-sm" onclick="getBoards()">검색</button>
                    <button onclick="location.href='/views/board/board-insert'"
                            class="btn btn-outline-success btn-sm" style="float: right">글작성
                    </button>
                    <table class="table table-hover">
                        <thead class="thead-light">
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">작성시간</th>
                        </tr>
                        </thead>
                        <tbody id="tBody">
                        </tbody>
                    </table>
                    <div class="pagingBox">
                        <ul class="pagination">
                            페이지 번호
                        </ul>
                    </div>

                    <div id="totalDiv"></div>
                    <script>
                        $(document).ready(function () {
                            getBoards()
                        })

                        function getBoards(page) {
                            if (!page) page = 1;
                            const data = {
                                page: page,
                                pageSize: 10,
                                searchType: $('#searchType').val(),
                                searchStr: $('#searchStr').val()
                            }
                            //http method post, get
                            $.ajax({
                                type: 'GET',
                                url: '/boards', //localhost~호출
                                data: data,
                                accept: "application/json", //빼도 무방
                                success: function (res) { //get방식으로 /boards 갔다가 응답이 잘 왔으면 실행할 내용
                                    console.log(res)
                                    $('#totalDiv').html(
                                        '총갯수:' + res.total);
                                    let html = '';
                                    let list = res.list;
                                    for (let i = 0; i < list.length; i++) {
                                        const board = list[i];
                                        console.log(board);
                                        html += '<tr style="cursor:pointer" onclick="goBoardView('
                                            + board.boardNum
                                            + ')">';
                                        html += '<th scope="row">'
                                            + board.boardNum
                                            + '</th>';
                                        for (let le = 1; le < board.level; le++) {
                                            board.boardTitle = '&nbsp; ㄴ &nbsp;'
                                                + board.boardTitle;
                                        }
                                        html += '<td>'
                                            + board.boardTitle
                                            + '</td>';
                                        html += '<td>'
                                            + board.crename
                                            + '</td>';
                                        html += '<td>'
                                            + board.credate
                                            + '</td>';
                                        html += '</tr>';
                                    }
                                    $('#tBody').html(html);
                                    let pageHtml = '<li class="page-item">';

                                    let nowFirstPage = res.pageNum-(res.pageNum%10)+1;
                                    if(res.pageNum%10 == 0) nowFirstPage = res.pageNum-9;
                                    let nowLastPage = nowFirstPage+9;

                                    if(nowLastPage > res.pages) nowLastPage=res.pages;

                                    if(nowFirstPage>1) {
                                        pageHtml += '<a class="page-link" aria-label="Previous" onclick="getBoards(' + (nowFirstPage-10) + ')">';
                                        pageHtml += '<span aria-hidden="true">&laquo;</span>';
                                        pageHtml += '</a>';
                                        pageHtml += '</li>';
                                    }

                                    for(let i=nowFirstPage; i<=nowLastPage; i++){

                                        if(i === res.pageNum) {
                                            pageHtml += '<li class="page-item nowPageLocation">';
                                            pageHtml += '<a class="page-link" onclick="getBoards(' + i + ')">' + i + '</a>';
                                        }
                                        else {
                                            pageHtml += '<li class="page-item">';
                                            pageHtml += '<a class="page-link" onclick="getBoards(' + i + ')">' + i + '</a>';
                                        }

                                        pageHtml += '</li>';
                                    }

                                    if(nowLastPage<res.pages) {
                                        pageHtml += '<li class="page-item">';
                                        if(res.pageNum+10 <= res.pages) pageHtml += '<a class="page-link" aria-label="Next" onclick="getBoards(' + (res.pageNum+10) + ')">';
                                        else pageHtml += '<a class="page-link" aria-label="Next" onclick="getBoards(' + (nowFirstPage+10) + ')">';
                                        pageHtml += '<span aria-hidden="true">&raquo;</span>';
                                        pageHtml += '</a>';
                                        pageHtml += '</li>';
                                    }
                                    $('.pagination').html(pageHtml);
                                },
                                error: function (err) {
                                    console.log(err);
                                }
                            })
                        }

                        function goBoardView(boardNum) {
                            location.href = '/views/board/board-view?boardNum='
                                + boardNum;
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>