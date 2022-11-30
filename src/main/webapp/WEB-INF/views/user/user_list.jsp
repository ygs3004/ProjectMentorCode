<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 정보 관리</title>
<link rel="icon" type="image/x-icon"
	href="/resources/assets/favicons.ico" />
<style>
.shadow {
	margin-bottom: 70px;
}
</style>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<!-- 	<div class="containerHere">
		<div class="container" style="margin-top: 100px">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<div class="card shadow">
						<div class="card-body"> -->
	<div align="center">
	<form:form action='${root}user/user_list' method='get'
								modelAttribute="userListBean"></form:form>
		<h3>[전체 회원 목록]</h3>
		<table border="2" width="900px">
			<tr>
				<th>회원 번호</th>
				<th>studyNum</th>
				<th>멘토&멘티</th>
				<th>회원 이름</th>
				<th>회원 아이디</th>
				<th>회원 이메일</th>
				<th>회원 전화번호</th>
				<th>회원 성별</th>
				<th>회원 학교</th>
			</tr>
			<tbody>
					<c:forEach var='user' items="${result }">
					</c:forEach>
					</tbody>
			<tr>
			<td class="text-center d-none d-md-table-cell">${user.userIdx }</td>
			<td class="text-center d-none d-md-table-cell">${user.StudyNum }</td>
			<td class="text-center d-none d-md-table-cell">${user.userRole }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userName }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userId }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userEmail }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userPhone }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userGender }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userSchool }</td>			
			</tr>
			<tr>
			<td class="text-center d-none d-md-table-cell">${user.userIdx }</td>
			<td class="text-center d-none d-md-table-cell">${user.StudyNum }</td>
			<td class="text-center d-none d-md-table-cell">${user.userRole }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userName }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userId }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userEmail }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userPhone }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userGender }</td>			
			<td class="text-center d-none d-md-table-cell">${user.userSchool }</td>			
			</tr>
		</table>
	</div>

	<!-- 						</div>
					</div>
				</div>
				<div class="col-sm-3"></div>
			</div>
		</div>
	</div> -->

	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
