<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>과제 정보</title>
</head>
<style>
    .wrapper {
        margin: 10vh 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .table {
        height: 50vh;
        vertical-align: middle;
    }

    .submitBtn {
        display: flex;
        justify-content: center;
    }

    th {
        text-align: center;
    }
    .study-infomartion{
        width:50vw;
    }

</style>
<body>
<div class="wrapper ">
    <div class="shadow p-3 mb-5 bg-white rounded study-infomartion">
        <h3 style="text-align: center">과제 정보</h3>
        <table class="table">
            <tbody>
            <tr>
                <th scope="row">과제명</th>
                <td><c:out value="${homeWorkInfo.hwInfoName}"/></td>
            </tr>

            <tr>
                <th scope="row">과제 기한</th>
                <td><c:out value="${homeWorkInfo.hwInfoDeadline}"/></td>
            </tr>

            <tr>
                <th scope="row">과제 내용</th>
                <td><c:out value="${homeWorkInfo.hwInfoContent}"/></td>
            </tr>

            <tr>
                <th scope="row">제출 상태</th>
                <c:choose>
                    <c:when test="${homeWork != null}">
                        <td><c:out value="${homeWork.hwRegDate} 제출완료"/></td>
                    </c:when>
                    <c:otherwise>
                        <td><c:out value="과제를 제출해 주세요"/></td>
                    </c:otherwise>
                </c:choose>

            </tr>

            </tbody>
        </table>
        <div class="submitBtn">
            <c:choose>
                <c:when test="${homeWork != null}">
                    <button type="button" class="btn btn-outline-success btn-sm"
                            onclick="location.href='modify-form'">제출 과제 수정 / 삭제
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-outline-success btn-sm"
                            onclick="location.href='submit-form'">제출하기
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>

</html>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
