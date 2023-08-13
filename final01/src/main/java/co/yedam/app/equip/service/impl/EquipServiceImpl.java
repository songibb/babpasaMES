package co.yedam.app.equip.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.equip.mapper.EquipMapper;
import co.yedam.app.equip.service.EquipService;
import co.yedam.app.equip.service.EquipVO;

@Service
public class EquipServiceImpl implements EquipService {
	
	@Autowired
	EquipMapper equipMapper;
	
	//�꽕鍮� �쟾泥� 議고쉶
	@Override
	public List<EquipVO> getEquipList() {
		// TODO Auto-generated method stub
		return equipMapper.selectEquipAllList();
	}
	
	@Override
	//�벑濡�
	public String insertEquipInfo(EquipVO equipVO) {
		int result = equipMapper.insertEquipInfo(equipVO);
		if(result == 1) {
			return equipVO.getEqCode();
		}else {
			return "�벑濡앹떎�뙣";
		}
	}
	
	@Override
	//紐⑤떖 �꽕鍮� 議고쉶
	public List<EquipVO> getModalEquipList(){
		return equipMapper.EquipModalList();
	}
	
	@Override
	public Map<String, String> updateEquip(EquipVO equipVO){
		Map<String, String> map = new HashMap<>();
		
		map.put("�꽕鍮꾩퐫�뱶",String.valueOf(equipVO.getEqCode()));
		
		int result = equipMapper.updateEquip(equipVO);
		
		if(result == 1) {
			map.put("寃곌낵", "success");
		}else {
			map.put("寃곌낵", "fail");
		}
		return map;
		
	}
	
	
	@Override
	//�꽕鍮� �궘�젣
	public String deleteEquipInfo(String eqCode) {
		int result = equipMapper.deleteEquip(eqCode);
		if(result == 1) {
			return "�궘�젣 �꽦怨�";
		}else {
			return "�궘�젣 �떎�뙣";
		}
	}
	
	//�꽕鍮� �떒嫄� 議고쉶
	public EquipVO getEquipInfo(EquipVO equipVO) {
		return equipMapper.selectEquipInfo(equipVO);
	}
	
	//설비 검색
	@Override
	public List<EquipVO> searchEquip(String eqName){
		return equipMapper.searchEquip(eqName);
	}

}