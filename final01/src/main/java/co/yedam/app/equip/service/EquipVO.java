package co.yedam.app.equip.service;

import java.util.Date;

import lombok.Data;

@Data
public class EquipVO {
	private String eqCode; //�����ڵ�
	private String actCode; //
	private String eqName; //�����
	private String modelName; //�𵨸�
	private Date makeDate;
	private Date buyDate;
	private int chkCycle;
	private String eqSts;
	private String eqImg;
	private String eqType;
	private int highTemp;
	private int lowTemp;
	private String prcsType;
	
}
