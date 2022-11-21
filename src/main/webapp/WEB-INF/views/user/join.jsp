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
<title>회원 가입</title>
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
<style>
.shadow {
	margin-bottom: 100px;
}
</style>
<script>
    function checkUserIdExist(){

        var userId = $("#userId").val()

        if(userId.length == 0){
            alert('아이디를 입력해주세요')
            return
        }
        $.ajax({
            url : '${root}user/checkUserIdExist/' + userId,
            type : 'get',
            dataType : 'text',
            success : function(result){
                if(result.trim() == 'true'){
                    alert('사용할 수 있는 아이디입니다')
                    $("#userIdExist").val('true')
                } else {
                    alert('사용할 수 없는 아이디 입니다')
                    $("#userIdExist").val('false')
                }
            }
        })
    }
    function resetUserIdExist(){
        $("#userIdExist").val('false')
    }
    function checkUserEmailExist(){

        var userEmail = $("#userEmail").val()

        if(userEmail.length == 0){
            alert('이메일을 입력해주세요')
            return
        }
        $.ajax({
            url : '${root}user/checkUserEmailExist/' + userEmail,
            type : 'get',
            // data : {'email' : userEmail},
            dataType : 'text',
        success : function(result){
                if(result.trim() == 'true'){
                    alert('사용할 수 있는 이메일입니다')
                    $("#userEmailExist").val('true')
                } else {
                    alert('사용할 수 없는 이메일 입니다')
                    $("#userEmailExist").val('false')
                }
            }
        })
    }
    function resetUserEmailExist(){
        $("#userEmailExist").val('false')
    }
</script>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<br>
	<h1 align="center">회원 가입</h1>
	<div class="containerHere">
		<div class="container" style="margin-top: 100px">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<div class="card shadow">
						<div class="card-body">
							<form:form action="${root }user/join_pro" method='post'
								modelAttribute="joinUser">
								<form:hidden path="userIdExist" />
								<form:hidden path="userEmailExist" />
								<div class="form-group">
									<form:radiobutton path="userRole" value="1" label="멘토로 가입하기 "
										checked="checked"></form:radiobutton>
									<br>
									<form:radiobutton path="userRole" value="2" label="멘티로 가입하기 "></form:radiobutton>
									<br>
								</div>
								<!-- 이름 -->
								<div class="form-group">
									<form:label path="userName">이름(2~5자리)</form:label>
									<form:input path="userName" class='form-control' />
									<form:errors path="userName" style='color:red' />
								</div>
								<!-- 아이디 & 중복확인 -->
								<div class="form-group">
									<form:label path="userId">아이디(4~20자리)</form:label>
									<div class="input-group">
										<form:input path="userId" class='form-control'
											onkeypress="resetUserIdExist()" />
										<div class="input-group-append">
											<button type="button" class="btn btn-primary"
												onclick='checkUserIdExist()'>중복확인</button>
										</div>
									</div>
									<form:errors path="userId" style='color:red' />
								</div>
								<!-- 비밀번호 입력 -->
								<div class="form-group">
									<form:label path="userPw">비밀번호 (영 대,소문자,숫자, 4~20자리 입력가능)</form:label>
									<form:password path="userPw" class='form-control' />
									<form:errors path='userPw' style='color:red' />
								</div>
								<!-- 비밀번호 확인 -->
								<div class="form-group">
									<form:label path="userPw2">비밀번호 확인</form:label>
									<form:password path="userPw2" class='form-control' />
									<form:errors path='userPw2' style='color:red' />
								</div>
								<!-- 이메일 & 중복확인 -->
								<div class="form-group">
									<form:label path="userEmail">이메일</form:label>
									<div class="input-group">
										<form:input path="userEmail" class='form-control'
											onkeypress="resetUserEmailExist()" />
										<div class="input-group-append">
											<button type="button" class="btn btn-primary"
												onclick='checkUserEmailExist()'>중복확인</button>
										</div>
									</div>
									<form:errors path="userEmail" style='color:red' />
									<br>
									<!-- 전화 번호 -->
									<div class="form-group">
										<form:label path="userPhone">전화번호 ( - 포함 13자리 입력)</form:label>
										<form:input path="userPhone" class='form-control' width="80px" />
										<form:errors path="userPhone" style='color:red' />
									</div>
									<!-- 성별 선택 -->
									<div class="form-group">
										<form:label path="userGender">성별</form:label>
										<br>
										<form:radiobutton path="userGender" value="1" label="남자"></form:radiobutton>
										<form:radiobutton path="userGender" value="2" label="여자"></form:radiobutton>
										<form:errors path="userGender" style='color:red' />
									</div>
									<!-- 학교 입력 -->
									<div class="form-group">
										<form:label path="userSchool">학교</form:label>
										<form:input path="userSchool" class='form-control' />
										<form:errors path="userSchool" style='color:red' />
									</div>
									<div class="form-group">
										<div class="text-right">
											<form:button class='btn btn-primary'>회원가입</form:button>
										</div>
									</div>
							</form:form>
						</div>
						<div class="col-sm-3"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>