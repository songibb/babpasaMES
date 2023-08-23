package co.yedam.app.sales.in.service;

import java.util.Date;

import lombok.Data;

@Data
public class InVO {
	/*
	PROD_LOT      NOT NULL VARCHAR2(30) 
	PROD_CODE     NOT NULL VARCHAR2(30) 
	SALES_IN_DATE NOT NULL DATE         
	SALES_IN_AMT  NOT NULL NUMBER(10)   
	PROD_SAVE_AMT NOT NULL NUMBER(10)   
	SALES_IN_EXD  NOT NULL DATE         
	EMP_CODE      NOT NULL VARCHAR2(30) 
	TEST_NUM      NOT NULL VARCHAR2(30)
	*/
	private String prodLot;
	private String prodCode;
	private Date salesInDate;
	private int salesInAmt;
	private int prodSaveAmt;
	private Date salesInExd;
	private String empCode;
	private String testNum;
	private String prodName;
	
	private String prodUnit;
	private String prodStd;
	
	private Date startDate;
	private Date endDate;
	
	private String salesOrdDeCode;
	private int inputAmt;
	private int errAmt;
	private int prcsAmt;
	private String ordCode;
	private String prcsPlanCode;
	private String prcsDirCode;
	private String prcsDirDeCode;
	private String prcsDirIngSts;
}
