package co.yedam.app.common.bom.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.bom.mapper.BomCodeMapper;
import co.yedam.app.common.bom.service.BomCodeService;
import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.common.bom.service.BomReqVO;

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

	public int bomCodeInsert(BomReqVO bomReqVO) {
		//마스터 등록
		int result = bomCodeMapper.bomCodeInsert(bomReqVO.getBomCodeVO());
		String bomNo = String.valueOf(bomReqVO.getBomCodeVO().getBomNo());
		System.out.println("1"+bomNo);
		//디테일등록
		System.out.println("------------------"+bomReqVO.getBomList());
		for(BomCodeVO vo : bomReqVO.getBomList()) {
			System.out.println("2"+vo);
			vo.setBomNo(bomNo);
			
			bomCodeMapper.bomDeCodeInsert(vo);
			result++;
		}
		
		return result;
	}

	/*
	 * @Override public int bomDeCodeInsert(List<BomCodeVO> list) { int result = 0;
	 * for(BomCodeVO vo : list) { bomCodeMapper.bomDeCodeInsert(vo); result++; }
	 * return result; }
	 */

	@Override
	public int updateBom(BomReqVO bomReqVO) {
		
		int result =0;
		
		for(BomCodeVO vo : bomReqVO.getBomUpList()) {
			bomCodeMapper.updateBom(vo);
			result++;
		}
		
		for(BomCodeVO vo : bomReqVO.getBomUpDeList()) {
			bomCodeMapper.updateDeBom(vo);
			result++;
		}
		
		return result;
		
	}

	/*
	 * @Override public int updateDeBom(List<BomCodeVO> list) { int result = 0;
	 * for(BomCodeVO vo : list) { bomCodeMapper.updateDeBom(vo); result++; } return
	 * result; }
	 */

	@Override
	public int bomDelete(List<BomCodeVO> list) {
		
		
		int result = 0;
		
		for(BomCodeVO bomNo : list) {
			bomCodeMapper.deleteBom(bomNo);
			result++;
		}
		
		for(BomCodeVO bomNo : list) {
			bomCodeMapper.deleteDeBom(bomNo);
			
		}
		
		
		return result;
	}

	
	
	//chart test
	@Override
	public List<BomCodeVO> chartTest() {
		
		return bomCodeMapper.chartTest();
	}

	@Override
	public int updateBomHeader(List<BomCodeVO> list) {
		int result = 0;
		for(BomCodeVO bomCode : list) {
			bomCodeMapper.updateBom(bomCode);
			result++;
		}
		return result; 
	}

	@Override
	public List<BomCodeVO> DeBomCallList(String bomNo) {
		
		return bomCodeMapper.DeBomCallList(bomNo);
	}



}
