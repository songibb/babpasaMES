package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.equip.service.OffEquipVO;

public interface OffEquipMapper {
	
	//���� ��ü ��ȸ
	public List<OffEquipVO> selectAllequip();
	
	//�񰡵� ���� ��ü��ȸ
	public List<OffEquipVO> selectOffEquipAllList();
	
	//�񰡵� ���� ���
	public int insertOffEquip(OffEquipVO offequipVO);
	
	//��� ��ȸ�� ��ü���� �ܰ����� ��������(��ȸ)
	public OffEquipVO selectOffEquipInfo(OffEquipVO offequipVO);
}