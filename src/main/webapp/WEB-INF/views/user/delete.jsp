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
<title>회원 탈퇴</title>
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
	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action='${root}user/delete_pro' method='post'
							modelAttribute="deleteUserBean">
							<%--            <form:hidden path="userEmailExist"/>--%>
							<div class="form-group">
								<form:label path="userName">이름</form:label>
								<form:input path="userName" class='form-control' readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="userId">아이디</form:label>
								<form:input path="userId" class='form-control' readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="userPw">현재 비밀번호</form:label>
								<form:password path="userPw" class='form-control' />
								<form:errors path='userPw' style='color:red' />
							</div>
							<br>
							<div class="form-group">
								<div class="text-right">
								<form:button class='btn btn-outline-danger'>회원탈퇴</form:button>
									<!-- <button type="button" class="btn btn-primary" onclick='deleteUser()'>회원탈퇴</button> -->
								</div> 
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
	<!-- <script>
		function deleteUser(){
			const data = {
					userId : $('[name=userId]').val(),
					userPw : $('[name=userPw]').val()
			}
			$.ajax({
				url:'/user/delete-user',
				type:'POST',
				contentType:'application/json',
				data : JSON.stringify(data),
				success:function(result){
					if(result){
						alert('delete user!!');
						location.href='/';
					}else{
						alert('check ur password, plz.');
					}
				}
			})
		}
	</script> -->
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
