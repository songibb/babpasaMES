package co.yedam.app.equip.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.equip.mapper.OffEquipMapper;
import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.equip.service.OffEquipService;
import co.yedam.app.equip.service.OffEquipVO;

@Service
public class OffEquipServiceImpl implements OffEquipService {

	//mapper 호출
	@Autowired
	OffEquipMapper offEquipMapper;
	
	//비가동 설비 전체 조회
	@Override
	public List<OffEquipVO> getOffEquipList() {
		// TODO Auto-generated method stub
		return offEquipMapper.selectOffEquipAllList();
	}

	@Override
	public List<OffEquipVO> getAllEquip(){
		return offEquipMapper.selectAllequip();
	}
	
	@Override
	//등록
	public String insertOffEquip(OffEquipVO offequipVO) {
		int result = offEquipMapper.insertOffEquip(offequipVO);
		if(result == 1) {
			return offequipVO.getEqCode();
					
		}else {
			return "등록실패";
		}
	}
	
	//모달 단건 조회 
	public OffEquipVO getOffEquipInfo(OffEquipVO offequipVO) {
		return offEquipMapper.selectOffEquipInfo(offequipVO);
		
	}
}