package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipVO;

public interface EquipMapper {
	//�꽕鍮� �쟾泥댁“�쉶
	public List<EquipVO> selectEquipAllList();
	
	//�꽕鍮꾨벑濡�
	public int insertEquipInfo(EquipVO equipVO);
	
	//紐⑤떖�뿉�꽌�쓽 �꽕鍮� �쟾泥� 議고쉶
	public List<EquipVO> EquipModalList();
	
	//�꽕鍮� �닔�젙
	public int updateEquip(EquipVO equipVO);
	
	//�궘�젣
	public int deleteEquip(String eqCode);
	
	//�꽕鍮� 愿�由� �럹�씠吏��뿉�꽌 �떒嫄� 議고쉶(紐⑤떖�뿉�꽌 諛쏆븘�샂)
	public EquipVO selectEquipInfo(EquipVO equipVO);
	
	//설비 검색
	public List<EquipVO> searchEquip(String eqName);
}
