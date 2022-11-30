//  const weekarr = {
//     "1":"mon",
//     "mon":"1",
//     "2":"tue", "3":"wed", "4":"thur", "5":"fri", "6":"sat", "7":"sun"
// }
//     $(document).ready(function()  {
//     getlists()
// })
//
//     function getlists(page) {
//     if(!page){
//     page = 1;
// }
//     const data = {
//     page: page,
//     pageSize: 9
// }
//     $.ajax({
//     url: "/study/getstudylist",
//     type: "get",
//     data : data,
//     accept: "application/json",
//     success: function(res) {
//     console.log(res);
//     let html ='';
//     const studies = res.list;
//     for(const study of studies){
//     html += '<div class="shadow rounded cardlist">' +
//     '<div class="card-body">' +
//     '<span id="studyTitle"> '+ study.studyTitle + '</span>' +
//     '<p id="studyContent" style="margin-top:5%; margin-bottom:-4%;">' + study.studyContent +
//     '</p> </div> <ul class="list-group list-group-flush">' +
//     '<li class="list-group-item">' +
//     '<li class="list-group-item" id="studyPeriod"> 기간 : ' + study.studyPeriod +'</li>' +
//     '<li class="list-group-item" id="studyWeekly">';
//     for(let w of study.tempWeekly){
//     html += '<img src="/resources/img/weekly/'+weekarr[w]+'.png" style="weight=20px; height: 20px;"/> &nbsp;' ;
// }
//     html += '</li>' +
//     '<li class="list-group-item" id="studyCapacity">모집인원 : ' + study.studyNowCapacity +'/'+ study.studyCapacity + '</li></ul>'+
//     '<div class="card-body"> <a type="button" class="btn btn-primary" onclick="goStudyView(' + study.studyNum +')">상세보기</a> &nbsp;&nbsp;';
//     if(${sessionScope.loginUser.userRole == 2}){
//     html += '<a type="button" class="btn btn-primary" onclick="sendStudyMsg('+ study.studyNum +') ">신청하기</a> </div></div>';
// }else{
//     html +='</div></div>';
// }
//
// }
//     $('#formBody').html(html);
//     let pageHtml = '<li class="page-item">';
//
//     let nowFirstPage = res.pageNum-(res.pageNum%10)+1;
//     if(res.pageNum%10 == 0) nowFirstPage = res.pageNum-9;
//     let nowLastPage = nowFirstPage+9;
//
//     if(nowLastPage > res.pages) nowLastPage=res.pages;
//
//     if(nowFirstPage>1) {
//     pageHtml += '<a class="page-link" aria-label="Previous" onclick="getlists(' + (nowFirstPage-10) + ')">';
//     pageHtml += '<span aria-hidden="true">&laquo;</span>';
//     pageHtml += '</a>';
//     pageHtml += '</li>';
// }
//
//     for(let i=nowFirstPage; i<=nowLastPage; i++){
//
//     if(i === res.pageNum) {
//     pageHtml += '<li class="page-item  nowPageLocation">';
//     pageHtml += '<a class="page-link" onclick="getlists(' + i + ')">' + i + '</a>';
// }
//     else {
//     pageHtml += '<li class="page-item">';
//     pageHtml += '<a class="page-link" onclick="getlists(' + i + ')">' + i + '</a>';
// }
//
//     pageHtml += '</li>';
// }
//
//     if(nowLastPage<res.pages) {
//     pageHtml += '<li class="page-item">';
//     if(res.pageNum+10 <= res.pages) pageHtml += '<a class="page-link" aria-label="Next" onclick="getlists(' + (res.pageNum+10) + ')">';
//     else pageHtml += '<a class="page-link" aria-label="Next" onclick="getlists(' + (nowFirstPage+10) + ')">';
//     pageHtml += '<span aria-hidden="true">&raquo;</span>';
//     pageHtml += '</a>';
//     pageHtml += '</li>';
// }
//     $('#pagination').html(pageHtml);
// },
//     error: function(errorThrown) {
//     alert(errorThrown.statusText);
// }
// })
// };
//
//     function goStudyView(studynum){
//     location.href = '/study/info?studynum='+studynum;
// }
//
//     function sendStudyMsg(studynum){
//     location.href = '/views/study/study-sendmsg?studynum=' + studynum;
// }