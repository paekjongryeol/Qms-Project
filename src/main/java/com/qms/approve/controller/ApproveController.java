package com.qms.approve.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.approve.service.ApproveService;
import com.qms.approve.vo.ApproveVO;
import com.qms.approve.vo.AprvPageVO;
import com.qms.approve.vo.AprvVO;
import com.qms.code.service.CodeService;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.AprvFileVO;
import com.qms.table.vo.approve.AprvInfoVO;
import com.qms.table.vo.approve.AprvLineVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.user.vo.UserVO;
import com.qms.util.Constant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class ApproveController {

	@Autowired
	ApproveService service;
	
	@Autowired
	CodeService CdService;
	
	@Autowired
	FileService fileservice;
	/*
	 *  기안서 작성
     *  작성자 : 이성호
     *  작성일 : 24.05.20
	*/
	@RequestMapping("/approve/write")
	public String approveWrite() throws Exception{
		return "approve/aprv01";
	}
	// 기안서 조회 페이지
	@RequestMapping("/approve/search")
	public String approveSearch(HttpServletRequest request, Model model) throws Exception{
		
		HttpSession session  = request.getSession();
	    UserInfoVO uservo = (UserInfoVO) session.getAttribute("MallUser");
	    model.addAttribute("vo", uservo);
		
		return "approve/aprv02";
	}
	
	// 기안서 조회하기
	@RequestMapping("/approve/approveList")
	@ResponseBody
	public AprvPageVO selectApproveList(@ModelAttribute("AprvVO") AprvVO vo, HttpServletRequest request) throws Exception{
		
		HttpSession session  = request.getSession();
        UserInfoVO uservo = (UserInfoVO) session.getAttribute("MallUser");
        vo.setUserId(uservo.getUserId());
        
        int totalPage = 0;
		
		AprvPageVO aprvpagevo = new AprvPageVO();
		
		if(vo.getSearchType().equals("0")) {    // 결재진행중
			List<AprvVO> list = service.selectApproveList(vo);
			totalPage = service.selectTotalAprvCount(vo);
			aprvpagevo.setAprvList(list);
	    }else if(vo.getSearchType().equals("1")) {  // 결재완료
	    	List<AprvVO> list = service.selectApproveList(vo);
	    	totalPage = service.selectTotalAprvCount(vo);
	    	aprvpagevo.setAprvList(list);
	    }else {
	    	List<AprvVO> list = service.selectMyApproveList(vo);
	    	totalPage = service.selectTotalMyAprvCount(vo);
	    	aprvpagevo.setAprvList(list);
	    }
		aprvpagevo.setTotal(totalPage); // 총 데이터 수
		aprvpagevo.setStartPage(vo.getStartPage());
		aprvpagevo.setCurrentPage(vo.getCurrentPage()); // 현재 페이지
		
		return aprvpagevo;
	}
	// 기안서 상세조회
	@RequestMapping("/approve/approveDtl")
	public String aprvDtl(@ModelAttribute AprvInfoVO vo, Model model, HttpServletRequest request)throws Exception{
		HttpSession session  = request.getSession();
	    UserInfoVO uservo = (UserInfoVO) session.getAttribute("MallUser");
	    model.addAttribute("vo", uservo);
		
		model.addAttribute("aprvvo", vo);
		
		return "approve/APRVPOP02";
	}
	
	@RequestMapping("/approve/getApproveDtl")
	@ResponseBody
	public AprvVO getApproveDtl(@ModelAttribute("AprvVO")AprvVO vo)throws Exception{
		
		vo = service.selectApproveDtl(vo);
		
		// Aprv라인
		List<AprvLineVO> list1 = service.selectAprvLineList(vo);
		vo.setLinelist(list1);
		
		// Aprv파일
		List<AprvFileVO> list2 = service.selectAprvFileList(vo);
		vo.setFilelist(list2);
		
		return vo;
	}
	
	// 기안서 결재하기
	@RequestMapping("/approve/updateApprove")
	@ResponseBody
	public int updateApprove(@ModelAttribute("AprvVO")AprvVO vo, HttpServletRequest request, Model model)throws Exception{
		
		HttpSession session  = request.getSession();
	    UserInfoVO uservo = (UserInfoVO) session.getAttribute("MallUser");
	    model.addAttribute("vo", uservo);
		vo.setUserId(uservo.getUserId());
		
		model.addAttribute("aprvvo", vo);
	    
		int cnt = service.updateProcessing(vo);

		return cnt;
	}
	
		//문서 정보 불러오기
		@RequestMapping("/approve/selectCombData")
		@ResponseBody
		public ApproveVO userDoc(HttpServletRequest request) throws Exception{
			
			HttpSession session = request.getSession();
			UserVO uservo = (UserVO)session.getAttribute("MallUser");
			
			ComCodeVO cvo = new ComCodeVO();
			
			cvo.setComGrpCd(Constant.FILE_TYPE);
			List<ComCodeVO> list1 = CdService.selectComCodeList(cvo);
			
			cvo.setComGrpCd(Constant.FILE_YEAR);
			List<ComCodeVO> list2 = CdService.selectComCodeList(cvo);
			
			cvo.setComGrpCd(Constant.FILE_CLASS);
			List<ComCodeVO> list3 = CdService.selectComCodeList(cvo);
			
			cvo.setComGrpCd(Constant.FILE_STATUS);
			List<ComCodeVO> list4 = CdService.selectComCodeList(cvo);
			
			ApproveVO returnvo = new ApproveVO();
			returnvo.setUserName(uservo.getUserName());
			returnvo.setDeptName(uservo.getDeptName());
			returnvo.setTypelist(list1);
			returnvo.setYearlist(list2);
			returnvo.setClasslist(list3);
			returnvo.setStatuslist(list4);
		    
			return returnvo;
		}
		
		// 기안서 임시저장
		@RequestMapping("/approve/insertApproveDoc")
		@ResponseBody
		public int insertApprove(@ModelAttribute("AprvVO") AprvVO vo, HttpServletRequest request) throws Exception {
			HttpSession session = request.getSession();
			UserVO uservo = (UserVO) session.getAttribute("MallUser");
			vo.setUserId(uservo.getUserId());
			       
			int c = service.insertApprove(vo, uservo);	        
			return c;
		}		
}
