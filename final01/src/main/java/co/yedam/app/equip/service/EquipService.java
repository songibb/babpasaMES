package co.yedam.app.equip.service;

import java.util.List;

public interface EquipService {
	//���� ��ü ��ȸ
	public List<EquipVO> getEquipList();
	
	//���� ���
	public String insertEquipInfo(EquipVO equipVO);
}
