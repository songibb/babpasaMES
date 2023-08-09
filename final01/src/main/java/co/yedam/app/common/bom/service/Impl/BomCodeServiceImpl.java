package co.yedam.app.common.bom.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.bom.mapper.BomCodeMapper;
import co.yedam.app.common.bom.service.BomCodeService;
import co.yedam.app.common.bom.service.BomCodeVO;

@Service
public class BomCodeServiceImpl implements BomCodeService {

	@Autowired
	BomCodeMapper bomCodeMapper;
	
	//bno전체조회
	@Override
	public List<BomCodeVO> getBomCodeAll() {
		
		return bomCodeMapper.selectBomCodeList();
	}

	@Override
	public List<BomCodeVO> searchSelectBom(String prodName) {
		
		return bomCodeMapper.searchSelectBom(prodName);
	}

	@Override
	public List<BomCodeVO> getBomDeCodeList(String bomNo) {
		
		return bomCodeMapper.selectDeBomCodeList(bomNo);
	}



}
