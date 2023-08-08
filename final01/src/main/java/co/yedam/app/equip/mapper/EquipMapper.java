package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipVO;

public interface EquipMapper {
	//���� ��ü ��ȸ
	public List<EquipVO> selectEquipAllList();
	
	//���� ���
	public int insertEquipInfo(EquipVO equipVO);
}
