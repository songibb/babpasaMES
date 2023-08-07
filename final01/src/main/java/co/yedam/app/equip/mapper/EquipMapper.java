package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipVO;

public interface EquipMapper {
	//설비 전체 조회
	public List<EquipVO> selectEquipAllList();
	
	//설비 등록
	public int insertEquipInfo(EquipVO equip);
}
