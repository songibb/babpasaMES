package co.yedam.app.common.comm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.comm.mapper.CommCodeMapper;
import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.comm.service.CommCodeVO;

@Service
public class CommCodeServiceImpl implements CommCodeService {

	@Autowired
	CommCodeMapper commCodeMapper;
	@Override
	public List<CommCodeVO> selectCommCodeList() {
		
		return commCodeMapper.selectCommCodeList();
	}
	
	@Override
	public List<CommCodeVO> searchCommCode(String commCode) {
		
		return commCodeMapper.searchCommCode(commCode);
	}

	@Override
	public List<CommCodeVO> selectCommDeCodeList(String commCode) {
		
		return commCodeMapper.selectCommDeCodeList(commCode);
	}

	@Override
	public List<CommCodeVO> selectActTypeList() {
		
		return commCodeMapper.selectActTypeList();
	}

	@Override
	public List<CommCodeVO> selectActStsList() {
		
		return commCodeMapper.selectActStsList();
	}

	@Override
	public List<CommCodeVO> selectBomUseInfo() {
		
		return commCodeMapper.selectBomUseInfo();
	}

	@Override
	public List<CommCodeVO> selectBomPrcsUseInfo() {
		
		return commCodeMapper.selectBomPrcsUseInfo();
	}

	@Override
	public List<CommCodeVO> selectMatUnitInfo() {
		
		return commCodeMapper.selectMatUnitInfo();
	}

	@Override
	public List<CommCodeVO> selectProdTypeInfo() {
		
		return commCodeMapper.selectProdTypeInfo();
	}



}
