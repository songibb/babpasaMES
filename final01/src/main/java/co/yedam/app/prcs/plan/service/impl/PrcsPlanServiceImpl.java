package co.yedam.app.prcs.plan.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.plan.mapper.PrcsPlanMapper;
import co.yedam.app.prcs.plan.service.PrcsPlanService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.sales.order.service.OrderVO;

@Service
public class PrcsPlanServiceImpl implements PrcsPlanService {
	
	@Autowired
	PrcsPlanMapper prcsPlanMapper;
	
	//생산계획 조회
	@Override
	public List<PrcsPlanVO> getPrcsPlanList(String searchPlanName, String startDate, String endDate) {
		return prcsPlanMapper.selectPrcsPlanList(searchPlanName, startDate, endDate);
	}
	
	//상세생산계획 조회
	@Override
	public List<PrcsPlanVO> getPrcsPlanDeList(String prcsPlanCode) {
		return prcsPlanMapper.selectPrcsPlanDeList(prcsPlanCode);
	}

	//생산계획 등록
	@Override
	public String insertPrcsPlan(PrcsPlanVO prcsPlanVO) {
		//selectKey 값 가져오기
		int result = prcsPlanMapper.insertPrcsPlan(prcsPlanVO);
		String prcsPlanCode = String.valueOf(prcsPlanVO.getPrcsPlanCode());
		if(result > 0) {
			return prcsPlanCode;
		} else {
			return "실패";
		}
	}
	
	//상세생산계획 등록
	@Override
	public int insertPrcsPlanDe(List<PrcsPlanVO> list) {
		int result = 0;
		for(PrcsPlanVO vo : list) {
			prcsPlanMapper.insertPrcsPlanDe(vo);
			
			//생산계획 등록시 주문서 (미계획 -> 계획) 수정
			prcsPlanMapper.updateNotPlanOrderList(vo);
			result++;
		}
		return result;
	}

	//생산계획 + 상세생산계획 등록
//	@Override
//	public int prcsPlanInsert(List<PrcsPlanVO> prcsPlanList) {
//		int result = prcsPlanMapper.insertPrcsPlan(prcsPlanList);		
//		return result;
//	}

	
	//생산계획 수정
	@Override
	public int updatePrcsPlan(List<PrcsPlanVO> list) {		
		int result = 0;
		for(PrcsPlanVO vo : list) {
			prcsPlanMapper.updatePrcsPlan(vo);
			
			result++;
		}	
		return result;
	}
	
	//상세생산계획 수정
	@Override
	public int updatePrcsPlanDe(List<PrcsPlanVO> list) {		
		int result = 0;
		for(PrcsPlanVO vo : list) {
			prcsPlanMapper.updatePrcsPlanDe(vo);
			result++;
		}
		return result;
	}
	
	//생산계획 삭제
	@Override
	public int deletePrcsPlan(List<String> list) {
		int result = 0;
		for(String code : list) {
			prcsPlanMapper.deletePrcsPlan(code);
			result++;
		}
		return result;
	}



	
	//미계획 주문서 조회
	@Override
	public List<OrderVO> getNotPlanOrderList() {
		return prcsPlanMapper.selectNotPlanOrderList();
	}
	
	//미계획 상세주문서 조회
//	@Override
//	public List<OrderVO> getNotPlanOrderDeList(String ordCode) {		
//		return prcsPlanMapper.selectNotPlanOrderDeList(ordCode);
//	}
	
	//미계획 상세주문서 조회
	@Override
	public List<OrderVO> getNotPlanOrderDeList(List<OrderVO> ordList) {	
		
		List<OrderVO> deList = new ArrayList<>();

		for(OrderVO vo : ordList) {
			String ordCode = vo.getOrdCode();

			deList.addAll(prcsPlanMapper.selectNotPlanOrderDeList(ordCode));
		}

		return deList;
	}
	
	//생산계획 등록시 주문서 (미계획 -> 계획) 수정
//	@Override
//	public int updateNotPlanOrderList(PrcsPlanVO prcsPlanVO) {
//		return prcsPlanMapper.updateNotPlanOrderList(prcsPlanVO);
//	}


	

}
