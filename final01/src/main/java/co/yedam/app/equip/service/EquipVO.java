package co.yedam.app.equip.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EquipVO {
	private String eqCode; 
	private String actCode; 
	private String eqName; 
	private String modelName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date makeDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date buyDate;
	private int chkCycle;
	private String eqSts;
	private String eqImg;
	private String eqType;
	private int highTemp;
	private int lowTemp;
	private String prcsType;
	
	private String eqType2;
	private String eqSts2;
	
	private String empCode;
	private String chkType;
	private String chkNote;
	
	private String actName;
	
	private String result;
}
