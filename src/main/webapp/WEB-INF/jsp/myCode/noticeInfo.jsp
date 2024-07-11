<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>공지사항 - NiceAdmin Bootstrap 템플릿</title>

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
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet">
    <!-- Template Main JS File -->
    <script src="/assets/js/common.js"></script>
    <script src="/assets/js/jquery-3.7.1.js"></script>
    <script src="/assets/js/main.js"></script>
    <script src="/assets/js/paging.js"></script>
    <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
    
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
        #editor-container {
            height: 300px; /* 높이 조정 */
            max-height: 300px; /* 최대 높이 설정 */
            overflow-y: auto; /* 세로 스크롤 추가 */
        }
    </style>
</head>
<body>
    <%@ include file="../layout/menu.jsp" %>
    <%@ include file="../layout/footer.jsp" %>
    <form id="searchform" class="container">
    <input type='hidden' id='currentPage' name='currentPage'>
        <div class="plan-date-group">
            <label for="titleLabel" class="col-form-label">제목</label>
            <input type="text" class="form-control" name="title">
            <label for="noticeTypeLabel" class="col-form-label">공지종류</label>
            <select id="noticeType" name="noticeType" class="form-control">
                <option value="">===선택===</option>          
            </select>
            <div class="col-sm-2">
                <button type="button" class="btn btn-info btn-block" onclick="noticeSearch();">조회</button>
                <button type="button" class="btn btn-dark" onclick="noticeNew();">신규</button>
            </div>
        </div>
        <!-- 부서리스트 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered" id="noticeTable">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">공지종류</th>
                            <th scope="col">제목</th>
                            <th scope="col">부서</th>
                            <th scope="col">작성자</th>
                            <th scope="col">첨부파일</th>
                            <th scope="col">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 여기에 공지사항 데이터를 동적으로 추가합니다. -->
                    </tbody>
                </table>
            </div>
        </div>
        <nav aria-label="Page navigation example">
            <ul class="pagination" id="noticePaging">
            </ul>
        </nav>
    </form>

	 <!-- 팝업 창 수정 -->
	<div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="noticeModalLabel">공지 등록/수정</h5>
	            </div>
	            <div class="modal-body">
	                <form id="noticePopupform" enctype="multipart/form-data">
	                	<input type="hidden" id="noticeSeq" name="noticeSeq">
	                    <div class="form-group">
	                        <label for="titlePop">제목</label>
	                        <input type="text" class="form-control" id="title" name="title">
	                    </div>
	                    <div class="form-group">
	                        <label for="noticeTypePop">공지종류</label>
	                        <select id="noticeTypePop" name="noticeType" class="form-control">
	                            <option value="">=== 선택 ===</option>
	                        </select>
	                    </div>
	                    <div class="form-group">
	                        <label for="contentPop">내용</label>
	                        <!-- Quill을 위한 컨테이너 -->
	                        <div id="editor-container"></div>
	                        <!-- 실제 내용이 전송되는 hidden input -->
	                        <input type="hidden" id="content" name="content">
	                    </div>
	                    <div class="form-group">
	                        <label for="filePop">첨부 파일</label>
	                        <input type="file" class="form-control" id="filePath" name="atcFile">
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                <button type="button" id="btnUpdate" class="btn btn-secondary" data-bs-dismiss="modal" onclick="noticeUpdate();">수정</button>
	                <button type="button" id="btnInsert" class="btn btn-secondary" data-bs-dismiss="modal" onclick="noticeInsert();">등록</button>
	            </div>
	        </div>
	    </div>
	</div>



<script>
	var quill = new Quill('#editor-container', {
	    theme: 'snow', // snow 테마는 기본적인 텍스트 편집기 스타일입니다.
	    placeholder: '내용을 입력하세요...', // 사용자에게 보이는 힌트 텍스트
	    modules: {
	        toolbar: [
	            [{ 'header': '1' }, { 'header': '2' }],
	            ['bold', 'italic', 'underline'],
	            ['link', 'image'],
	            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
	            ['clean']
	        ]
	    }
	});
	
	// Quill에서 변화가 있을 때마다 내용을 hidden input에 반영
	quill.on('text-change', function() {
	    var html = quill.root.innerHTML;
	    document.getElementById('content').value = html;
	});

    function noticeSearch(no) {
        if (no === undefined) {
            $('#currentPage').val(1);
        } else {
            $('#currentPage').val(no);
        }
        call_server(searchform, "/myCode/noticeList", noticeList);
    }

    function noticeList(vo) {
        var list = vo.noticeList;
        // 기존 데이터 초기화
        $('#noticeTable tbody').empty();
        // 리스트의 각 항목을 순회하며 테이블 행 생성
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            var str = "<tr onclick=\"noticeDetail('" + item.noticeSeq + "');\" style=\"cursor:pointer;\">";
            str += "<th scope=\"row\">" + ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1)) + "</th>";
            str += '<td>' + item.noticeType + '</td>';
            str += '<td>' + item.title + '</td>';
            str += '<td>' + item.deptName + '</td>';
            str += '<td>' + item.userName + '</td>';
            str += "<td><a href='/download?filePath="+list[i].filePath+"&fileName="+list[i].fileName+"'><img src='/assets/img/filedown.png'></a></td>"; 
            str += '<td>' + item.regDt + '</td>';              
            str += '</tr>';
            $('#noticeTable tbody').append(str);
        }
        setPaging(noticePaging, vo.startPage, vo.endPage, 'noticeSearch');
    }
    
    function noticeDetail(id) {
        $('#noticeSeq').val(id);
        call_server(noticePopupform, "/myCode/noticePopup", noticePopup);
    }

    function noticePopup(vo) {
        $('#title').val(vo.title);
        $('#noticeTypePop').val(vo.noticeType); // 수정된 부분
        
        quill.root.innerHTML = vo.content; // Quill 에디터에 내용 설정
        $('#filePath').val(vo.filePath);

        $('#btnUpdate').show(); // 업데이트 버튼 표시
        $('#btnInsert').hide(); // 신규 등록 버튼 숨김

        $('#noticeModal').modal('show'); // 모달 창 열기
    }

 	// 선택 목록을 설정하는 함수
    function setNoticeTypeCombData(list, id) {
        var select = $(id);
        select.empty(); // 기존 옵션 제거

        // 기본 선택 옵션 추가
        var defaultOption = "<option value=''>=== 선택 ===</option>";
        select.append(defaultOption);

        // 리스트의 각 항목을 순회하며 옵션 추가
        for (var i = 0; i < list.length; i++) {
            var option = "<option value='" + list[i].comCd + "'>" + list[i].comName + "</option>";
            select.append(option);
        }
    }

    
    function noticeNew() {
        // 모달 내 입력 필드 초기화
        $('#title, #noticeTypePop, #content, #filePath').val('');
        quill.root.innerHTML = ''; // Quill 에디터 초기화
        
        $('#btnUpdate').hide();                // 업데이트 버튼 숨김
        $('#btnInsert').show();                // 신규 등록 버튼 표시
        $('#noticeModal').modal('show');       // 모달 표시
    }

    function noticeInsert() {
    	var html = quill.root.innerHTML;
        document.getElementById('content').value = html;
        call_server(noticePopupform, "/myCode/insertNoticeInfo", saveAram1);
        // 저장 로직 추가
        $('#noticeModal').modal('hide');
    }
    
    function noticeUpdate() {
    	var html = quill.root.innerHTML;
        document.getElementById('content').value = html;
        call_server(noticePopupform, "/myCode/updateNoticeInfo", saveAram2);
        // 저장 로직 추가
        $('#noticeModal').modal('hide');
    }
    
    function saveAram1(cnt) {
        if (cnt > 0) {
            alert("신규 공지가 등록되었습니다.");
        } else {
            alert("오류가 발생했습니다.");
        }
    }
    
    function saveAram2(cnt) {
        if (cnt > 0) {
            alert("공지 정보가 변경되었습니다.");
        } else {
            alert("오류가 발생했습니다.");
        }
    }
    
    function init(){
    	call_server(noticePopupform, "/myCode/initNoticeType", initNoticeType);
    	
    }
    
    function initNoticeType(vo) {
        setNoticeTypeCombData(vo.noticeTypeList, noticeType); 
        setNoticeTypeCombData(vo.noticeTypeList, noticeTypePop);
    }
    
    init();
</script>


    <!-- Bootstrap JS 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
