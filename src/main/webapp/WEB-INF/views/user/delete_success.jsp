<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value='${pageContext.request.contextPath}/' />

<script>
	<c:if test="${isDelete eq true}">
		alert('탈퇴되었습니다')
		location.href = '${root}'
	</c:if>
	<c:if test="${isDelete ne true}">
		alert('비밀번호를 확인해주세요.')
		history.back();
	</c:if>
</script>