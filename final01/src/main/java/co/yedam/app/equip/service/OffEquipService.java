package co.yedam.app.equip.service;

import java.util.List;

public interface OffEquipService {
	//��ü �񰡵� ���� ��ȸ
	public List<OffEquipVO> getOffEquipList();
	
	//��� �ȿ����� ��ü ���� ��ȸ
	public List<OffEquipVO> getAllEquip();
	
	//�񰡵� ���
	public String insertOffEquip(OffEquipVO offequipVO);
	
	//��޿��� ������� ���� �ܰ����� �������(��ȸ)
	public OffEquipVO getOffEquipInfo(OffEquipVO offequipVO);
}