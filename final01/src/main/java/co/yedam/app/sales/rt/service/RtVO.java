package co.yedam.app.sales.rt.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class RtVO {
	/*
	SALES_RT_CODE  NOT NULL VARCHAR2(30)  
	PROD_CODE      NOT NULL VARCHAR2(30)  
	SALES_OUT_CODE NOT NULL VARCHAR2(30)  
	SALES_RT_AMT   NOT NULL NUMBER(10)    
	SALES_RT_DATE  NOT NULL DATE          
	SALES_RT_WHY            VARCHAR2(100) 
	EMP_CODE       NOT NULL VARCHAR2(30)  
	*/
	private String salesRtCode;
	private String prodCode;
	private String salesOutCode;
	private int salesRtAmt;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date salesRtDate;
	private String salesRtWhy;
	private String empCode;
	private String prodName;
	private String actName;
	private int salesOutAmt;
	private int total;
	
	private String prodUnit;
	private String prodStd;
	private String prodLot;
	
	private String salesOrdDeCode;
	
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date endDate;
	
	private String devYn;
	private String actCode;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date salesOutDate;
	private String empName;
	
	private String salesInDate;
	private int prodSaveAmt;
	
	private int salesDpAmt;
	private Date salesDpDate;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private String testNum;
}
