package co.yedam.app.equip.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.equip.mapper.EquipMapper;
import co.yedam.app.equip.service.EquipService;
import co.yedam.app.equip.service.EquipVO;

@Service
public class EquipServiceImpl implements EquipService {
	
	@Autowired
	EquipMapper equipMapper;
	
	//설비 전체 조회
	@Override
	public List<EquipVO> getEquipList() {
		// TODO Auto-generated method stub
		return equipMapper.selectEquipAllList();
	}
	
	@Override
	//등록
	public String insertEquipInfo(EquipVO equipVO) {
		int result = equipMapper.insertEquipInfo(equipVO);
		if(result == 1) {
			return equipVO.getEqCode();
		}else {
			return "등록실패";
		}
	}
	
	@Override
	//모달 설비 조회
	public List<EquipVO> getModalEquipList(){
		return equipMapper.EquipModalList();
	}
	
	@Override
	//설비 수정
	public String updateEquipInfo(EquipVO equipVO) {
		int result = equipMapper.updateEquip(equipVO);
		if(result ==1) {
			return equipVO.getEqCode();
		}else {
			return "수정실패";
		}
	}
	
	
	@Override
	//설비 삭제
	public int deleteEquipInfo(String eqCode) {
		int result = equipMapper.deleteEquip(eqCode);
		if(result == 1) {
			return 0;
		}else {
			return -1;
		}
	}
	
	//설비 단건 조회
	public EquipVO getEquipInfo(EquipVO equipVO) {
		return equipMapper.selectEquipInfo(equipVO);
	}
	

}