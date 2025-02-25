package com.qms.approve.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.approve.service.NoticeService;
import com.qms.approve.vo.NoticeVO;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.NoticeInfoVO;
import com.qms.table.vo.common.FileVO;
import com.qms.table.vo.user.UserInfoVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class NoticeController {

	@Autowired
	NoticeService service;
	
	@Autowired
	FileService fileservice;
	
	

	@RequestMapping("/board/list")
	public String notice() throws Exception{
		
		return "board/notice01";
	}
	
	@RequestMapping("/board/insertNotice")
    @ResponseBody
    public int insertNotice(@ModelAttribute("NoticeVO") NoticeVO vo,  HttpServletRequest request) throws Exception{
					
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
				
		vo.setUserId(uservo.getUserId());
		
		
		if(vo.getAtcFile()!=null) {	
			FileVO filevo = new FileVO();
			filevo.setFile(vo.getAtcFile());
			filevo.setMiddlePath("noticeVO");
	   	    filevo = fileservice.createFile(filevo);
	   	    vo.setFilePath(filevo.getFilePath());
	   	    vo.setFileName(filevo.getOrgFileNm());			//filename : cat.jpg
		}
	
	
		
		
		
	   
		
		int a = service.insertNoticeInfo(vo);
   	
		return a;
	
    }
	
	@RequestMapping("/board/search")
    @ResponseBody
    public NoticeVO getnotice(@ModelAttribute("NoticeVO") NoticeVO vo,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
		
		vo.setUserId(uservo.getUserId());
		
		int totalPage = service.selectTotalNoticeCount(vo); 
	
		List<NoticeInfoVO> list = service.selectNoticeInfo(vo);
		
		vo.setNoticelist(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		
		return vo;
	
    }
	
	@RequestMapping("/board/noticeDetail")
    @ResponseBody
    public NoticeVO noticeDtl(@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request ) throws Exception {
		
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
				
		vo.setUserId(uservo.getUserId());
			
		vo = service.selectNoticeDtl(vo);
		
		return vo;
	
    }
	
	@RequestMapping("/board/updateNotice")
    @ResponseBody
    public int upNotice(@ModelAttribute("NoticeVO") NoticeVO vo,  HttpServletRequest request) throws Exception{
					
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
				
		vo.setUserId(uservo.getUserId());
		
		
	   
		
		int a = service.updateNoticeInfo(vo);
   	
		return a;
	
    }
	
	@RequestMapping("/board/deleteNotice")
    @ResponseBody
    public int delNotice(@ModelAttribute("NoticeVO") NoticeVO vo,  HttpServletRequest request) throws Exception{
					
		HttpSession session = request.getSession();
		UserInfoVO uservo =  (UserInfoVO)session.getAttribute("MallUser");
				
		vo.setUserId(uservo.getUserId());
	   
		
		int a = service.deleteNoticeInfo(vo);
   	
		return a;
	
    }
	
	

}