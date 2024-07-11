package com.qms.myCode.vo;

import java.util.List;

import com.qms.table.vo.user.UserInfoVO;

import lombok.Data;

@Data
public class myCodeVO extends UserInfoVO{
	private String deptName;	//부서
	private String comName;		//직급
	private String comGrpCd;	//직위코드 ( 공통코드 : US01 )
	private String comCd;
	
	private String joinDtFrom;
	private String joinDtTo;
	
	
	private List<myCodeVO> userList;
	private List<myCodeVO> comList;
	private List<myCodeVO> deptList;
}