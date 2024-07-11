package com.qms.myCode.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qms.myCode.vo.scheduleVO;

@Repository
public interface scheduleDao {
	
	//일정조회 조회 리스트
	public List<scheduleVO> selectScheduleInfo(scheduleVO vo)throws Exception;
	//일정조회 모달창 상세 조회
	public List<scheduleVO> selectScheduleModal(scheduleVO vo)throws Exception;
	//일정조회 모달창 상세 조회
	public List<scheduleVO> selectSchedulComboBox(scheduleVO vo)throws Exception;
	//일정조회 삭제
	public int deleteScheduleInfo(scheduleVO vo)throws Exception;
	//일정조회 신규 등록
	public int insertScheduleInfo(scheduleVO vo)throws Exception;
}