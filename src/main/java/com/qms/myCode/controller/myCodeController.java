package com.qms.myCode.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.common.service.FileService;
import com.qms.myCode.service.myCodeService;
import com.qms.myCode.vo.deptVO;
import com.qms.myCode.vo.myCodeVO;
import com.qms.myCode.vo.noticeVO;
import com.qms.table.vo.common.FileVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.util.Constant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class myCodeController {

    @Autowired
    myCodeService service;
    
    @Autowired
	FileService fileservice;
    //사원 조회 사이트
    @RequestMapping("/myCode/userInfo")
    public String userInfo() throws Exception {
        return "myCode/userInfo";
    }
    
    //사원 리스트 조회
    @RequestMapping("/myCode/userList")
    @ResponseBody
    public myCodeVO selectUserListSearch(@ModelAttribute myCodeVO vo) throws Exception {

        vo.setComGrpCd(Constant.POSITION_CD);

        int totalPage = service.selectUserListSearchCount(vo);

        List<myCodeVO> list = service.selectUserListSearch(vo);

        vo.setUserList(list);
        vo.setTotal(totalPage);
        vo.setStartPage(vo.getStartPage());
        vo.setCurrentPage(vo.getCurrentPage());

        return vo;
    }
    
    //사원 조회 팝업
    @RequestMapping("/myCode/userPopup")
    @ResponseBody
    public myCodeVO selectUserPopup(@ModelAttribute myCodeVO vo) throws Exception {
        
    	vo.setComGrpCd(Constant.POSITION_CD);

        myCodeVO nvo = service.selectUserPopup(vo); 
 /*       
        List<myCodeVO> comlist = service.selectComNameBox(vo);
        List<myCodeVO> deptlist = service.selectDeptNameBox(vo);

        if(nvo==null) {
        	nvo = new myCodeVO();
        }
        nvo.setComList(comlist);
        nvo.setDeptList(deptlist);
*/
        return nvo;
    }
    
    //사원 조회 콤보 박스
    @RequestMapping("/myCode/initPopup")
    @ResponseBody
    public myCodeVO selectInitPopup(@ModelAttribute myCodeVO vo) throws Exception {
    	vo.setComGrpCd(Constant.POSITION_CD);
        List<myCodeVO> comlist = service.selectComNameBox(vo);
        List<myCodeVO> deptlist = service.selectDeptNameBox(vo);

       
        vo.setComList(comlist);
        vo.setDeptList(deptlist);

        return vo;
    }

    // 신규 사원 등록
    @RequestMapping("/myCode/insertUserInfo")
    @ResponseBody
    public int insertUserInfo( myCodeVO vo) throws Exception {
    	
    	int c = service.insertUserInfo(vo);
    	
    	return c;
    }
    
    //사원 정보 변경
    @RequestMapping("/myCode/updateUserInfo")
    @ResponseBody
    public int updateUserInfo( myCodeVO vo) throws Exception {
    	
    	int c = service.updateUserInfo(vo);
    	
    	return c;
    }
    
    //부서 조회 사이트
    @RequestMapping("/myCode/deptInfo")
    public String deptInfo() throws Exception {
        return "myCode/deptInfo";
    }
    
    //부서 리스트 조회
    @RequestMapping("/myCode/deptList")
    @ResponseBody
    public deptVO selectDeptListSearch(@ModelAttribute deptVO vo) throws Exception {

        int totalPage = service.selectDeptListSearchCount(vo);

        List<deptVO> list = service.selectDeptListSearch(vo);

        vo.setDeptList(list);
        vo.setTotal(totalPage);
        vo.setStartPage(vo.getStartPage());
        vo.setCurrentPage(vo.getCurrentPage());

        return vo;
    }
    
    //상위부서 조회 콤보 박스
    @RequestMapping("/myCode/initDeptPopup")
    @ResponseBody
    public deptVO selectInitDeptPopup(@ModelAttribute deptVO vo) throws Exception {
    	
    	List<deptVO> upDeptList = service.selectUpDeptNameList(vo);
        vo.setUpDeptList(upDeptList);

        return vo;
    }
    
    //부서 조회 팝업
    @RequestMapping("/myCode/deptPopup")
    @ResponseBody
    public deptVO selectDeptPopup(@ModelAttribute deptVO vo) throws Exception {
    	
    	vo = service.selectDeptPopup(vo);

        return vo;
    }
    
    // 신규 부서 등록
    @RequestMapping("/myCode/insertDeptInfo")
    @ResponseBody
    public int insertDeptInfo(deptVO vo) throws Exception {
    	
    	int c = service.insertDeptInfo(vo);
    	
    	return c;
    }
    
    //부서 정보 변경
    @RequestMapping("/myCode/updateDeptInfo")
    @ResponseBody
    public int updateDeptInfo(deptVO vo) throws Exception {
    	
    	int c = service.updateDeptInfo(vo);
    	
    	return c;
    }
    
    //공지 조회 사이트
    @RequestMapping("/myCode/noticeInfo")
    public String noticeInfo() throws Exception {
        return "myCode/noticeInfo";
    }
    
    //공지 리스트 조회
    @RequestMapping("/myCode/noticeList")
    @ResponseBody
    public noticeVO selectNoticeListSearch(@ModelAttribute noticeVO vo) throws Exception {
    	
    	vo.setComGrpCd(Constant.NOTICE_TYPE);
    	
        int totalPage = service.selectNoticeListSearchCount(vo);

        List<noticeVO> list = service.selectNoticeListSearch(vo);

        vo.setNoticeList(list);
        vo.setTotal(totalPage);
        vo.setStartPage(vo.getStartPage());
        vo.setCurrentPage(vo.getCurrentPage());

        return vo;
    }
    
    // 공지종류 조회 콤보 박스
    @RequestMapping("/myCode/initNoticeType")
    @ResponseBody
    public noticeVO selectNoticeType(@ModelAttribute noticeVO vo) throws Exception {
    	vo.setComGrpCd(Constant.NOTICE_TYPE);
    	List<noticeVO> noticeTypeList = service.selectNoticeType(vo);
        vo.setNoticeTypeList(noticeTypeList);
        return vo;
    }

    
    //부서 조회 팝업
    @RequestMapping("/myCode/noticePopup")
    @ResponseBody
    public noticeVO selectNoticePopup(@ModelAttribute noticeVO vo) throws Exception {
    	
    	vo = service.selectNoticePopup(vo);

        return vo;
    }
    
    // 신규 공지 등록
    @RequestMapping("/myCode/insertNoticeInfo")
    @ResponseBody
    public int insertNoticeInfo(HttpServletRequest request, noticeVO vo) throws Exception {
    	
    	HttpSession session  = request.getSession();
        UserInfoVO uservo = (UserInfoVO) session.getAttribute("MallUser");
        vo.setUserId(uservo.getUserId());
    	
        if(vo.getAtcFile()!=null) {	
			FileVO filevo = new FileVO();
			filevo.setFile(vo.getAtcFile());
			filevo.setMiddlePath("noticeVO");
	   	    filevo = fileservice.createFile(filevo);
	   	    vo.setFilePath(filevo.getFilePath());
	   	    vo.setFileName(filevo.getOrgFileNm());
		}
        
    	int c = service.insertNoticeInfo(vo);
    	
    	return c;
    }
    
    // 신규 공지 등록
    @RequestMapping("/myCode/updateNoticeInfo")
    @ResponseBody
    public int updateNoticeInfo(HttpServletRequest request, noticeVO vo) throws Exception {
    	
    	HttpSession session  = request.getSession();
        UserInfoVO uservo = (UserInfoVO) session.getAttribute("MallUser");
        vo.setUserId(uservo.getUserId());
    	
        if(vo.getAtcFile()!=null) {	
			FileVO filevo = new FileVO();
			filevo.setFile(vo.getAtcFile());
			filevo.setMiddlePath("noticeVO");
	   	    filevo = fileservice.createFile(filevo);
	   	    vo.setFilePath(filevo.getFilePath());
	   	    vo.setFileName(filevo.getOrgFileNm());
		}
        
    	int c = service.updateNoticeInfo(vo);
    	
    	return c;
    }
    
    @GetMapping("/api/data")
    @ResponseBody
    public String test() {
    	System.out.println("Call Server"); 
    	return "Hello, world!!!!";
    }

}
