package co.yedam.app.equip.service;

import java.util.List;

public interface OffEquipService {
	//전체 비가동 설비 조회
	public List<OffEquipVO> getOffEquipList();
	
	//모달 안에서의 전체 설비 조회
	public List<OffEquipVO> getAllEquip();
	
	//비가동 등록
	public String insertOffEquip(OffEquipVO offequipVO);

	//비가동 수정
	public String updateOffEquip(OffEquipVO offequipVO);
	
	//모달에서 갖고오는 설비 단건으로 갖고오기(조회)
	public OffEquipVO getOffEquipInfo(OffEquipVO offequipVO);
	
	//설비명 검색
	public List<EquipVO> offsearchEquip (String eqName);
}