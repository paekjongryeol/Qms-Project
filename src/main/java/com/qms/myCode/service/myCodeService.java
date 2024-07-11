package com.qms.myCode.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.myCode.dao.myCodeDao;
import com.qms.myCode.vo.deptVO;
import com.qms.myCode.vo.myCodeVO;
import com.qms.myCode.vo.noticeVO;

@Service
public class myCodeService {

	@Autowired
	myCodeDao dao;
	
	//사원 페이징 토탈 카운트
	public int selectUserListSearchCount(myCodeVO vo) throws Exception{
		return dao.selectUserListSearchCount(vo);
	}
	//사원 리스트 출력
	public List<myCodeVO> selectUserListSearch(myCodeVO vo) throws Exception{
		return dao.selectUserListSearch(vo);
	}
	//사원 등록 팝업
	public myCodeVO selectUserPopup(myCodeVO vo) throws Exception{
		return dao.selectUserPopup(vo);
	}
	//사원 팝업 콤보 박스(직위)
	public List<myCodeVO> selectDeptNameBox(myCodeVO vo) throws Exception{
		return dao.selectDeptNameBox(vo);
	}
	//사원 팝업 콤보 박스(부서)
	public List<myCodeVO> selectComNameBox(myCodeVO vo) throws Exception{
		return dao.selectComNameBox(vo);
	}
	//사원 팝업 신규 사원 추가
	public int insertUserInfo(myCodeVO vo) throws Exception{
		return dao.insertUserInfo(vo);
	}
	//사원 정보 업데이트
	public int updateUserInfo(myCodeVO vo) throws Exception{
		return dao.updateUserInfo(vo);
	}
	//부서 페이징 토탈 카운트
	public int selectDeptListSearchCount(deptVO vo) throws Exception{
		return dao.selectDeptListSearchCount(vo);
	}
	//부서 리스트 출력
	public List<deptVO> selectDeptListSearch(deptVO vo) throws Exception{
		return dao.selectDeptListSearch(vo);
	}
	//팝업 상위 부서 리스트
	public List<deptVO> selectUpDeptNameList(deptVO vo) throws Exception{
		return dao.selectUpDeptNameList(vo);
	}
	//부서 등록 팝업
	public deptVO selectDeptPopup(deptVO vo) throws Exception{
		return dao.selectDeptPopup(vo);
	}
	//부서 팝업 신규 사원 추가
	public int insertDeptInfo(deptVO vo) throws Exception{
		return dao.insertDeptInfo(vo);
	}
	//부서 정보 업데이트
	public int updateDeptInfo(deptVO vo) throws Exception{
		return dao.updateDeptInfo(vo);
	}
	//공지 페이징 토탈 카운트
	public int selectNoticeListSearchCount(noticeVO vo) throws Exception{
		return dao.selectNoticeListSearchCount(vo);
	}
	//공지 리스트 출력
	public List<noticeVO> selectNoticeListSearch(noticeVO vo) throws Exception{
		return dao.selectNoticeListSearch(vo);
	}
	//공지종류 리스트 출력
	public List<noticeVO> selectNoticeType(noticeVO vo) throws Exception{
		return dao.selectNoticeType(vo);
	}
	//공지 등록 팝업
	public noticeVO selectNoticePopup(noticeVO vo) throws Exception{
		return dao.selectNoticePopup(vo);
	}
	//신규 공지 추가
	public int insertNoticeInfo(noticeVO vo) throws Exception{
		return dao.insertNoticeInfo(vo);
	}
	//공지 정보 업데이트
	public int updateNoticeInfo(noticeVO vo) throws Exception{
		return dao.updateNoticeInfo(vo);
	}
}


