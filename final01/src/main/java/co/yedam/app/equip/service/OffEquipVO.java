package co.yedam.app.equip.service;

import java.util.Date;

import lombok.Data;

@Data
public class OffEquipVO {
	private String offNo;
	private String eqCode;
	private String offType;
	private String offInfo;
	private Date offStime;
	private Date offEtime;
	private String offNote;
	private String empCode;
}
