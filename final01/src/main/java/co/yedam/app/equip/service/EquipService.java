package co.yedam.app.equip.service;

import java.util.List;

public interface EquipService {
	//전체 설비 조회
	public List<EquipVO> getEquipList();
	
	//설비 등록
	public String insertEquipInfo(EquipVO equipVO);
}
