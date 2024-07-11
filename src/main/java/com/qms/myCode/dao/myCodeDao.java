package com.qms.myCode.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qms.myCode.vo.deptVO;
import com.qms.myCode.vo.myCodeVO;
import com.qms.myCode.vo.noticeVO;

@Repository
public interface myCodeDao {
	
	//사원 페이징 토탈 카운트
	public int selectUserListSearchCount(myCodeVO vo) throws Exception;
	//유저 리스트 출력
	public List<myCodeVO> selectUserListSearch(myCodeVO vo) throws Exception;
	//유저 등록 팝업 
	public myCodeVO selectUserPopup(myCodeVO vo) throws Exception;	
	//팝업 직위 박스
	public List<myCodeVO> selectComNameBox(myCodeVO vo) throws Exception;
	//팝업 부서 박스
	public List<myCodeVO> selectDeptNameBox(myCodeVO vo) throws Exception;
	//신규 사원 등록
	public int insertUserInfo(myCodeVO vo) throws Exception;
	//사원 정보 업데이트
	public int updateUserInfo(myCodeVO vo) throws Exception;
	//부서 페이징 토탈 카운트
	public int selectDeptListSearchCount(deptVO vo) throws Exception;
	//부서 리스트 출력
	public List<deptVO> selectDeptListSearch(deptVO vo) throws Exception;
	//팝업 상위 부서 리스트
	public List<deptVO> selectUpDeptNameList(deptVO vo) throws Exception;
	//부서 등록 팝업 
	public deptVO selectDeptPopup(deptVO vo) throws Exception;	
	//신규 부서 등록
	public int insertDeptInfo(deptVO vo) throws Exception;
	//부서 정보 업데이트
	public int updateDeptInfo(deptVO vo) throws Exception;
	//공지 페이징 토탈 카운트
	public int selectNoticeListSearchCount(noticeVO vo) throws Exception;
	//공지 리스트 출력
	public List<noticeVO> selectNoticeListSearch(noticeVO vo) throws Exception;
	//공지종류 리스트 출력
	public List<noticeVO> selectNoticeType(noticeVO vo) throws Exception;
	//공지 등록 팝업 
	public noticeVO selectNoticePopup(noticeVO vo) throws Exception;	
	//신규 공지 등록
	public int insertNoticeInfo(noticeVO vo) throws Exception;
	//공지 정보 업데이트
	public int updateNoticeInfo(noticeVO vo) throws Exception;
}