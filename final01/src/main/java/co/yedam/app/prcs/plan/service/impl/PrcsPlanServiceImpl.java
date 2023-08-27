package co.yedam.app.prcs.plan.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.plan.mapper.PrcsPlanMapper;
import co.yedam.app.prcs.plan.service.PrcsPlanReqVO;
import co.yedam.app.prcs.plan.service.PrcsPlanService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;
import co.yedam.app.sales.order.service.OrderVO;

@Service
public class PrcsPlanServiceImpl implements PrcsPlanService {
	
	@Autowired
	PrcsPlanMapper prcsPlanMapper;
	
	//생산계획 조회
	@Override
//	public List<PrcsPlanVO> selectPrcsPlanList(String searchPlanName, String startDate, String endDate) {
//		return prcsPlanMapper.selectPrcsPlanList(searchPlanName, startDate, endDate);
//	}
	public List<PrcsPlanVO> selectPrcsPlanList(PrcsSearchVO prcsSearchVO) {
		List<PrcsPlanVO> planList = prcsPlanMapper.selectPrcsPlanList(prcsSearchVO);
		
		//상세생산계획 모두 지시완료시 생산계획 수정
		for(PrcsPlanVO vo  : planList) {
			prcsPlanMapper.updatePlanDirSts(vo.getPrcsPlanCode());	
		}
		
		//수정된 새로운 리스트 조회
		List<PrcsPlanVO> updatePlanList = prcsPlanMapper.selectPrcsPlanList(prcsSearchVO);
		
		return updatePlanList;
	}
	
	//상세생산계획 조회
	@Override
	public List<PrcsPlanVO> selectPrcsPlanDeList(String prcsPlanCode) {
		return prcsPlanMapper.selectPrcsPlanDeList(prcsPlanCode);
	}

	//생산계획 등록
	@Override
	public int insertPrcsPlan(PrcsPlanReqVO prcsPlanReqVO) {
		//생산계획 등록
		int result = prcsPlanMapper.insertPrcsPlan(prcsPlanReqVO.getPrcsPlanVO());
		
		//selectKey 값 가져오기
		String prcsPlanCode = String.valueOf(prcsPlanReqVO.getPrcsPlanVO().getPrcsPlanCode());		
				
		int resultDe = 0;
		for(PrcsPlanVO vo : prcsPlanReqVO.getInsertList()) {
			vo.setPrcsPlanCode(prcsPlanCode);

			//상세생산계획 등록
			prcsPlanMapper.insertPrcsPlanDe(vo);
			
			//생산계획 등록시 주문서 (미계획 -> 계획 / 계획코드 등록) 수정
			prcsPlanMapper.updateNotPlanOrderList(vo);
			resultDe++;
		}
		
		result = result + resultDe;
		return result;
	}
	
	//상세생산계획 등록
//	@Override
//	public int insertPrcsPlanDe(List<PrcsPlanVO> list) {
//		int result = 0;
//		for(PrcsPlanVO vo : list) {
//			prcsPlanMapper.insertPrcsPlanDe(vo);
//			
//			//생산계획 등록시 주문서 (미계획 -> 계획 / 계획코드 등록) 수정
//			prcsPlanMapper.updateNotPlanOrderList(vo);
//			result++;
//		}
//		return result;
//	}
	
	//생산계획 수정
	@Override
	public int updatePrcsPlan(PrcsPlanReqVO prcsPlanReqVO) {		
		int result = 0;
		for(PrcsPlanVO vo : prcsPlanReqVO.getUpdateList()) {
			prcsPlanMapper.updatePrcsPlan(vo);			
			result++;
		}	
		
		//상세생산계획 수정
		for(PrcsPlanVO vo : prcsPlanReqVO.getUpdateDeList()) {
			prcsPlanMapper.updatePrcsPlanDe(vo);		
		}
			
		return result;
	}
	
	//상세생산계획 수정
//	@Override
//	public int updatePrcsPlanDe(List<PrcsPlanVO> list) {		
//		int result = 0;
//		for(PrcsPlanVO vo : list) {
//			prcsPlanMapper.updatePrcsPlanDe(vo);
//			result++;
//		}
//		return result;
//	}
	
	//생산계획 삭제
	@Override
	public int deletePrcsPlan(List<String> list) {
		int result = 0;
		for(String planCode : list) {
			prcsPlanMapper.deletePrcsPlan(planCode);
			
			//생산계획 삭제시 주문서 (계획 -> 미계획 / 계획코드 삭제) 수정
			prcsPlanMapper.UpdatePlanOrderList(planCode);
			result++;
		}
		return result;
	}



	
	//미계획 주문서 조회
	@Override
	public List<OrderVO> selectNotPlanOrderList() {
		return prcsPlanMapper.selectNotPlanOrderList();
	}
	
	//미계획 상세주문서 조회
	@Override
	public List<OrderVO> selectNotPlanOrderDeList(List<OrderVO> ordList) {	
		
		List<OrderVO> deList = new ArrayList<>();

		for(OrderVO vo : ordList) {
			String ordCode = vo.getOrdCode();

			deList.addAll(prcsPlanMapper.selectNotPlanOrderDeList(ordCode));
		}

		return deList;
	}


	//상세생산계획 모두 지시완료시 생산계획 수정      => 생산계획 조회에 합침
//	@Override
//	public int updatePlanDirSts(List<PrcsPlanVO> planList) {
//		int result = 0;
//		for(PrcsPlanVO vo : planList) {
//			prcsPlanMapper.updatePlanDirSts(vo.getPrcsPlanCode());
//			result++;
//		}
//		return result;
//	}
	
	//생산계획 등록시 주문서 (미계획 -> 계획 / 계획코드 등록) 수정    => 생산계획 등록에 합침
//	@Override
//	public int updateNotPlanOrderList(PrcsPlanVO prcsPlanVO) {
//		return prcsPlanMapper.updateNotPlanOrderList(prcsPlanVO);
//	}

	
	

}
