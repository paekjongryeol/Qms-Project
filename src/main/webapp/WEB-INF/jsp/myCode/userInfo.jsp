<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>사용자 관리 - NiceAdmin Bootstrap 템플릿</title>

    <!-- Favicons -->
    <link href="/assets/img/favicon.png" rel="icon">
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
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
    <!-- Template Main JS File -->
    <script src="/assets/js/common.js"></script>
    <script src="/assets/js/jquery-3.7.1.js"></script>
    <script src="/assets/js/main.js"></script>
    <script src="/assets/js/paging.js"></script>
    
    <style>
        body {
            padding-top: 20px;
            font-family: 'Open Sans', sans-serif;
        }
        .form-row {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .plan-date-group {
            display: flex;
            align-items: center;
            z-index: 999;
            position: relative;
            background-color: white;
            padding: 10px;
            margin-bottom: 20px;
        }
        .plan-date-group label {
            margin-right: 10px;
        }
        .plan-date-group .form-control {
            width: 150px;
        }
        .center-button {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .menu {
            position: relative;
            z-index: 1;
        }
        .row.mb-2 .col-sm-2 {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>
    <%@ include file="../layout/menu.jsp" %>
    <%@ include file="../layout/footer.jsp" %>
    <form id="searchform" class="container">
    <input type='hidden' id='currentPage' name='currentPage'>
        <div class="plan-date-group">
            <label for="joinDtFrom" class="col-form-label">등록일</label>
            <input type="date" class="form-control" id="joinDtFrom" name="joinDtFrom">
            <label for="joinDtTo" class="col-form-label text-center">~</label>
            <input type="date" class="form-control" id="joinDtTo" name="joinDtTo">
            <label for="userName" class="col-form-label">사용자명</label>
            <input type="text" class="form-control" name="userName">
            <label for="LeaveYn" class="col-form-label">퇴사여부</label>
            <select id="LeaveYn" name="LeaveYn" class="form-control">
                <option value="">===선택===</option>
                <option value="Y">Y</option>
                <option value="N">N</option>
            </select>
            <div class="col-sm-2">
                <button type="button" class="btn btn-info btn-block" onclick="userSearch();">조회</button>
                <button type="button" class="btn btn-dark" onclick="userNew();">신규</button>
            </div>
        </div>
        <!-- 유저리스트 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered" id="userTable">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">사용자ID</th>
                            <th scope="col">사용자명</th>
                            <th scope="col">부서</th>
                            <th scope="col">직위</th>
                            <th scope="col">전화번호</th>
                            <th scope="col">이메일</th>
                            <th scope="col">퇴사여부</th>
                            <th scope="col">퇴사일</th>
                            <th scope="col">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 여기에 유저 데이터를 동적으로 추가합니다. -->
                    </tbody>
                </table>
            </div>
        </div>
        <nav aria-label="Page navigation example">
            <ul class="pagination" id="userPaging">
            </ul>
        </nav>
    </form>

    <!-- 모달 HTML 시작 -->
    <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userModalLabel">신규 사용자 등록/수정</h5>                    
                	</div>
				        <div class="modal-body">
				    		<form id="newUserForm">                 
				        <div class="form-group">
				            <label for="userIdPop">사용자 ID</label>
				            <input type="text" class="form-control" id="userId" name="userId">
				        </div>
				        <div class="form-group">
				            <label for="userNamePop">사용자명</label>
				            <input type="text" class="form-control" id="userName" name="userName">
				        </div>
				        <div class="form-group">
				            <label for="firstUserPwdPop">비밀번호</label>
				            <input type="password" class="form-control" id="userPwd" name="userPwd">
				        </div>
				        <div class="form-group">
				            <label for="secUserPwdPop">비밀번호 확인</label>
				            <input type="password" class="form-control" id="secUserPwd">
				        </div>
				        <div class="form-group">
				            <label for="comNamePop">직위</label>
				            <select id="comName" name="comName" class="form-control">
				                <option value="">===선택===</option>
				            </select>
				        </div>
				        <div class="form-group">
				            <label for="deptNamePop">부서</label>
				            <select id="deptName" name="deptName" class="form-control">
				                <option value="">===선택===</option>
				            </select>
				        </div>
				        <div class="form-group">
				            <label for="phonePop">연락처</label>
				            <input type="text" class="form-control" id="phone" name="phone">
				        </div>
				        <div class="form-group">
				            <label for="emailPop">이메일</label>
				            <input type="email" class="form-control" id="email" name="email">
				        </div>
				        <div class="form-group">
				            <label for="leaveYnPop">퇴사여부</label>
				            <select id="leaveYn" name="leaveYn" class="form-control">
				                <option value="">===선택===</option>
				                <option value="Y">Y</option>
				                <option value="N">N</option>
				            </select>
				        </div>
				        <div class="form-group">
				            <label for="leaveDtPop">퇴사일</label>
				            <input type="date" class="form-control" id="leaveDt" name="leaveDt">
				        </div>                     
				    </form>
				</div>
                <div class="modal-footer">                    
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" id='btnUpdate' class="btn btn-secondary" data-bs-dismiss="modal" onclick='userUpdate();'>저장</button> <!-- 수정 -->
        			<button type="button" id='btnInsert' class="btn btn-secondary" data-bs-dismiss="modal" onclick='userInsert();'>저장</button> <!-- 등록 -->
                </div>
            </div>
        </div>
    </div>
    <!-- 모달 HTML 끝 -->

    <script>
    function userSearch(no) {
        if (no === undefined) {
            $('#currentPage').val(1);
        } else {
            $('#currentPage').val(no);
        }
        call_server(searchform, "/myCode/userList", userList);
    }

    function userList(vo) {
        list = vo.userList;
        // 기존 데이터 초기화
        $('#userTable tbody').empty();
        // 리스트의 각 항목을 순회하며 테이블 행 생성
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            var str = "<tr onclick=\"userDetail('" + item.userId + "');\" style=\"cursor:pointer;\">";
            str += "<th scope=\"row\">" + ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1)) + "</th>";
            str += '<td>' + item.userId + '</td>';
            str += '<td>' + item.userName + '</td>';
            str += '<td>' + item.deptName + '</td>';
            str += '<td>' + item.comName + '</td>'; 
            str += '<td>' + item.phone + '</td>'; 
            str += '<td>' + item.email + '</td>'; 
            str += '<td>' + item.leaveYn + '</td>'; 
            str += '<td>' + (item.leaveDt || '') + '</td>'; 
            str += '<td>' + item.regDt + '</td>'; 
            str += '</tr>';
            $('#userTable tbody').append(str);
        }
        setPaging(userPaging, vo.startPage, vo.endPage, 'userSearch');
    }
    
    function userDetail(id) {
        $('#userId').val(id);
        call_server(newUserForm, "/myCode/userPopup", userPopup);
    }

    
    function userPopup(vo) {
    	
        $('#userId').val(vo.userId);
        $('#userName').val(vo.userName);
        $('#userPwd').val(vo.userPwd);
        $('#secUserPwd').val(vo.userPwd);
        
        $('#comName').val(vo.comCd);
        $('#deptName').val(vo.deptCd);
        
        //setComCombData(vo.comList, comName);
        //setDeptCombData(vo.deptList, deptName);
        $('#phone').val(vo.phone);
        $('#email').val(vo.email);
        $('#leaveYn').val(vo.leaveYn);
        // leaveDt 값이 datetime 형식이면, 날짜 부분만 추출하여 설정
        if (vo.leaveDt) {
            var leaveDate = vo.leaveDt.split(' ')[0]; // 날짜 부분 추출
            $('#leaveDt').val(leaveDate); // yyyy-mm-dd 형식으로 설정
        } else {
            $('#leaveDt').val(''); // 퇴사일이 없는 경우 빈 값으로 설정
        }
        
        $('#btnUpdate').show();                //업데이트 버튼 표시
        $('#btnInsert').hide();                //신규 등록 버튼 숨김
        $('#userModal').modal('show');
    }

    // 선택 목록을 설정하는 함수
    function setComCombData(list, id) {
        var select = $(id);
        select.empty(); // 기존 옵션 제거
        for (var i = 0; i < list.length; i++) {
            var str = "<option value='" + list[i].comCd + "'>" + list[i].comName + "</option>";
            $(id).append(str);
        }
    }
    
    // 선택 목록을 설정하는 함수
    function setDeptCombData(list, id) {
        var select = $(id);
        select.empty(); // 기존 옵션 제거
        for (var i = 0; i < list.length; i++) {
            var str = "<option value='" + list[i].deptCd + "'>" + list[i].deptName + "</option>";
            $(id).append(str);
        }
    }

    function userNew() {
        // 모달 내 입력 필드 초기화
        $('#userId, #userName, #userPwd, #comName, #deptName, #secUserPwd, #phone, #email, #leaveYn, #leaveDt').val('');
        
        
        $('#btnUpdate').hide();                //업데이트 버튼 숨김
        $('#btnInsert').show();                //신규 등록 버튼 표시
        $('#userModal').modal('show');         // 모달 표시
    }

    function userInsert() {
        call_server(newUserForm, "/myCode/insertUserInfo", saveAram1)
        // 저장 로직 추가
        $('#userModal').modal('hide');
    }
    
    function userUpdate() {
        call_server(newUserForm, "/myCode/updateUserInfo", saveAram2)
        // 저장 로직 추가
        $('#userModal').modal('hide');
    }
    
    function saveAram1(cnt) {
        if (cnt > 0) {
            alert("신규 사원이 등록되었습니다.")
        } else {
            alert("오류가 발생했습니다.")
        }
    }
    
    function saveAram2(cnt) {
        if (cnt > 0) {
            alert("사원 정보가 변경되었습니다.")
        } else {
            alert("오류가 발생했습니다.")
        }
    }
    
    function init(){
    	call_server(newUserForm, "/myCode/initPopup", initPopup);
    }
    
    
    function initPopup(vo){
    	setComCombData(vo.comList, comName);
        setDeptCombData(vo.deptList, deptName);
    }
    
    
    
    init();
</script>

    <!-- Bootstrap JS 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
                            