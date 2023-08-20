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

	@Override
	public String bomCodeInsert(BomCodeVO bomCodeVO) {
		int result = bomCodeMapper.bomCodeInsert(bomCodeVO);
		String bomNo = bomCodeVO.getBomNo();
		
		if(result > 0) {
			return bomNo;
			
		}else {
			return "실패";
		}
	}

	@Override
	public int bomDeCodeInsert(List<BomCodeVO> list) {
		int result = 0;
		for(BomCodeVO vo : list) {
			bomCodeMapper.bomDeCodeInsert(vo);
			result++;
		}
		return result;
	}

	@Override
	public int updateBom(List<BomCodeVO> list) {
		int result = 0;
		for(BomCodeVO vo : list) {
			bomCodeMapper.updateBom(vo);
			result++;
		}
		return result;
	}

	@Override
	public int updateDeBom(List<BomCodeVO> list) {
		int result = 0;
		for(BomCodeVO vo : list) {
			bomCodeMapper.updateDeBom(vo);
			result++;
		}
		return result;
	}

	@Override
	public int deleteDeBom(List<BomCodeVO> list) {
		int result = 0;
		for(BomCodeVO bomCode : list) {
			bomCodeMapper.deleteDeBom(bomCode);
			result++;
		}
		return result;
	}



}
