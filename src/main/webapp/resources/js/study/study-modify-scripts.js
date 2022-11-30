const weekarr = {
    "1":"mon",
    "2":"tue",
    "3":"wed",
    "4":"thur",
    "5":"fri",
    "6":"sat",
    "7":"sun" }

let minPeriod ="";
let beforePeriod ="";
let endPeriod = "";

window.onload =(function() {

    $.ajax({
        url: "/study/getstudy",
        type: "get",
        dataType: "json",
        accept: "application/json",
        success: function(studyInfo) {
            //json -> stringify(String으로 만들기) -> parse(obj로 만들기)
            minPeriod = strTodate((studyInfo.studyPeriod).slice(0,10).replace("/","").replace("/",""));
            endPeriod = strTodate((studyInfo.studyPeriod).slice(13,23).replace("/","").replace("/",""));
            beforePeriod = studyInfo.studyPeriod;

            //일주일 리스트 불러와서 체크
            for(let week of studyInfo.tempWeekly){
                document.getElementById(weekarr[week]).checked=true;
                }
            },
        error: function(errorThrown) {
            alert(errorThrown.statusText);
        }
    });
});

// String to Date
function strTodate(str) {
    var y = str.substr(0, 4);
    var m = str.substr(4, 2);
    var d = str.substr(6, 2);
    return new Date(y,m-1,d);
}
$(function() {
    $('input[name="studyPeriod"]').daterangepicker({
        autoUpdateInput: false,
        minDate: new Date(minPeriod),
        // changeMonth: true,
        locale: {
            format: "YYYY/MM/DD",
            applyLabel :"선택",
            cancelLabel:"취소",
            daysOfWeek:['일','월','화','수','목','금','토'],
            monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        }
    });
    $('input[name="studyPeriod"]').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(picker.startDate.format('YYYY/MM/DD') + ' - ' + picker.endDate.format('YYYY/MM/DD'));
    });
    $('input[name="studyPeriod"]').on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });
});


//career
function addCreerList() {
    const addstr = document.getElementById('addCareer');
    const li = document.createElement('li');
    const input = document.createElement('input');
    const del = document.createElement('a');

    //<input type="hidden" name="carrer" value=add.value>
    input.setAttribute('type',"hidden");
    input.setAttribute('name','tempCareer');
    input.setAttribute('value',addstr.value);

    //<a id="delByn">삭제</a>
    del.append("삭제");
    del.setAttribute('id','delBtn');
    del.addEventListener("click", delAct);

    //<p>str<input type="hidden" name="studyCareer" value=add.value><a>삭제</a></p>
    const str = document.createTextNode(addstr.value);
    li.appendChild(str);
    li.append(" ");
    li.appendChild(input);

    document.getElementById('careerList').appendChild(li).appendChild(del);
    addstr.value=""; //추가 후 input 비우기
};

function delAct(e) {
    const event = e || window.event;
    const targetElement = event.target.parentElement;
    targetElement.remove();
}

//입력값이 잘못된 경우 false를 리턴.
function doCheck(){
    let enWeekly = document.querySelectorAll("input[type=checkbox][name=tempWeekly]:checked"); //체크된 요일리스트 불러오기
    if(document.getElementById("title").value.trim().length == 0){
        alert('스터디 이름을 입력해주세요.')
        document.getElementById("title").focus();
        return false;
    }else if(document.getElementById("studyPeriod").value.length == 0){
        alert('스터디 기간을 입력해주세요.');
        document.getElementById("studyPeriod").focus();
        return false;
    }
    //요일이 선택되었는지 확인
    else if(enWeekly.length == 0 | enWeekly==null){
        alert('요일을 선택해 주세요.');
        return false;
    }

    else if(document.getElementById('studyTimeStart').value.trim().length == 0){
        alert('스터디 시작 시간을 입력해주세요.');
        document.getElementById('studyTimeStart').focus();
        return false;
    }

    else if(document.getElementById('studyTimeEnd').value.trim().length == 0){
        alert('스터디 종료 시간을 입력해주세요.');
        document.getElementById('studyTimeEnd').focus();
        return false;
    }

    else if(document.getElementById('studyTimeEnd').value < document.getElementById('studyTimeStart').value){
        alert('스터디 종료 시간은 스터디 시작 시간보다 빠를 수 없습니다.');
        document.getElementById('studyTimeStart').focus();
        return false;
    }

    else if(document.getElementById("capacity").value.length == 0){
        alert('모집인원을 입력해주세요.');
        document.getElementById("capacity").focus();
        return false;
    }

    else if(document.getElementById("capacity").value < document.getElementById("nowCapacity").value){
        alert('현재 모집된 인원이 수정할 모집인원보다 많습니다.\r 수정할 모집인원은 모집된 인원보다 많아야합니다.');
        document.getElementById("capacity").focus();
        return false;
    }

    else if(document.getElementById("content").value.trim().length == 0){
        alert('상세설명을 입력해주세요.');
        document.getElementById("content").focus();
        return false;
    }else {
        return lastCheck();
    }
}

function lastCheck() {
    if (confirm("스터디 정보를 수정하시겠습니까?") == true){    //확인
        return true;
    }else{   //취소
        return false;
    }
}

function delCheck() {
    if (confirm("스터디를 삭제하시겠습니까?") == true){ //확인
        return location.href='/study/delete';
    }else{
        return false;
    }
}