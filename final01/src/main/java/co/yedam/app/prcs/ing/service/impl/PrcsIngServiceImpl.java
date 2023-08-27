package co.yedam.app.prcs.ing.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.prcs.ing.mapper.PrcsIngMapper;
import co.yedam.app.prcs.ing.service.PrcsIngService;
import co.yedam.app.prcs.ing.service.PrcsIngVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;

@Service
public class PrcsIngServiceImpl implements PrcsIngService {
	
	@Autowired
	PrcsIngMapper prcsIngMapper;

	//진행 공정 조회
	@Override
	public List<PrcsIngVO> selectPrcsIngList(String prcsDirDeCode, String prodCode) {
		return prcsIngMapper.selectPrcsIngList(prcsDirDeCode, prodCode);
	}	

	//작업 시작 전 사용 가능한 설비 조회 (진행공정 모달)
	@Override
	public List<EquipVO> selectWaitEquipList(PrcsIngVO prcsIngVO) {
		return prcsIngMapper.selectWaitEquipList(prcsIngVO);
	}
	
	//작업 시작 후 선택된 설비 조회 (진행공정 모달)
	@Override
	public List<EquipVO> selectEquip(String prcsDirDeCode, String prcdCode) {
		return prcsIngMapper.selectEquip(prcsDirDeCode, prcdCode);
	}

	//투입 자재별 소모량 조회 (진행공정 모달)
	@Override
	public List<BomCodeVO> selectMatBomList(PrcsIngVO prcsIngVO) {
		return prcsIngMapper.selectMatBomList(prcsIngVO);
	}

	//작업시작 => 공정상태&설비 수정, 공정실적관리 등록 (진행공정 모달)
	@Override
	public int callPrcsStart(PrcsIngVO prcsIngVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prcsDirDeCode", prcsIngVO.getPrcsDirDeCode());
		map.put("prcsCode", prcsIngVO.getPrcsCode());
		map.put("eqCode", prcsIngVO.getEqCode());
		map.put("empCode", prcsIngVO.getEmpCode());
		map.put("prcsStartTime", prcsIngVO.getPrcsStartTime());
		return prcsIngMapper.callPrcsStart(map);
	}

	//작업종료 => 공정상태&설비 수정, 공정실적관리 수정 (진행공정 모달)
	@Override
	public int callPrcsEnd(PrcsIngVO prcsIngVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prcsDirDeCode", prcsIngVO.getPrcsDirDeCode());
		map.put("prcsCode", prcsIngVO.getPrcsCode());
		map.put("eqCode", prcsIngVO.getEqCode());
		map.put("errAmt", prcsIngVO.getErrAmt());
		map.put("prcsEndTime", prcsIngVO.getPrcsEndTime());
		return prcsIngMapper.callPrcsEnd(map);
	}
	
	//데이터 입력된 경우, 공정 실적 관리 조회 (진행공정 모달)
	@Override
	public PrcsIngVO selectPrcsInfoList(String prcsDirDeCode, String prcdCode) {
		return prcsIngMapper.selectPrcsInfoList(prcsDirDeCode, prcdCode);		
	}

	//작업시작 => 진행 공정 조회 (이전 공정 미완료 확인용 -> 미완료시 작업버튼 실행X) (진행공정 모달)
//	@Override
//	public List<PrcsIngVO> selectPrcsIngSts(String prcsDirDeCode, String prodCode) {
//		List<PrcsIngVO> list = prcsIngMapper.selectPrcsIngSts(prcsDirDeCode, prodCode);
//		for(PrcsIngVO vo : list) {
//			
//			int result = 0;
//
//			//해당 공정이 반제품공정일때
//			if(vo.getSemiYn().equals("Y")) {
//			
//				//해당 공정이 반제품 공정이면서, 공정상태가 공정완료일때
//				if(vo.getPrcsDirIngSts().equals("공정완료")) {
//					
//					result++;
//				}
//		
//			//	
//			} else if(vo.getSemiYn().equals("N") && vo.getPrcsSeq() == )
//			
//		}
//		return list;
//	}
	
	//작업시작 => 이전 공정 미완료 확인용 -> 미완료시 작업버튼 실행X (프로시저) (진행공정 모달)
	public String selectPrcsIngSts(PrcsIngVO prcsIngVO) {
		prcsIngMapper.selectPrcsIngSts(prcsIngVO);
		
		//프로시저 out값 찾기
		String result = prcsIngVO.getResult();
		if(result == null) {
			return "true";
		}
		return result;
	}
	

	//공정 실적 조회 (검색)
	@Override
	public List<PrcsIngVO> selectPrcsResultList(PrcsSearchVO prcsSearchVO) {
		return prcsIngMapper.selectPrcsResultList(prcsSearchVO);
	}

	


}
