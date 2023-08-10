package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.equip.service.OffEquipVO;

public interface OffEquipMapper {
	
	//설비 전체 조회
	public List<EquipVO> selectAllequip();
	
	//전체조회
	public List<OffEquipVO> selectOffEquipAllList();
	
	//비가동 설비 등록
	public int insertOffEquip(OffEquipVO offequipVO);
}
