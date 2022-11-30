<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="root"/>
<style>
    .study-information{
        margin-top: 80px;
        margin-bottom: 150px;
        width: 60%;
    }

    table{
        height: 70%;
        width: 50%;
    }

    th, td {
        vertical-align : middle;
    }

    th{
        text-align: center;
        width:30%;
    }
    .centerBtn{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .hwBtn{
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 100%;
    }
    .menu-information{
        text-align: center;
        margin-bottom: 30px;
        margin-top: 50px;
    }

</style>

<div class="shadow p-3 mb-5 bg-white rounded container-sm study-information">
<h3 class="menu-information"> 스터디 정보 </h3>
<table class="table">
    <tr>
        <th scope="row" >스터디 이름</th>
        <td><c:out value=" ${study.studyTitle}" /></td>
    </tr>
    <tr>
        <th scope="row">멘토</th>
        <td><c:out value=" ${study.studyUserId}" /></td>
    </tr>
    <tr>
        <th scope="row">멘토님 학교</th>
        <td><c:out value=" ${study.studySchool}" /></td>
    </tr>
    <tr>
        <th scope="row">멘토 경력</th>
        <td><c:out value=" ${study.studyCareer}" /></td>
    </tr>
    <tr>
        <th scope="row"> 기간 </th>
        <td><c:out value=" ${study.studyPeriod}" /></td>
    </tr>
    <tr>
        <th scope="row">스터디 내용</th>
        <td><c:out value=" ${study.studyContent}" /></td>
    </tr>
    <tr>
        <th scope="row">현재인원 / <br> 모집인원</th>
        <td><c:out value="${study.studyNowCapacity}  /  ${study.studyCapacity} 명" /> </td>
    </tr>
    <tr>
        <th scope="row">진행중인 과제</th>
        <%--<c:if test="${과제 == null}">버튼 넣기</c:if> 과제 있는지 없는지 체크할것 --%>
        <td class="hwBtn">
            <c:choose>
                <%--멘토일때--%>
                <c:when test="${sessionScope.loginUser.userRole == 1}">
                    <c:choose>
                        <%--과제가 있을때(멘토)--%>
                        <c:when test="${checkHomeWork}">
                            <c:out value="현재 진행중인 과제가 있습니다"/>
                            <button type="button" class="btn btn-outline-success btn-sm"
                                    onclick="location.href='/homework/info-mentor'" >과제 정보</button><br><br>
                        </c:when>
                        <%-- 과제가 없을때--%>
                        <c:otherwise>
                            <c:out value="현재 진행중인 과제가 없습니다"/>
                            <button type="button" class="btn btn-outline-success btn-sm"
                                    onclick="location.href='/homework/upload'">과제 생성</button><br><br>
                        </c:otherwise>
                    </c:choose>
                </c:when>

                <%--멘티일때--%>
                <c:when test="${sessionScope.loginUser.userRole == 2}">
                    <c:choose>
                        <%--과제가 있을때(멘티)--%>
                        <c:when test="${checkHomeWork}">
                            <c:out value="현재 진행중인 과제가 있습니다"/>
                            <button type="button" class="btn btn-outline-success btn-sm"\
                                    onclick="location.href='/homework/info-mentee'">과제 정보 </button>
                        </c:when>
                        <%-- 과제가 없을때--%>
                        <c:otherwise>
                            <c:out value="현재 진행중인 과제가 없습니다"/>
                        </c:otherwise>
                    </c:choose>
                </c:when>
            </c:choose>
        </td>
    </tr>
    </tbody>
</table>
    <div class="centerBtn">
    <c:if test="${sessionScope.loginUser.userRole == 1 && sessionScope.loginUser.studyNum == study.studyNum}">
    <div style="text-align: center; margin-bottom: 1%;">
        <button type="button" class="btn btn-outline-success btn-sm"
                onclick="location.href='/study/modify'">스터디 정보 수정하기</button>
    </c:if>
    <button type="button" class="btn btn-outline-success btn-sm" onclick="history.back()">뒤로</button>
    </div>
    
    </div>
</div>
<%@ include file="../includes/footer.jsp"%>