package co.yedam.app.prcs.ing.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.prcs.ing.mapper.PrcsIngMapper;
import co.yedam.app.prcs.ing.service.PrcsIngService;
import co.yedam.app.prcs.ing.service.PrcsIngVO;

@Service
public class PrcsIngServiceImpl implements PrcsIngService {
	
	@Autowired
	PrcsIngMapper prcsIngMapper;

	//진행 공정 조회
	@Override
	public List<PrcsIngVO> selectPrcsIngList(String prcsDirDeCode, String prodCode) {
		return prcsIngMapper.selectPrcsIngList(prcsDirDeCode, prodCode);
	}
	
	
	//진행 공정 등록
	@Override
	public int insertPrcsIng(String prcsDirDeCode) {
		return prcsIngMapper.insertPrcsIng(prcsDirDeCode);

	}

	//사용 가능한 설비 조회 (진행공정 모달)
	@Override
	public List<EquipVO> selectWaitEquipList(PrcsIngVO prcsIngVO) {
		return prcsIngMapper.selectWaitEquipList(prcsIngVO);
	}

	//투입 자재별 소모량 조회 (진행공정 모달)
	@Override
	public List<BomCodeVO> selectMatBomList(PrcsIngVO prcsIngVO) {
		return prcsIngMapper.selectMatBomList(prcsIngVO);
	}
}
