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
	
	//���� ��ü ��ȸ
	@Override
	public List<EquipVO> getEquipList() {
		// TODO Auto-generated method stub
		return equipMapper.selectEquipAllList();
	}
	
	@Override
	//���
	public String insertEquipInfo(EquipVO equipVO) {
		int result = equipMapper.insertEquipInfo(equipVO);
		if(result == 1) {
			return equipVO.getEqCode();
		}else {
			return "��Ͻ���";
		}
	}

}
