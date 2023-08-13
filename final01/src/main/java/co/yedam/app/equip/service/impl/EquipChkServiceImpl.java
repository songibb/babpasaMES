package co.yedam.app.equip.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.equip.mapper.EquipChkMapper;
import co.yedam.app.equip.service.EquipChkService;
import co.yedam.app.equip.service.EquipChkVO;

@Service
public class EquipChkServiceImpl implements EquipChkService {

	
	//mapper »£√‚
	@Autowired
	EquipChkMapper equipChkMapper;
	
	@Override
	public List<EquipChkVO> getEquipChkList() {
		// TODO Auto-generated method stub
		return equipChkMapper.selectEquipChkAllList();
	}

}