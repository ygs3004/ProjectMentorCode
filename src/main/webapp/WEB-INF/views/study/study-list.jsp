<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="/resources/css/study/studylist-styles.css">
<%--<link rel="stylesheet" type="text/css" href="/resources/js/study/study-list-scripts.js">--%>
<style>
	.nowPageLocation{
		color:blue;
	}
	a{
		cursor:pointer;
	}
</style>
<script>
  let weekarr = {
    "1":"월", "2":"화", "3":"수", "4":"목", "5":"금", "6":"토", "7":"일"
  }

  $(document).ready(function()  {
    getlists()
  })

  function getlists(page) {
	if(!page){
		page = 1;
	}
    const data = {
      page: page,
      pageSize: 9
    }
    $.ajax({
      url: "/study/getstudylist",
      type: "get",
      data : data,
      accept: "application/json",
      success: function(res) {
		  console.log(res);
        let html ='';
        const studies = res.list;
        for(const study of studies){
          console.log(study);
          // if(study.studyWeekly){
	      //     for(let weekly of studys.studyWeekly){
	      //         weekly.replace(weekarr);
	      //     }
          // }
          html += '<div class="shadow rounded cardlist">' +
                '<div class="card-body">' +
                '<span id="studyTitle"> '+ study.studyTitle + '</span>' +
                '<p id="studyContent" style="margin-top:5%; margin-bottom:-4%;">' + study.studyContent +
                '</p> </div> <ul class="list-group list-group-flush">' +
                '<li class="list-group-item">' +
                '<li class="list-group-item" id="studyPeriod"> 기간 : ' + study.studyPeriod +'</li>' +
                '<li class="list-group-item" id="studyWeekly">' + study.studyWeekly + '</li>' +
                '<li class="list-group-item" id="studyCapacity">모집인원 : ' + study.studyNowCapacity +'/'+ study.studyCapacity + '</li></ul>'+
                '<div class="card-body"> <a type="button" class="btn btn-primary" onclick="goStudyView(' + study.studyNum +')">상세보기</a> &nbsp;&nbsp;' +
                '<a type="button" class="btn btn-primary" onclick="sendStudyMsg('+ study.studyNum +') ">신청하기</a> </div> </div>';
        }
        $('#formBody').html(html);
		  let pageHtml = '<li class="page-item">';

		  let nowFirstPage = res.pageNum-(res.pageNum%10)+1;
		  if(res.pageNum%10 == 0) nowFirstPage = res.pageNum-9;
		  let nowLastPage = nowFirstPage+9;

		  if(nowLastPage > res.pages) nowLastPage=res.pages;

		  if(nowFirstPage>1) {
			  pageHtml += '<a class="page-link" aria-label="Previous" onclick="getlists(' + (nowFirstPage-10) + ')">';
			  pageHtml += '<span aria-hidden="true">&laquo;</span>';
			  pageHtml += '</a>';
			  pageHtml += '</li>';
		  }

		  for(let i=nowFirstPage; i<=nowLastPage; i++){

			  if(i === res.pageNum) {
				  pageHtml += '<li class="page-item  nowPageLocation">';
				  pageHtml += '<a class="page-link" onclick="getlists(' + i + ')">' + i + '</a>';
			  }
			  else {
				  pageHtml += '<li class="page-item">';
				  pageHtml += '<a class="page-link" onclick="getlists(' + i + ')">' + i + '</a>';
			  }

			  pageHtml += '</li>';
		  }

		  if(nowLastPage<res.pages) {
			  pageHtml += '<li class="page-item">';
			  if(res.pageNum+10 <= res.pages) pageHtml += '<a class="page-link" aria-label="Next" onclick="getlists(' + (res.pageNum+10) + ')">';
			  else pageHtml += '<a class="page-link" aria-label="Next" onclick="getlists(' + (nowFirstPage+10) + ')">';
			  pageHtml += '<span aria-hidden="true">&raquo;</span>';
			  pageHtml += '</a>';
			  pageHtml += '</li>';
		  }
        $('#pagination').html(pageHtml);
      },
      error: function(errorThrown) {
        alert(errorThrown.statusText);
      }
    })
  };

  function goStudyView(studynum){
    location.href = '/views/study/info?studynum=' + studynum;
  }

  function sendStudyMsg(studynum){
	  location.href = '/views/study/study-sendmsg?studynum=' + studynum;
  }

</script>
<div id="formBody"></div>

<div id="">


</div>
<%--하단 페이징--%>
<div id="pagenav">
	<nav aria-label="Page navigation example">
		<ul class="pagination" id="pagination">
		</ul>
	</nav>
</div>

<%@ include file="../includes/footer.jsp"%>