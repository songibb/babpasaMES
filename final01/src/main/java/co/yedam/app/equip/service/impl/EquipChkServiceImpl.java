package co.yedam.app.equip.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.equip.mapper.EquipChkMapper;
import co.yedam.app.equip.service.EquipChkService;
import co.yedam.app.equip.service.EquipChkVO;

@Service
public class EquipChkServiceImpl implements EquipChkService {

	
	//점검 설비 전체 조회
	@Autowired
	EquipChkMapper equipChkMapper;
	
	@Override
	public List<EquipChkVO> getEquipChkList() {
		// TODO Auto-generated method stub
		return equipChkMapper.selectEquipChkAllList();
	}
	
	//점검 설비 수정
	@Override
	public int updateChkEquip(EquipChkVO equipChkVO) {
		int result = equipChkMapper.updateChkequip(equipChkVO);
		if(result > 0) {
			return 1;
		}else {
			return -1;
		}
		
	}
	
	//모달 : 사원 조회
	@Override
	public List<EquipChkVO> selectEmpList(){
		return equipChkMapper.selectEmpList();
				
	}

}