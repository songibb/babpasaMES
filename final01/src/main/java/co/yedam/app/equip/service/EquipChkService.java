package co.yedam.app.equip.service;

import java.util.List;

public interface EquipChkService {
	//점검 설비 전체 조회
	public List<EquipChkVO> getEquipChkList();
	
	//점검 설비 수정
	public int updateChkEquip(EquipChkVO equipChkVO);
}