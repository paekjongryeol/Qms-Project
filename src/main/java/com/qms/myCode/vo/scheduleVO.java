package com.qms.myCode.vo;

import java.util.List;

import lombok.Data;

@Data
public class scheduleVO{

	private String scheduleSeq;
	private String userId;
	private String title;
	private String content;
	private String startTime;
	private String endTime;
	private String timeCd;
	private String comName;
    private String scheduleYear;
    private String scheduleMonth;
    private String scheduleDt;
    private String startDate;
    private String startHour;
    private String startMinute;
    private String endDate;
    private String endHour;
    private String endMinute;
    
    private List<scheduleVO> scheduleList;
    private List<scheduleVO> scheduleModalList;
    private List<scheduleVO> scheduleComboBox;
    private List<scheduleVO> schelist;
    

}