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
	public List<PrcsPlanVO> getPrcsPlanList() {
		return prcsPlanMapper.selectPrcsPlanList();
	}
	
	//상세생산계획 조회
	@Override
	public List<PrcsPlanVO> getPrcsPlanDeList(String prcsPlanCode) {
		return prcsPlanMapper.selectPrcsPlanDeList(prcsPlanCode);
	}

	//생산계획 + 상세생산계획 등록
	@Override
	public int prcsPlanInsert(PrcsPlanVO prcsPlanVO) {
		return prcsPlanMapper.insertPrcsPlan(prcsPlanVO);
	}
	
	//미계획 주문서 조회
	@Override
	public List<OrderVO> getNotPlanOrderList() {
		return prcsPlanMapper.selectNotPlanOrderList();
	}
	

}
