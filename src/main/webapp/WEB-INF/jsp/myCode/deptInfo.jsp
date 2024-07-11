<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>부서 관리 - NiceAdmin Bootstrap 템플릿</title>

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
            <label for="deptName" class="col-form-label">부서명</label>
            <input type="text" class="form-control" name="deptName">
            <label for="delYn" class="col-form-label">삭제여부</label>
            <select name="delYn" class="form-control">
                <option value="">===선택===</option>
                <option value="Y">Y</option>
                <option value="N">N</option>
            </select>
            <div class="col-sm-2">
                <button type="button" class="btn btn-info btn-block" onclick="deptSearch();">조회</button>
                <button type="button" class="btn btn-dark" onclick="deptNew();">신규</button>
            </div>
        </div>
        <!-- 부서리스트 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered" id="deptTable">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">부서ID</th>
                            <th scope="col">부서명</th>
                            <th scope="col">상위부서명</th>
                            <th scope="col">할당사용자수</th>
                            <th scope="col">사용삭제여부</th>
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
            <ul class="pagination" id="deptPaging">
            </ul>
        </nav>
    </form>

    <!-- 모달 HTML 시작 -->
    <div class="modal fade" id="deptModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deptModalLabel">부서 등록/수정</h5>                    
                	</div>
				        <div class="modal-body">
				    		<form id="newDeptForm">                 
				        <div class="form-group">
				            <label for="deptCdPop">부서코드</label>
				            <input type="text" class="form-control" id="deptCd" name="deptCd">
				        </div>
				        <div class="form-group">
				            <label for="deptNamePop">부서명</label>
				            <input type="text" class="form-control" id="deptName" name="deptName">
				        </div>
				        <div class="form-group">
				            <label for="upDeptCdPop">상위부서</label>
				            <select id="upDeptCd" name="upDeptCd" class="form-control">
				                <option value="">===선택===</option>
				            </select>
				        </div>
				        <div class="form-group">
				            <label for="delYnPop">삭제여부</label>
				            <select id="delYn" name="delYn" class="form-control">
				                <option value="">===선택===</option>
				                <option value="Y">Y</option>
				                <option value="N">N</option>
				            </select>
				        </div>
				    </form>
				</div>
                <div class="modal-footer">                    
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" id='btnUpdate' class="btn btn-secondary" data-bs-dismiss="modal" onclick='deptUpdate();'>저장</button> <!-- 수정 -->
        			<button type="button" id='btnInsert' class="btn btn-secondary" data-bs-dismiss="modal" onclick='deptInsert();'>저장</button> <!-- 등록 -->
                </div>
            </div>
        </div>
    </div>
    <!-- 모달 HTML 끝 -->

    <script>
    function deptSearch(no) {
        if (no === undefined) {
            $('#currentPage').val(1);
        } else {
            $('#currentPage').val(no);
        }
        call_server(searchform, "/myCode/deptList", deptList);
    }

    function deptList(vo) {
        list = vo.deptList;
        // 기존 데이터 초기화
        $('#deptTable tbody').empty();
        // 리스트의 각 항목을 순회하며 테이블 행 생성
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            var str = "<tr onclick=\"deptDetail('" + item.deptCd + "');\" style=\"cursor:pointer;\">";
            str += "<th scope=\"row\">" + ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1)) + "</th>";
            str += '<td>' + item.deptCd + '</td>';
            str += '<td>' + item.deptName + '</td>';
            str += '<td>' + (item.upDeptCd || '') + '</td>';
            str += '<td>' + item.useDept + '</td>'; 
            str += '<td>' + item.delYn + '</td>'; 
            str += '<td>' + item.regDt + '</td>';  
            str += '</tr>';
            $('#deptTable tbody').append(str);
        }
        setPaging(deptPaging, vo.startPage, vo.endPage, 'deptSearch');
    }
    
    function deptDetail(id) {
        $('#deptCd').val(id);
        call_server(newDeptForm, "/myCode/deptPopup", deptPopup);
    }

    
    function deptPopup(vo) {
    	
        $('#deptCd').val(vo.deptCd);
        $('#deptName').val(vo.deptName);
        $('#upDeptCd').val(vo.upDeptCd);
        $('#delYn').val(vo.delYn);

        $('#btnUpdate').show();                //업데이트 버튼 표시
        $('#btnInsert').hide();                //신규 등록 버튼 숨김
        $('#deptModal').modal('show');
    }

    // 선택 목록을 설정하는 함수
    function setUpDeptCdCombData(list, id) {
        var select = $(id);
        select.empty(); // 기존 옵션 제거
        for (var i = 0; i < list.length; i++) {
            var str = "<option value='" + list[i].deptCd + "'>" + list[i].deptName + "</option>";
            $(id).append(str);
        }
    }
    
    function deptNew() {
        // 모달 내 입력 필드 초기화
        $('#deptCd, #deptName, #upDeptCd, #delYn').val('');
        
        
        $('#btnUpdate').hide();                //업데이트 버튼 숨김
        $('#btnInsert').show();                //신규 등록 버튼 표시
        $('#deptModal').modal('show');         // 모달 표시
    }

    function deptInsert() {
        call_server(newDeptForm, "/myCode/insertDeptInfo", saveAram1)
        // 저장 로직 추가
        $('#deptModal').modal('hide');
    }
    
    function deptUpdate() {
        call_server(newDeptForm, "/myCode/updateDeptInfo", saveAram2)
        // 저장 로직 추가
        $('#deptModal').modal('hide');
    }
    
    function saveAram1(cnt) {
        if (cnt > 0) {
            alert("신규 부서가 등록되었습니다.")
        } else {
            alert("오류가 발생했습니다.")
        }
    }
    
    function saveAram2(cnt) {
        if (cnt > 0) {
            alert("부서 정보가 변경되었습니다.")
        } else {
            alert("오류가 발생했습니다.")
        }
    }
    
    function init(){
    	call_server(newDeptForm, "/myCode/initDeptPopup", initDeptPopup);
    }
    
    
    function initDeptPopup(vo){
    	console.log(vo);
    	setUpDeptCdCombData(vo.upDeptList, upDeptCd);
    }
    
    init();
</script>

    <!-- Bootstrap JS 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
                            