package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipChkVO;

public interface EquipChkMapper {

	//점검 설비 전체 조회(그리드)
	public List<EquipChkVO> selectEquipChkAllList();

	//점검 설비 수정
	public int updateChkequip(EquipChkVO equipChkVO);
}