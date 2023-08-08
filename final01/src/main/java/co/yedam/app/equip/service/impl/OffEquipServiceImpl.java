package co.yedam.app.equip.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.equip.mapper.OffEquipMapper;
import co.yedam.app.equip.service.OffEquipService;
import co.yedam.app.equip.service.OffEquipVO;

@Service
public class OffEquipServiceImpl implements OffEquipService {

	//mapper 호출
	@Autowired
	OffEquipMapper offEquipMapper;
	
	@Override
	public List<OffEquipVO> getOffEquipList() {
		// TODO Auto-generated method stub
		return offEquipMapper.selectOffEquipAllList();
	}

}
