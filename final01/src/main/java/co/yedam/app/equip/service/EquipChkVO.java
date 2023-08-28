package co.yedam.app.equip.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EquipChkVO {
	
	private String eqChkCode; //설비점검코드
	private String eqCode;	   //설비코드
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date chkDate;		//점검일자
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date chkNextDate;	//다음점검일자
	private String eqChkYn;		//점검통과여부
	private String chkType;		//점검타입?
	private String chkNote;		//점검 비고
	private String empCode;		//담당자
	private String empName;		//담당자명
	private String empName2;

	private String eqName;		//설비명 (EQ_EQUIP)
	private int chkCycle;		//점검주기 (EQ_EQUIP)
	private String eqType;		//설비타입 (EQ_EQUIP)
	private String eqType2;
	private String eqSts;
	private String eqSts2;
  
	private String eqChkYn2;
	
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date endDate;


	
	
}
