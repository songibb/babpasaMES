package co.yedam.app.equip.service;

import java.util.List;

public interface OffEquipService {
	//전체 조회
	public List<OffEquipVO> getOffEquipList();
	
	//전체 설비 조회
	public List<EquipVO> getAllEquip();
}
