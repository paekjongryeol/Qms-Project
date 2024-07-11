<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>일정조회</title>
    <meta content="" name="description">
  	<meta content="" name="keywords">
    <!-- Favicons -->
    <link href="/assets/img/favicon.png" rel="icon">
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <!-- Vendor CSS Files -->
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
	<link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
	<link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
	<link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet">
    <style>
        body {
            padding-top: 20px;
            font-family: 'Open Sans', sans-serif;
        }
        .form-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .form-group {
            margin-right: 10px;
        }
        .form-group:last-child {
            margin-right: 0;
        }
        .btn-container {
            margin-left: auto;
        }
        .table th, .table td {
            vertical-align: top;
            text-align: left;
        }
        .calendar-table th {
            background-color: #87CEEB; /* 하늘색 */
            color: #fff; /* 글자 색상 */
        }
        .calendar-table td {
            width: 14.28%;
            height: 120px; /* 날짜 칸의 높이 증가 */
            padding: 10px;
            border: 1px solid #ddd;
        }
        .calendar-table td.schedule-cell {
            background-color: #f0f8ff; /* 연한 하늘색 */
        }

        
        .modal-body .form-group .form-control {
            display: inline-block; /* 인라인 블록으로 설정 */
            width: 80%; /* 입력 필드의 너비를 100%로 설정 */
        }

        .modal-body .btn {
            display: inline-block;
            width: 30%; /* 버튼의 너비를 100%로 설정 */
        }

        .modal-footer {
            display: flex; /* Flexbox 레이아웃 */
            justify-content: flex-end; /* 버튼을 오른쪽으로 정렬 */
            padding: 1rem 1.5rem; /* 패딩 조절 */
        }

        .modal-footer .btn {
            margin-left: 10px; /* 버튼 사이의 공간 */
        }

    </style>
</head>
<body>
    <%@ include file="../layout/menu.jsp" %>
	<%@ include file="../layout/footer.jsp" %>
    <form id="searchform" class="container" method="POST" action="/myCode/selectScheduleInfo">
        <div class="form-row">
            <div class="form-group col-sm-2">
                <label for="scheduleYear">년</label>
                <select class="form-control" name="scheduleYear" id="scheduleYear">
                    <% 
                    int currentYear = java.time.Year.now().getValue(); // 현재 연도 가져오기
                    int pastYears = 20; // 과거 연도 범위
                    for (int year = currentYear; year >= currentYear - pastYears; year--) { 
                    %>
                    <option value="<%= year %>"><%= year %>년</option>
                    <% } %>
                </select>
            </div>
            <div class="form-group col-sm-2">
                <label for="scheduleMonth">월</label>
                <select class="form-control" name="scheduleMonth" id="scheduleMonth">
                    <option value="01">1월</option>
                    <option value="02">2월</option>
                    <option value="03">3월</option>
                    <option value="04">4월</option>
                    <option value="05">5월</option>
                    <option value="06">6월</option>
                    <option value="07">7월</option>
                    <option value="08">8월</option>
                    <option value="09">9월</option>
                    <option value="10">10월</option>
                    <option value="11">11월</option>
                    <option value="12">12월</option>
                </select>
            </div>
            <div class="form-group col-sm-2 btn-container">
                <button type="button" class="btn btn-info" onclick="scheduleSearch();">조회</button>           
            </div>
        </div>
        <div id="calendar" class="calendar">
            <table class="table table-bordered calendar-table" id="scheduleTable">
                <thead class="thead-light" id="scheduleTableHead">
                    <tr id="dateHeaderRow">
                        <th scope="col">일</th>
                        <th scope="col">월</th>
                        <th scope="col">화</th>
                        <th scope="col">수</th>
                        <th scope="col">목</th>
                        <th scope="col">금</th>
                        <th scope="col">토</th>                  
                    </tr> 
                </thead>
                <tbody id="scheduleTableBody">
                    <!-- 달력이 여기에 동적으로 추가됩니다 -->
                </tbody>
            </table>
        </div>
    </form>
    
    <!-- 모달 HTML 시작 -->
	<div class="modal fade" id="scheduleModal" tabindex="-1" role="dialog" aria-labelledby="scheduleModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-xl" role="document"> <!-- modal-lg 클래스로 모달 크기 확대 -->
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="scheduleModalLabel">일정상세</h5>
	            </div>
	            <form id="scheduleModalForm">	            
	                <div class="modal-body">
	                    <div class="form-group row">
	                        <label for="scheduleDt" class="col-sm-2 col-form-label">일자</label>
	                        <div class="col-sm-4">
	                            <input type="date" class="form-control" id="scheduleDt" name="scheduleDt">
	                        </div>
	                        <div class="form-group col-sm-4 btn-container">
	                            <button type="button" id="btnSearch" class="btn btn-primary" onclick="scheduleDetailSearch();">조회</button>
	                            <button type="button" id="btnSave" class="btn btn-warning" onclick="scheduleUpdate();">저장</button> 
	                        </div>
	                    </div>
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="scheduleModalLabel">상세일정</h5>
	                        <div class="form-group col-sm-4 btn-container">
	                            <button type="button" id="btnAdd" class="btn btn-primary" onclick="schedulePlus();">+</button>
	                        </div>
	                    </div>
	                    <div id="calendarModal" class="calendarModal">
	                        <table class="table table-bordered calendar-table" id="scheduleTable">
	                            <thead class="thead-light" id="scheduleTableHead">
	                                <tr id="dateHeaderRow">
	                                    <th scope="col">시작일시</th>
	                                    <th scope="col">종료일시</th>
	                                    <th scope="col">일정</th>
	                                    <th scope="col">상태</th>
	                                    <th scope="col">삭제</th>                                       
	                                </tr> 
	                            </thead>
	                            <tbody id="scheduleModalTableBody">
	                                <!-- 달력이 여기에 동적으로 추가됩니다 -->
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	<!-- 모달 HTML 끝 -->


    <!-- 필요한 스크립트 파일 로드 -->
    <script src="/assets/js/jquery-3.7.1.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/js/main.js"></script>
	<script src="/assets/js/common.js"></script>
    <script>

    
    function inBox() {
        var now = new Date();
        var year = now.getFullYear();
        var month = ('0' + (now.getMonth() + 1)).slice(-2); // 두 자리로 표시되도록 포맷팅
        
        $('#scheduleYear').val(year);
        $('#scheduleMonth').val(month);

        call_server(searchform, "/myCode/selectScheduleInfo", updateTableHeader);
    }

    inBox();
   
    function scheduleSearch() {
        call_server(searchform, "/myCode/selectScheduleInfo", updateTableHeader);
    }
    
    function updateTableHeader(data) {
        vo = data;
        var year = $('#scheduleYear').val();
        var month = $('#scheduleMonth').val();
        var date = new Date(year, month, 0); // 해당 월의 마지막 날 계산
        var lastDay = date.getDate();
        var firstDay = new Date(year, month - 1, 1).getDay(); // 첫 날의 요일 계산 (0=일요일, 1=월요일, ... 6=토요일)
        
        var scheduleTableBody = $('#scheduleTableBody');
        scheduleTableBody.empty();  // 기존 테이블 내용 비우기

        var row = $('<tr>');
        for (var i = 0; i < firstDay; i++) {
            row.append('<td></td>'); // 첫 날 이전의 빈 칸 추가
        }

        for (var day = 1; day <= lastDay; day++) {
            var dayStr = ('0' + day).slice(-2);  // 날짜를 두 자리 문자열로 포맷팅
            var dateStr = year + '-' + ('0' + month).slice(-2) + '-' + dayStr; // yyyy-mm-dd 형식으로 변환

            row.append('<td id="day-' + dayStr + '" data-date="' + dateStr + '">' + day + '</td>');

            if ((firstDay + day) % 7 === 0) {
                scheduleTableBody.append(row);
                row = $('<tr>');  // 새 행 생성
            }
        }

        if (row.children().length > 0) {
            // 마지막 행의 빈 칸 추가
            for (var i = (firstDay + lastDay) % 7; i < 7 && i > 0; i++) {
                row.append('<td></td>');
            }
            scheduleTableBody.append(row);
        }

        // 일정들을 테이블에 추가
        addSchedules(vo.scheduleList);

        // 날짜 클릭 이벤트 추가
        $('#scheduleTableBody td[data-date]').on('click', function() {
            var date = $(this).data('date');  // 클릭한 날짜 가져오기
            scheduleDetail(date);  // 모달을 띄우는 함수 호출
        });
    }
    function addSchedules(schedules) {
        var scheduleCounts = {};
        for (var i = 0; i < schedules.length; i++) {
            var schedule = schedules[i];
            var startDate = new Date(schedule.startTime);
            var endDate = new Date(schedule.endTime);
            var startDay = startDate.getDate();
            var endDay = endDate.getDate();
            var startMonth = startDate.getMonth() + 1;  // getMonth()는 0부터 시작하므로 1을 더함
            var endMonth = endDate.getMonth() + 1;
            var startYear = startDate.getFullYear();
            var endYear = endDate.getFullYear();
            var title = schedule.title;
            var color = schedule.timeCd === '02' ? 'red' : 'blue'; // '02'이면 빨간색, '01'이면 파란색

            // 시작일과 종료일을 포함한 모든 날짜에 일정을 추가
            for (var d = startDate; d <= endDate; d.setDate(d.getDate() + 1)) {
                var dayStr = ('0' + d.getDate()).slice(-2);
                var monthStr = ('0' + (d.getMonth() + 1)).slice(-2);
                var dateStr = d.getFullYear() + '-' + monthStr + '-' + dayStr;
                var dayCell = $('#day-' + dayStr);

                if (!scheduleCounts[dateStr]) {
                    scheduleCounts[dateStr] = 1;
                } else {
                    scheduleCounts[dateStr]++;
                }

                // 일정이 있는 셀에 클래스를 추가하고 일정을 표시
                var scheduleText = (scheduleCounts[dateStr] > 1 ? scheduleCounts[dateStr] + '. ' : '') + title;
                if (dayCell.length > 0) {
                    dayCell.addClass('schedule-cell');
                    dayCell.append(
                        '<div style="color: ' + color + ';">' +
                        scheduleCounts[dateStr] + '. ' + schedule.title +
                        '</div>'
                    );
                }
            }
        }
    }

    function scheduleDetail(date) {
        $('#scheduleDt').val(date); // 모달의 날짜 필드에 날짜를 설정
        
        // 모달 창을 여는 코드
        $('#scheduleModal').modal('show');
        
        // 일정 상세 검색을 수행
        scheduleDetailSearch(date);
    }
    function scheduleDetailSearch() {    
    	call_server(scheduleModalForm, "/myCode/selectScheduleData", scheduleModalListSearch)
    }
    
    function scheduleModalListSearch(data) {
        vo = data; // 함수 호출 시 전달된 데이터를 글로벌 변수 vo에 저장
        $('#scheduleModalTableBody').empty();
        var list = vo.scheduleModalList;  // 일정 목록
        var comNameList = vo.scheduleComboBox;  // 셀렉트 박스 옵션 목록
        var scheduleSeq = vo.scheduleSeq;  // scheduleSeq 값을 가져옴

        // 리스트의 각 항목을 순회하며 테이블의 행을 생성
        for (var i = 0; i < list.length; i++) {
            var item = list[i];

            // 시간과 분을 추출
            var startDate = item.startTime.split(" ")[0];
            var startTime = item.startTime.split(" ")[1];
            var startHour = startTime.split(":")[0];
            var startMinute = startTime.split(":")[1];

            var endDate = item.endTime.split(" ")[0];
            var endTime = item.endTime.split(" ")[1];
            var endHour = endTime.split(":")[0];
            var endMinute = endTime.split(":")[1];

            // 날짜와 시간, 분을 셀렉트 박스와 input에 삽입
            var str = "<tr>";

            str += '<td>';
            str += '<input type="date" class="form-control" name="schelist[' + i + '].startDate" value="' + startDate + '">';
            str += '<select name="schelist[' + i + '].startHour" class="form-control" style="width:50px; display: inline-block; margin-right: 5px;">';
            for (var h = 9; h < 19; h++) {  // 9시부터 18시까지
                var hour = h < 10 ? '0' + h : h;
                var selected = (hour == startHour) ? ' selected' : '';  // 'selected' 변수 추가
                str += '<option value="' + hour + '"' + selected + '>' + hour + '</option>';
            }
            str += '</select>';
            str += '<select name="schelist[' + i + '].startMinute" class="form-control" style="width:50px; display: inline-block;">';
            for (var m = 0; m < 60; m += 10) { // 10분 단위로 생성
                var minute = m < 10 ? '0' + m : m;
                var selected = (minute ==startMinute) ? ' selected' : '';  // 'selected' 변수 추가
                str += '<option value="' + minute + '"' + selected + '>' + minute + '</option>';
            }
            str += '</select>';
            str += '</td>';

            str += '<td>';
            str += '<input type="date" class="form-control" name="schelist[' + i + '].endDate" value="' + endDate + '">';
            str += '<select name="schelist[' + i + '].endHour" class="form-control" style="width:50px; display: inline-block; margin-right: 5px;">';
            for (var h = 9; h < 19; h++) {  // 9시부터 18시까지
                var hour = h < 10 ? '0' + h : h;
                var selected = (hour == endHour) ? ' selected' : '';  // 'selected' 변수 추가
                str += '<option value="' + hour + '"' + selected + '>' + hour + '</option>';
            }
            str += '</select>';
            str += '<select name="schelist[' + i + '].endMinute" class="form-control" style="width:50px; display: inline-block;">';
            for (var m = 0; m < 60; m += 10) { // 10분 단위로 생성
                var minute = m < 10 ? '0' + m : m;
                var selected = (minute == endMinute) ? ' selected' : '';  // 'selected' 변수 추가
                str += '<option value="' + minute + '"' + selected + '>' + minute + '</option>';
            }
            str += '</select>';
            str += '</td>';

            // 콘텐츠 추가
            str += '<td><input type="text" style="width:250px;" class="form-control" name="schelist[' + i + '].title" value="' + item.title + '"></td>';

            // 셀렉트 박스에 옵션 추가
            str += '<td><select name="schelist[' + i + '].timeCd" class="form-control">';
            for (var j = 0; j < comNameList.length; j++) {
                var option = comNameList[j];
                var selected = (option.comName === item.comName) ? 'selected' : '';
                str += '<option value="' + option.timeCd + '" ' + selected + '>' + option.comName + '</option>';
            }
            str += '</select></td>';

            // scheduleSeq 추가
            str += '<input type="hidden" name="schelist[' + i + '].scheduleSeq" value="' + item.scheduleSeq + '">';

            str += '<td><button type="button" class="btn btn-danger" onclick="removeItem(this)" style="width:80px;">삭제</button></td>';
            str += '</tr>';

            $('#scheduleModalTableBody').append(str);
        }
    }


    function schedulePlus() {
        var newRow = '<tr>';

        // scheduleSeq 추가
        newRow += '<input type="hidden" name="scheduleSeq" value="' + vo.scheduleSeq + '">';

        // startDate, startHour, startMinute
        newRow += '<td>';
        newRow += '<input type="date" class="form-control" name="schelist[' + $('.schedule-modal-table tbody tr').length + '].startDate">';
        newRow += '<select name="schelist[' + $('.schedule-modal-table tbody tr').length + '].startHour" class="form-control" style="width:50px; display: inline-block; margin-right: 5px;">';
        for (var h = 9; h <= 18; h++) { // 9시부터 18시까지
            var hour = h < 10 ? '0' + h : h;
            newRow += '<option value="' + hour + '">' + hour + '</option>';
        }
        newRow += '</select>';
        newRow += '<select name="schelist[' + $('.schedule-modal-table tbody tr').length + '].startMinute" class="form-control" style="width:50px; display: inline-block;">';
        for (var m = 0; m < 60; m += 10) { // 10분 단위로 생성
            var minute = m < 10 ? '0' + m : m;
            newRow += '<option value="' + minute + '">' + minute + '</option>';
        }
        newRow += '</select>';
        newRow += '</td>';

        // endDate, endHour, endMinute
        newRow += '<td>';
        newRow += '<input type="date" class="form-control" name="schelist[' + $('.schedule-modal-table tbody tr').length + '].endDate">';
        newRow += '<select name="schelist[' + $('.schedule-modal-table tbody tr').length + '].endHour" class="form-control" style="width:50px; display: inline-block; margin-right: 5px;">';
        for (var h = 9; h <= 18; h++) { // 9시부터 18시까지
            var hour = h < 10 ? '0' + h : h;
            newRow += '<option value="' + hour + '">' + hour + '</option>';
        }
        newRow += '</select>';
        newRow += '<select name="schelist[' + $('.schedule-modal-table tbody tr').length + '].endMinute" class="form-control" style="width:50px; display: inline-block;">';
        for (var m = 0; m < 60; m += 10) { // 10분 단위로 생성
            var minute = m < 10 ? '0' + m : m;
            newRow += '<option value="' + minute + '">' + minute + '</option>';
        }
        newRow += '</select>';
        newRow += '</td>';

        // title
        newRow += '<td><input type="text" style="width:250px;" class="form-control" name="schelist[' + $('.schedule-modal-table tbody tr').length + '].title"></td>';

        // comName select box
        newRow += '<td><select name="schelist[' + $('.schedule-modal-table tbody tr').length + '].timeCd" class="form-control">';
        var comNameList = vo.scheduleComboBox; // 글로벌 변수 vo를 참조
        for (var j = 0; j < comNameList.length; j++) {
            var option = comNameList[j];
            newRow += '<option value="' + option.timeCd + '">' + option.comName + '</option>';
        }
        newRow += '</select></td>';

        // delete button
        newRow += '<td><button type="button" class="btn btn-danger" onclick="removeItem(this)" style="width:80px;">삭제</button></td>';
        newRow += '</tr>';

        $('#scheduleModalTableBody').append(newRow);
    }

    
    function removeItem(button) {
  	    $(button).closest('tr').remove();
  	}
	
    function scheduleUpdate() {
    	call_server(scheduleModalForm, "/myCode/updateScheduleInfo", saveAram)
    }
    
    function saveAram(cnt) {
    	if(cnt > 0){
    		alert("일정이 등록되었습니다.");
    	}else{
			alert("오류가 발생했습니다.");
    	}
    }
    </script>
</body>
</html>
