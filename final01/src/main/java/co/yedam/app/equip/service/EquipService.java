package co.yedam.app.equip.service;

import java.util.List;
import java.util.Map;

public interface EquipService {
	//전체 설비 조회
	public List<EquipVO> getEquipList();
	
	//설비 등록
	public String insertEquipInfo(EquipVO equipVO);
	
	//모달 안에서의 전체 설비 조회
	public List<EquipVO> getModalEquipList();
	
	//설비 삭제
	public String deleteEquipInfo(String eqCode);
	
	//설비 단건조회
	public EquipVO getEquipInfo(EquipVO equipVO);
	
	//설비 수정
	public Map<String, String> updateEquip(EquipVO equipVO);


	//설비 검색
	public List<EquipVO> searchEquip (String eqName);
	

}
