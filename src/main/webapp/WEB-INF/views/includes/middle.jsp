
<script>
  const weekarr = {
    "1":"mon",
    "mon":"1",
    "2":"tue", "3":"wed", "4":"thur", "5":"fri", "6":"sat", "7":"sun"
  }
  $(document).ready(function() {
    getlists();
  })

  function getlists() {
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
          let cnt =3;
          if(cnt<=3 ){
            html += '<div class="carousel-item">';
          }
          html += '<div class="shadow rounded cardlist">' +
                  '<div class="card-body">' +
                  '<span id="studyTitle"> '+ study.studyTitle + '</span>' +
                  '<p id="studyContent" style="margin-top:5%; margin-bottom:-4%;">' + study.studyContent +
                  '</p> </div> <ul class="list-group list-group-flush">' +
                  '<li class="list-group-item">' +
                  '<li class="list-group-item" id="studyPeriod"> 기간 : ' + study.studyPeriod +'</li>' +
                  '<li class="list-group-item" id="studyWeekly">';
          for(let w of study.tempWeekly){
            html += '<img src="/resources/img/weekly/'+weekarr[w]+'.png" style="weight=20px; height: 20px;"/> &nbsp;' ;
          }
          html += '</li>' +
                  '<li class="list-group-item" id="studyCapacity">모집인원 : ' + study.studyNowCapacity +'/'+ study.studyCapacity + '</li></ul>'+
                  '<div class="card-body"> <a type="button" class="btn btn-primary" onclick="goStudyView(' + study.studyNum +')">상세보기</a> &nbsp;&nbsp;';
          if(${sessionScope.loginUser.userRole == 2}){
            html += '<a type="button" class="btn btn-primary" onclick="sendStudyMsg('+ study.studyNum +') ">신청하기</a> </div></div>';
          }else{
            html +='</div></div>';
          }
          if(cnt <= 3 ){
            html += '</div>';
            cnt--;
          }
          $('#studytable').html(html);
        }
      }
    })
  }
  function goStudyView(studynum){
    location.href = '/study/info?studynum='+studynum;
  };
  function sendStudyMsg(studynum){
    location.href = '/views/study/study-sendmsg?studynum=' + studynum;
  }
</script>

<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner" id="studytable">
  </div>
</div>




