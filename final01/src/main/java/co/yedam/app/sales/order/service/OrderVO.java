package co.yedam.app.sales.order.service;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
/*
 * ORD_CODE       NOT NULL VARCHAR2(30) 
	ORD_DATE       NOT NULL DATE         
	ORD_STS                 VARCHAR2(12) 
	ACT_CODE       NOT NULL VARCHAR2(30) 
	EMP_CODE       NOT NULL VARCHAR2(30) 
	PRCS_PLAN_CODE          VARCHAR2(30) 
 */
	
	private String ordCode;
	private Date ordDate;
	private String ordSts;
	private String actCode;
	private String empCode;
	private String prcsPlanCode;
	private String salesOrdDeCode;
	private String actName;
	private String prodName;
	private int prcsRqAmt;
	private Date devDate;
	private String devYn;
}
