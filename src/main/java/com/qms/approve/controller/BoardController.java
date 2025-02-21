package com.qms.approve.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.approve.service.BoardService;
import com.qms.approve.vo.NoticeVO;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.NoticeInfoVO;
import com.qms.table.vo.common.FileVO;
import com.qms.table.vo.user.UserInfoVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class BoardController {

@Autowired
BoardService service;

@Autowired
FileService fileservice;

	

	@RequestMapping("/noticeVO/list")
	public String notice() throws Exception{
		
		return "board/notice02";
	}

	@RequestMapping("/noticeVO/search")
    @ResponseBody
    public  NoticeVO noticeSearch (@ModelAttribute("NoticeVO") NoticeVO vo,  HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
		
		vo.setUserId(uservo.getUserId());
		
		int totalPage = service.selectNoticeCount(vo);
		
		List <NoticeInfoVO> list = service.selectnoticeInfo(vo);
		
		vo.setNoticelist(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		
		return vo;
	}
	
	@RequestMapping("/noticeVO/noticeDetail")
    @ResponseBody
	public NoticeVO noticeDetail (@ModelAttribute("NoticeVO") NoticeVO vo,  HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
		
		vo.setUserId(uservo.getUserId());
		
		vo = service.selectnoticeDetail(vo);
		
		return vo;
		
	}
	@RequestMapping("/noticeVO/noticeInsert")
    @ResponseBody
	public int noticeInsert (@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
		
		vo.setUserId(uservo.getUserId());
		
		
		if(vo.getAtcFile()!=null) {	
			FileVO filevo = new FileVO();
			filevo.setFile(vo.getAtcFile());
			filevo.setMiddlePath("noticeVO");
	   	    filevo = fileservice.createFile(filevo);
	   	    vo.setFilePath(filevo.getFilePath());
	   	    vo.setFileName(filevo.getOrgFileNm());		
		}
	
		
		int a = service.insertBoardInfo(vo);
		
		return a;
		
	}
	
	@RequestMapping("/noticeVO/noticeUpdate")
    @ResponseBody
    public int noticeUpdate (@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request) throws Exception{ 
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
		
		vo.setUserId(uservo.getUserId());
		
		
		
		int a = service.updateBoardInfo(vo);
		
		return a;

		
	}
	@RequestMapping("/noticeVO/noticeDelete")
    @ResponseBody
    public int noticeDelete (@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
		
		vo.setUserId(uservo.getUserId());
		
		int a = service.DeleteBoardInfo(vo);
		
		return a;
	}
	

	
}


