package com.qms.myCode.vo;

import java.util.List;

import com.qms.table.vo.user.DeptInfoVO;

import lombok.Data;

@Data
public class deptVO extends DeptInfoVO{

	private String useDept;

	
	
	private List<deptVO> deptList;

	private List<deptVO> upDeptList;

}