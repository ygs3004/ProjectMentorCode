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
<title>회원 정보 수정</title>
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
<script>
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
	<div class="containerHere">
		<div class="container" style="margin-top: 100px">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
					<div class="card shadow">
						<div class="card-body">
							<form:form action='${root}user/modify_pro' method='post'
								modelAttribute="modifyUserBean">
								<form:hidden path="userEmailExist" />
								<div class="form-group">
									<form:label path="userName">이름</form:label>
									<form:input path="userName" class='form-control'
										readonly="true" />
								</div>
								<div class="form-group">
									<form:label path="userId">아이디</form:label>
									<form:input path="userId" class='form-control' readonly="true" />
								</div>
								<div class="form-group">
									<form:label path="userPw">변경 비밀번호</form:label>
									<form:password path="userPw" class='form-control' />
									<form:errors path='userPw' style='color:red' />
								</div>
								<div class="form-group">
									<form:label path="userPw2">변경 비밀번호 확인</form:label>
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
											<button type="button" class="btn btn-outline-success btn-sm"
												onclick='checkUserEmailExist()'>중복확인</button>
										</div>
									</div>
									<form:errors path="userEmail" style='color:red' />
									<!-- 전화번호 -->
									<div class="form-group">
										<form:label path="userPhone">전화번호 ( - 포함 13자리 입력)</form:label>
										<form:input path="userPhone" class='form-control' width="80px" />
										<form:errors path="userPhone" style='color:red' />
									</div>
									<br>
									<div class="form-group">
										<div class="text-right">
											<form:button class='btn btn-outline-success btn-sm'>정보수정</form:button>
											<button type="button" class="btn btn-outline-success btn-sm"
												onclick="history.back(-1)">뒤로가기</button>
										</div>
									</div>
							</form:form>
						</div>
					</div>
				</div>
				<div class="col-sm-3"></div>
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
