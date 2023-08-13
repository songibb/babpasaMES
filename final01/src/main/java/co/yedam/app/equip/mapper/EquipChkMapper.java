package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipChkVO;

public interface EquipChkMapper {

	//전체 설비조회(점검페이지)
	public List<EquipChkVO> selectEquipChkAllList();
}