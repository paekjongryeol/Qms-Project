package com.qms.bom.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qms.bom.vo.BomInfoVO;
import com.qms.item.vo.ItemVO;

@Repository
public interface BomDao {

	
	// BOM 조회하기
	public List<ItemVO> selectBomList(ItemVO vo)throws Exception;
	
	// 페이징
	public int selectTotalBomCount(ItemVO vo)throws Exception;
	
	// BOM 상세조회
	public BomInfoVO selectBomDtl(BomInfoVO vo)throws Exception;
	
	// BOM 자재리스트 조회
	public List<BomInfoVO> selectBomDtlList(BomInfoVO vo)throws Exception;
	
	// BOM_DTL 삭제
	public int deleteBom(BomInfoVO vo)throws Exception;
	
	// BOM_DTL 신규 등록
	public int insertNewBomDtl(BomInfoVO vo)throws Exception;
	
	// BOM_INFO 신규 등록
	public int insertNewBom(BomInfoVO vo)throws Exception;
	
	// BOM Excel 조회하기
	public List<ItemVO> selectBomListExcel(ItemVO vo)throws Exception;
}
