package co.yedam.app.prcs.ing.service.impl;

import java.util.List;
import java.util.Map;

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

	//작업시작 => 공정상태&설비 수정, 공정실적관리 등록 (진행공정 모달)
	@Override
	public int callPrcsStart(Map<String, String> map) {
		return prcsIngMapper.callPrcsStart(map);
	}

	//작업종료 => 공정상태&설비 수정, 공정실적관리 수정 (진행공정 모달)
	@Override
	public int callPrcsEnd(Map<String, String> map) {
		return prcsIngMapper.callPrcsEnd(map);
	}
	
	//데이터 입력된 경우, 공정 실적 관리 조회 (진행공정 모달)
	@Override
	public List<PrcsIngVO> selectPrcsInfoList(PrcsIngVO prcsIngVO) {
		return prcsIngMapper.selectPrcsInfoList(prcsIngVO);
	}
}
