package com.qms.myCode.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.myCode.service.scheduleService;
import com.qms.myCode.vo.scheduleVO;
import com.qms.user.vo.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class scheduleController {

    @Autowired
    scheduleService service;
    

    //일정관리 조회 사이트
    @RequestMapping("/myCode/schedule")
    public String userInfo() throws Exception {
        return "myCode/schedule01";
    }
    
    //일정관리 일정 조회
    @RequestMapping("/myCode/selectScheduleInfo")
    @ResponseBody
    public scheduleVO selectScheduleInfo(@ModelAttribute scheduleVO vo) throws Exception {
    	
    	List<scheduleVO> scheduleList = service.selectScheduleInfo(vo);
    	vo.setScheduleList(scheduleList);
    	
    	return vo;
    }
    
    // 일정관리 모달창 상세 조회 및 콤보박스 데이터 함께 반환
    @RequestMapping("/myCode/selectScheduleData")
    @ResponseBody
    public scheduleVO selectScheduleData(@ModelAttribute scheduleVO vo) throws Exception {
        // 일정 관리 데이터 가져오기
        List<scheduleVO> scheduleModalList = service.selectScheduleModal(vo);
        vo.setScheduleModalList(scheduleModalList);
        
        // 콤보박스 데이터 가져오기
        List<scheduleVO> scheduleComboBox = service.selectSchedulComboBox(vo);
        vo.setScheduleComboBox(scheduleComboBox);
        
        return vo;
    }
    //일정관리 삭제 후 생성 저장
    @RequestMapping("/myCode/updateScheduleInfo")
    @ResponseBody
    public int updateScheduleInfo(scheduleVO vo, HttpServletRequest request) throws Exception {
        // 일정 삭제 및 저장 처리

        HttpSession session = request.getSession();
		UserVO uservo = (UserVO) session.getAttribute("MallUser");
		vo.setUserId(uservo.getUserId());
		int c = service.deleteScheduleInfo(vo);               
        // scheduleList의 각 항목에 대해 startTime과 endTime을 설정
        for (scheduleVO item : vo.getSchelist()) {
            // startTime과 endTime을 설정
            item.setStartTime(item.getStartDate() + " " + item.getStartHour() + ":" + item.getStartMinute());
            item.setEndTime(item.getEndDate() + " " + item.getEndHour() + ":" + item.getEndMinute());
        }
        
        for(int i=vo.getSchelist().size()-1;i>=0;i--) {
        	if(vo.getSchelist().get(i).getStartDate()==null 
        	|| vo.getSchelist().get(i).getStartDate().equals("")) {
        		vo.getSchelist().remove(i);
        	}
        }
        
		c = service.insertScheduleInfo(vo);

		return c;
    }

}
