$(function() {
    $('input[name="studyPeriod"]').daterangepicker({
        autoUpdateInput: false,
        minDate: new Date(),
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


function addCreerList() {
    const addstr = document.getElementById('addCareer');
    const li = document.createElement('li');
    const input = document.createElement('input');
    const del = document.createElement('a');

    //<input type="hidden" name="tempCareer" value=add.value>
    input.setAttribute('type','hidden');
    input.setAttribute('name','tempCareer');
    input.setAttribute('value',addstr.value);

    //<a id="delByn">삭제</a>
    del.append("삭제");
    del.setAttribute('id','delBtn');
    del.addEventListener("click", delAct);

    //<p>str<input type="hidden" name="tempCareer" value=add.value><a>삭제</a></p>
    const str = document.createTextNode(addstr.value);
    li.appendChild(str);
    li.append(" ");
    li.appendChild(input);

    document.getElementById('careerList').appendChild(li).appendChild(del);
    addstr.value=""; //추가 후 input 비우기
};

//호출한 라인 삭제
function delAct(event){
    const removeLine = event.target.parentElement;
    removeLine.remove();
}

//입력값이 잘못된 경우 false를 리턴.
function doCheck(){
    let enWeekly = document.querySelectorAll("input[type=checkbox][name=studyWeekly]:checked"); //체크된 요일리스트 불러오기
    if(document.getElementById("studyTitle").value.length == 0){
        alert('스터디 이름을 입력해주세요.')
        document.getElementById("studyTitle").focus();
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

    else if(document.getElementById('studyStartTime').value.length == 0){
        alert('스터디 시작 시간을 입력해주세요.');
        document.getElementById('studyStartTime').focus();
        return false;
    }

    else if(document.getElementById('studyEndTime').value.length == 0){
        alert('스터디 종료 시간을 입력해주세요.');
        document.getElementById('studyEndTime').focus();
        return false;
    }

    else if(document.getElementById('studyEndTime').value < document.getElementById('studyStartTime').value){
        alert('스터디 종료 시간은 스터디 시작 시간보다 빠를 수 없습니다.');
        document.getElementById('studyStartTime').focus();
        return false;
    }

    else if(document.getElementById("studyCapacity").value.length == 0){
        alert('모집인원을 입력해주세요.');
        document.getElementById("studyCapacity").focus();
        return false;
    }

    else if(document.getElementById("studyContent").value.length == 0){
        alert('상세설명을 입력해주세요.');
        document.getElementById("studyContent").focus();
        return false;
    }else{return lastCheck();}

}

function lastCheck() {
    if (confirm("스터디를 등록하시겠습니까?") == true){    //확인
        return true;
    }else{   //취소
        return false;
    }
}
