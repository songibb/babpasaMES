package co.yedam.app.prcs.plan.service.impl;

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
	public int insertPrcsPlanDe(PrcsPlanVO prcsPlanVO) {
		int result = prcsPlanMapper.insertPrcsPlanDe(prcsPlanVO);
		if(result > 0) {
			return 1;
		} else {
			return -1;
		}
	}
	
	
	
	
	//생산계획 + 상세생산계획 등록
//	@Override
//	public int prcsPlanInsert(List<PrcsPlanVO> prcsPlanList) {
//		int result = prcsPlanMapper.insertPrcsPlan(prcsPlanList);		
//		return result;
//	}
	
	//미계획 주문서 조회
	@Override
	public List<OrderVO> getNotPlanOrderList() {
		return prcsPlanMapper.selectNotPlanOrderList();
	}




	

}
