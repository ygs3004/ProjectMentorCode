<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="/resources/js/study/study-modify-scripts.js?ver=1"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/study/study-styles.css">
<form action="/study/update" method="POST" name="createForm" id="createForm" onsubmit="return doCheck()">
    <section class="formHeader">
        <span id="formTitle"><b>스터디 정보 수정</b></span>
        <p id="formDes">스터디 정보를 수정하는 페이지입니다.</p>
    </section>
    <div class="shadow p-3 mb-5 bg-white rounded formBody">
        <div class="user_name">
            <span> ${loginUser.getUserName()} 님 (${loginUser.getUserId()})</span>
        </div>
        <div class="useMove">
            <input type="text" class="form-control" id="title" name="studyTitle" value="${study.studyTitle}" autocomplete="on">
            <label for="title"><span>스터디 이름</span></label>
        </div>
        <div class="useMove">
            <input type="text" class="form-control" id="studyPeriod" name="studyPeriod" value="${study.studyPeriod}">
            <label for="studyPeriod"><span>스터디 기간</span></label>
        </div>
        <div class="notMove">
            <div style="display: flex;justify-content: space-between;">
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="mon" value="1">
                    <label class="btn btn-outline-primary studyWeekly" for="mon">월</label>
                </div>
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="tue" value="2">
                    <label class="btn btn-outline-primary studyWeekly" for="tue">화</label>
                </div>
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="wed" value="3">
                    <label class="btn btn-outline-primary studyWeekly" for="wed">수</label>
                </div>
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="thur" value="4">
                    <label class="btn btn-outline-primary studyWeekly" for="thur">목</label>
                </div>
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="fri" value="5">
                    <label class="btn btn-outline-primary studyWeekly" for="fri">금</label>
                </div>
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="sat" value="6">
                    <label class="btn btn-outline-primary studyWeekly" for="sat">토</label>
                </div>
                <div>
                    <input type="checkbox" class="btn-check" name="tempWeekly" id="sun" value="7">
                    <label class="btn btn-outline-primary studyWeekly" for="sun">일</label>
                </div>
            </div>
        </div>
        <div style="display: flex; justify-content: space-between;">
            <div class="useMove">
                <div><input type="time" class="form-control" id="studyTimeStart" name="studyStartTime" value="${study.studyStartTime}">
                    <label for="studyTimeStart"><span>스터디 시간</span></label></div>
            </div>
            <div class="useMove">
                <input type="time" class="form-control" id="studyTimeEnd" name="studyEndTime" value="${study.studyEndTime}">
                <label for="studyTimeEnd"><span>스터디 종료 시간</span></label>
            </div>
        </div>
        <div class="useMove">
            <input type="number" class="form-control" id="capacity" name="studyCapacity" value="${study.studyCapacity}" min="1" max="30">
            <label for="capacity"><span>모집인원</span></label>
        </div>
        <div class="notMove">
            <input type="number" class="form-control" id="nowCapacity" name="studyNowCapacity" value="${study.studyNowCapacity}" readonly>
            <label for="nowCapacity"><span class="block">현재인원</span></label>
        </div>
        <div class="desc">
            <span> * 최대인원 30명</span>
        </div>
        <div style="display: flex;justify-content: space-between;">
            <div class="useMove">
                <input type="text" class="form-control" id="addCareer">
                <label for="addCareer"><span>멘토 경력</span></label>
            </div>
            <input type="button" class="form-control btn-outline-primary" id="addList" value="add" onclick="addCreerList()">
        </div>
        <ul id="careerList" style="padding-left:0px; line-height: 25px; list-style:none; font-size: 15px;">
            <c:choose>
                <c:when test="${study.getTempCareer() eq null}">
                </c:when>
                <c:otherwise>
                    <c:forEach var="careers" items="${study.getTempCareer()}" varStatus="status">
                        <li><c:out value="${careers}"/> <input type="hidden" name="tempCareer" value="${careers}"> <a id="delBtn" onclick="delAct()" >삭제</a></li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </ul>
        <div class="notMove">
            <input type="text" class="form-control" id="school" name="studySchool" value="${loginUser.getUserSchool()}" readonly>
            <label for="school"><span class="block">멘토 학력</span></label>
        </div>
        <div>
            <textarea class="form-control" id="content" name="studyContent" rows="15" style="resize: none;" >${study.studyContent}</textarea>
            <label for="content"><span class="content">스터디 상세설명</span></label>
        </div>

        <div style="text-align: center; margin-bottom: 2%;">
            <button id="formCheck" type="submit" class="btn btn-primary">스터디수정</button>
            &nbsp;<input type="button" class="btn btn-primary" value="수정취소" onclick="history.back();">
            &nbsp;<input type="button" class="btn btn-danger" value="스터디삭제" onclick="delCheck()">
        </div>
    </div>
    </div>
</form>

<%@ include file="../includes/footer.jsp"%>