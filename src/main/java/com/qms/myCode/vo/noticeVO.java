package com.qms.myCode.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qms.table.vo.approve.NoticeInfoVO;

import lombok.Data;

@Data
public class noticeVO extends NoticeInfoVO{

	private String comName;
	private String comCd;
	private String deptName;
	private String deptCd;
	private String userName;
	private String comGrpCd;
	
	private List<noticeVO> noticeTypeList;

	private List<noticeVO> noticeList;
	
	@JsonIgnore
	private MultipartFile atcFile;
	
	@JsonIgnore
	private List<MultipartFile> fileList;
	


}