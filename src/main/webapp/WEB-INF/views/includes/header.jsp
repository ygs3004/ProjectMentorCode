<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath}/' />
<html lang="ko">
<style>
    #green{
        height: 400px;
    }
    .divider-custom-line{
        line-height: 40px;
        font-weight: 700;
    }
    .divider-custom-icon{
        font-size:0.8rem;
        font-weight: 700;
    }
    #emptydiv {height: 109px;}

    @media (min-width: 576px) {  #emptydiv {height: 90px;}
    }

</style>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>-Welcome Our Mentor-</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="/resources/assets/icon.png" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/resources/css/styles.css" rel="stylesheet" />
    <%--jquery--%>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"
            integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
            crossorigin="anonymous"></script>
</head>
<body id="page-top">
<!-- Navigation-->
<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
    <div class="container">

        <a class="navbar-brand" href="/">Men To Men</a>

        <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/views/board/board-list">자유게시판</a></li>
<%--                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/user/login">로그인</a></li>--%>
<%--                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="/user/join">회원가입</a></li>--%>
                <%-- 멘토 : user_role==1 멘티 : user_role==2 --%>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${root}views/study/study-list">스터디룸</a></li>
<%--               드롭다운시작--%>
                <li class="nav-item dropdown">
                    <c:choose>
                    <c:when test="${!sessionScope.loginUser.userLogin}"> <!-- 로그인하지 않았을 경우 -->
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="${root}user/login">마이스터디</a></li>
                </c:when>
                <c:otherwise>
                    <a class="nav-link text-uppercase" role="button" data-bs-toggle="dropdown" aria-expanded="false">마이스터디</a>
                    <ul class="dropdown-menu">
                        <c:if test="${sessionScope.loginUser.studyNum == 0}">
                            <c:if test="${sessionScope.loginUser.userRole == 1}">
                                <li><a class="dropdown-item" href="${root}study/create">스터디개설</a></li>
                            </c:if>
                        </c:if>
                    <c:if test="${sessionScope.loginUser.studyNum >= 1}"> <%--스터디에 가입중일 경우--%>
                        <li><a class="dropdown-item" href="${root}study/info">스터디정보</a></li>
                        <c:if test="${sessionScope.loginUser.userRole == 1}">
                            <li><a class="dropdown-item" href="${root}views/study/study-applylist">가입요청관리</a></li>
                        </c:if>
                        <c:if test="${sessionScope.checkHomeWork}">
                            <c:if test="${sessionScope.loginUser.userRole == 1}">
                        <li><a class="dropdown-item" href="${root}homework/info-mentor">과제관리</a></li>
                            </c:if>
                            <c:if test="${sessionScope.loginUser.userRole == 2}">
                        <li><a class="dropdown-item" href="${root}homework/info-mentee">과제</a></li>
                            </c:if>
                        </c:if>
                        <c:if test="${!sessionScope.checkHomeWork}">
                            <c:if test="${sessionScope.loginUser.userRole == 1}">
                                <li><a class="dropdown-item" href="${root}homework/upload">과제공지</a></li>
                            </c:if>
                        </c:if>
                    </c:if>
                    </ul>
                        </c:otherwise>
                        </c:choose>

                <c:choose>  <%-- 로그인 했을경우--%>
                    <c:when test="${sessionScope.loginUser.userLogin}">
                        <%--                     <c:when test="${loginUserBean.userLogin == true }"> --%>
                        <li class="nav-item">
                            <a href="${root }user/modify" class="nav-link">회원수정</a>
                        </li>
                        <li class="nav-item">
                            <a href="${root }user/logout" class="nav-link">로그아웃</a>
                        </li>
                        <li class="nav-item"><c:if
                                test="${sessionScope.loginUser.userRole == 0}">
                            <a href="${root }user/user_list" class="nav-link">회원관리</a>
                        </c:if>
                        </li>
                    </c:when>
                    <c:otherwise> <%-- 로그인 하지않았을 경우 --%>
                        <li class="nav-item">
                            <a href="${root }user/login" class="nav-link">로그인</a>
                        </li>
                        <li class="nav-item">
                            <a href="${root }user/join"class="nav-link">회원가입</a>
                        </li>
                    </c:otherwise>
                </c:choose>
                <c:choose>  <%-- 로그인 했을경우 회원탈퇴란 생성--%>
                    <c:when test="${sessionScope.loginUser.userLogin}">
                        <li class="nav-item">
                            <a href="${root}user/delete" class="nav-link">회원탈퇴</a>
                        </li>
                    </c:when>
                </c:choose>
            </ul>
        </div>
        </div>
    </div>
</nav>
<!-- Masthead-->

<header>
    <div style="padding-top: 109px;"></div>
</header>

<%--<header class="masthead bg-primary text-white text-center" id="green">--%>

<%--    <div class="container d-flex align-items-center flex-column">--%>
<%--        <!-- Masthead Heading-->--%>
<%--        <div class="divider-custom divider-light">--%>
<%--            <div class="divider-custom-line">Mentor와</div>--%>
<%--            <img src="/resources/img/mento.png" width="250" height="150"/>--%>
<%--            <div class="divider-custom-line">Mentee의</div>--%>
<%--        </div>--%>
<%--        <!-- Masthead Subheading-->--%>
<%--        <div class="divider-custom-icon">알려주고&nbsp;<i class="fas fa-star"></i>&nbsp;배워가기</div>--%>
<%--    </div>--%>
<%--</header>--%>
