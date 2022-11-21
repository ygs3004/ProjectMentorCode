<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/views/common/import.jsp"></c:import>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.shadow {
	margin-bottom: 70px;
}
</style>
<link rel=stylesheet href="/resources/css/bootstrap.css">
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<div class="container" style="margin-top: 100px">
		<div class="container" id="shadow">

			<div>
				<div class="card shadow">
					<div class="card-body">
						<h1 align="center">게시글 수정</h1>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<td><input type="text" name="boardNum" disabled></td>
								</tr>
								<tr>
									<th scope="col">제목</th>
									<td><input type="text" name="boardTitle"></td>
								</tr>
								<tr>
									<th scope="col">작성자</th>
									<td>${loginUser.userName}</td>
								</td>
								<tr>
									<th scope="col">내용</th>
									<td><textarea name="boardContent" style="width:75%; height:191px;"></textarea>
									</td>
								</tr>
								<tr>
									<th colspan="2">
										<div style="text-align: right; margin-bottom: 1%;">
											<button type="button" class="btn btn-outline-success btn-sm"
												onclick="location.href='/views/board/board-list'">수정</button>
											&nbsp;
											<button type="button" class="btn btn-outline-success btn-sm"
												onclick="history.back(-1)">뒤로가기</button>
												</div>
									</th>
								</tr>
							</thead>
						</table>

						<script>
		$(document).ready(function() {
			getBoard();
		})

		function getBoard() {
			$.ajax({
				type : 'GET',
				url : '/boards/${param.boardNum}',
				accept : "application/json",
				success : function(res) {
					console.log(res);
					const keys = Object.keys(res);
					for(let i=0;i<keys.length;i++){
						const key = keys[i];
						$('[data-col="' + key + '"]').html(res[key]);
					}
				}
			})
		}

		function deleteBoard(){
			const data = {
					boardNum : ${param.boardNum}
			}
			$.ajax({
				type : 'DELETE',
				url : '/boards',
				accept : "application/json",
				data : JSON.stringify(data),
				contentType:'application/json',
				success : function(res) {
					if(res==1){
						alert('정상적으로 삭제 되었습니다.');
						location.href='/views/board/board-list';
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
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>