<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <%@ page import="com.qms.table.vo.user.UserInfoVO" %>
<%
		UserInfoVO uservo = (UserInfoVO)session.getAttribute("MallUser");
		System.out.println("=====================");
		if(uservo!=null){
		System.out.println(uservo.getUserId());
		}
 %>



<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>기안서 작성</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="/assets/img/favicon.png" rel="icon">
  <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;700&family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">

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
</head>

<body>

  <%@ include file="../layout/menu.jsp" %>

  <main id="main" class="main container">

    <div class="pagetitle">
      <h1>공지사항</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">홈</a></li>
          <li class="breadcrumb-item">전자결재</li>
          <li class="breadcrumb-item active">공지사항</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="card">
        <div class="card-body" >
          <h5 class="card-title">공지사항</h5>
          	<form id="searchform">
          	<input type='hidden' id='currentPage' name='currentPage' value='1'>
            <div class="row mb-3">
              <label for="title" class="col-sm-2 col-form-label">제목</label>
              <div class="col-sm-4">
                <input type="text" class="form-control" id="title" name="title">
              </div>
              <label for="notice-type" class="col-sm-2 col-form-label">공지종류</label>
              <div class="col-sm-4">
                <select class="form-control" id="notice-type" name="noticeType">
                  <option value="">선택</option>
                  <option value="01">공지사항</option>
                  <option value="02">게시판</option>
                </select>
              </div>
            </div>
            </form>
            <div class="row mb-3">
              <div class="col-sm-12 text-end">
                <button type="button" class="btn btn-info" onclick="noticeSearch();">조회</button>
                <button type="button" class="btn btn-primary" onclick="newNotice();">신규</button>
              </div>
            </div>
        
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <h5 class="card-title">공지사항 목록</h5>
           <form id="dataform" > 
          <table class="table table-hover" id="noticeListTable">
        
            <thead>
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
              <!-- Data rows go here -->
            </tbody>
          </table>
          <nav aria-label="Page navigation example">
			<ul class="pagination" id="noticePaging">

			</ul>
		  </nav>
          </form>
        </div>
      </div>
       
      <!-- Modal -->
      <div class="modal fade" id="noticeTable" tabindex="-1" aria-labelledby="boardInfoLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="boardInfoLabel">공지사항</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            <form id="noticeform" enctype="multipart/form-data">
             <input type ="hidden" id="noticeSeq" name="noticeSeq">
              <input type="hidden" id="quill_html" name="content">
              <table class="table table-hover" id="noticeDtl">
                <tr>
                  <th scope="col">제목</th>
                  <td><input type="text" class="form-control" id="titleTxt" name="title" ></td>
                </tr>
                <tr>
                  <th scope="col">공지종류</th>
                  <td>
                    <select class="form-control" id="noticeTypeTxt" name="noticeType">
                      <option value="01">공지사항</option>
                      <option value="02">게시판</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th scope="col">내용</th>
                  <td>
                    <div id="editor" style="height: 300px;"></div>
                  </td>
                </tr>
                <tr>
                  <th scope="col">첨부파일</th>
                  <td><input type="file" id="filePathTxt" name="atcFile"></td>
                 
                                                    
                  
                </tr>
              </table>
              	
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary" onclick="saveData();" id = "savebtn" >저장</button>
              <button type="button" class="btn btn-primary" onclick="updateNotice();" id = "repairbtn" >수정</button>
              <button type="button" class="btn btn-primary" onclick="deleteNotice();" id = "deletebtn" >삭제</button>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
          </div>
        </div>
      </div>
      
      
         
      <script src="/assets/js/paging.js"></script>
      <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
      <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>
      <script src="/assets/vendor/quill/quill.min.js"></script>
      <script src="/assets/vendor/tinymce/tinymce.min.js"></script>
      <script src="/assets/js/common.js"></script>
       <script src="/assets/js/jquery-3.7.1.js"></script>
       

      <script>
      	var quill = new Quill('#editor', {
    	    theme: 'snow'
    	  });
      

        function noticeSearch(no){
        	
        	if(no==undefined){
        		$('#currentPage').val(1);
        	}else{
        		$('#currentPage').val(no);	
        	}
        	
        	 
        	call_server(searchform,'/board/search',getNoticeList);
        	
        }
        
        function getNoticeList(vo){
        	
        	list = vo.noticelist;
        	  $('#noticeListTable > tbody').empty();
        	for(var i=0;i<list.length;i++){
        	 
        		str="<tr>";
        	    str+="<th scope=\"row\">"+((Number(vo.currentPage)-1)*vo.countPerPage+(i+1))+"</th>";	
				str+="<td>"+list[i].noticeTypeName+"</td>";
				str+="<td><a href='#' onclick=\"noticeDetail('"+list[i].noticeSeq+"');\" style=\"cursor:pointer;\">"+list[i].title+"</a></td>";
				str+="<td>"+list[i].deptName+"</td>";
				str+="<td>"+list[i].userName+"</td>";
				if (list[i].filePath != null && list[i].filePath != ''){
				str += "<td><a href='/download?filePath="+list[i].filePath+"&fileName="+list[i].fileName+"'><img src='/assets/img/filedown.png'></a></td>";
	
				
				} else {
					str += "<td>파일없음</td>";
				}
				str+="<td>"+list[i].regDt+"</td>";
				str+="</tr>";
				$('#noticeListTable').append(str);
        	}
        	 setPaging(noticePaging, vo.startPage, vo.endPage,'noticeSearch' );	       	
        }
               
        function newNotice(){
          document.getElementById('titleTxt').value = '';
          document.getElementById('noticeTypeTxt').value = '';
          quill.root.innerHTML = '';
          document.getElementById('filePathTxt').value = '';
          
          $('#repairbtn').hide(); 
          $('#deletebtn').hide();
          $('#savebtn').show();  
          
          var myModal = new bootstrap.Modal(document.getElementById('noticeTable'));
          myModal.show();
        }
          
        function saveData(){
        	         	
        	
          if($('#titleTxt').val()==''){
        	  alert("제목을 입력하세요");
        	  return;
          }
          
          $('#quill_html').val(quill.getText());
          
         if(quill.getText().replace(/(?:\r\n|\r|\n)/g, "")==''){
       	  	alert("내용을 입력하세요");
       	  	return;
       	  	
      
         }
              
         
          
          call_server(noticeform, "/board/insertNotice", saveDataConfirm);
        }

        
        function saveDataConfirm(cnt){
        	   if(cnt>0){
	     		   alert("저장되었습니다.");
	     		  $('#noticeTable').modal('hide');
	     		       		   
	     	   }else{
	     		   alert("저장시 오류가 발생하였습니다.");
	     	   }
        	   noticeSearch();
	     }
    	
        function noticeDetail(seq){
        	
        	$('#noticeSeq').val(seq);
        	call_server(noticeform,"/board/noticeDetail", getNoticeDt);
        }	
        
        function getNoticeDt(vo){
	       	 $('#titleTxt').val(vo.title);
	       	 $('#noticeTypeTxt').val(vo.noticeType);
	       	 quill.root.innerHTML = vo.content;
	       	 $('#filePathTxt').val(vo.filePath);
	       	 if(vo.modifyYn!='Y'){
	       		 $('#repairbtn').prop("disabled",true);
	       	 }else{
	       		$('#repairbtn').prop("disabled",false);
	       	 }
	       	 $('#savebtn').hide();
        	 $('#repairbtn').show(); 
        	 $('#deletebtn').show();
        	 if(vo.modifyYn!='Y'){
	       		 $('#deletebtn').prop("disabled",true);
	       	 }else{
	       		$('#deletebtn').prop("disabled",false);
	       	 }
           	
	       	 $('#noticeTable').modal('show');
         }
        
         function updateNotice(){
        	 $('#quill_html').val(quill.getText());
        	 call_server(noticeform,"/board/updateNotice", updateConfirm);
         }
         
         function updateConfirm(cnt){
        	 if(cnt>0){
	     		   alert("수정되었습니다.");
	     		  $('#noticeTable').modal('hide');
	     		       		   
	     	   }else{
	     		   alert("수정시 오류가 발생하였습니다.");
	     	   }
        	 noticeSearch(); 
	     }
         
		function deleteNotice(){
        	 
        	 call_server(noticeform,"/board/deleteNotice", deleteConfirm);
         }
         
         function deleteConfirm(cnt){
        	 if (confirm("정말 삭제하시겠습니까??") == true){    

       

        	 }else{   

        	     return false;

        	 }
      
        	 
        	 if(cnt>0){
	     		   alert("삭제되었습니다.");
	     		  $('#noticeTable').modal('hide');
	     		       		   
	     	   }else{
	     		   alert("삭제시 오류가 발생하였습니다.");
	     	   }
        	 noticeSearch();
	     }
         
       
        
        
        
      </script>
    </section>
  </main>

  <!-- Template Main JS File -->
  <script src="/assets/js/main.js"></script>
</body>
</html>
