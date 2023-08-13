package co.yedam.app.equip.service;

import java.util.List;
import java.util.Map;

public interface EquipService {
	//�쟾泥� �꽕鍮� 議고쉶
	public List<EquipVO> getEquipList();
	
	//�꽕鍮� �벑濡�
	public String insertEquipInfo(EquipVO equipVO);
	
	//紐⑤떖 �븞�뿉�꽌�쓽 �쟾泥� �꽕鍮� 議고쉶
	public List<EquipVO> getModalEquipList();
	
	//�꽕鍮� �궘�젣
	public String deleteEquipInfo(String eqCode);
	
	//�꽕鍮� �떒嫄댁“�쉶
	public EquipVO getEquipInfo(EquipVO equipVO);
	
	//�꽕鍮� �닔�젙
	public Map<String, String> updateEquip(EquipVO equipVO);
	
	//설비 검색
	public List<EquipVO> searchEquip (String eqName);


}
