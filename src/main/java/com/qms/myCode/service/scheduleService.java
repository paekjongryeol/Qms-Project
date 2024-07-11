package com.qms.myCode.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.myCode.dao.scheduleDao;
import com.qms.myCode.vo.scheduleVO;

@Service
public class scheduleService {

	@Autowired
	scheduleDao dao;
	//일정조회 리스트 조회
	public List<scheduleVO> selectScheduleInfo(scheduleVO vo)throws Exception{
		return dao.selectScheduleInfo(vo);
	}
	//일정조회 모달창 상세 조회
	public List<scheduleVO> selectScheduleModal(scheduleVO vo)throws Exception{
		return dao.selectScheduleModal(vo);
	}
	//일정조회 모달창 콤보박스
	public List<scheduleVO> selectSchedulComboBox(scheduleVO vo)throws Exception{
		return dao.selectSchedulComboBox(vo);
	}
	//일정조회 삭제
    public int deleteScheduleInfo(scheduleVO vo) throws Exception {
        return dao.deleteScheduleInfo(vo);
    }
	// 일정조회 신규 등록
    public int insertScheduleInfo(scheduleVO vo) throws Exception {
        return dao.insertScheduleInfo(vo);
    }

}


