<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var='root' value='${pageContext.request.contextPath}/' />

<c:import url="${root }WEB-INF/views/includes/header.jsp" />
<style>
	.main-image img{
		background-repeat: no-repeat;
		background-position: center;
		background-size: contain;

		width:33vw;
		height:400px;
		padding:0;

	}
</style>


<div class="row main-image" >
	<img class="col-4" src="${root}resources/img/study_1.jpg" alt="">
	<img class="col-4" src="${root}resources/img/study_2.jpg" alt="">
	<img class="col-4" src="${root}resources/img/study_3.jpg" alt="">
	<img class="col-4" src="${root}resources/img/study_4.jpg" alt="">
	<img class="col-4" src="${root}resources/img/study_5.jpg" alt="">
	<img class="col-4" src="${root}resources/img/study_6.jpg" alt="">
</div>

<c:import url="${root }WEB-INF/views/includes/footer.jsp" />
