package co.yedam.app.prcs.plan.service;

import java.util.List;

import co.yedam.app.sales.order.service.OrderVO;

public interface PrcsPlanService {
	//생산계획 조회
	//public List<PrcsPlanVO> selectPrcsPlanList(String searchPlanName, String startDate, String endDate);
	public List<PrcsPlanVO> selectPrcsPlanList(PrcsSearchVO prcsSearchVO);
	
	//상세생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanDeList(String prcsPlanCode);
	
	//생산계획 등록
	//public String insertPrcsPlan(PrcsPlanVO prcsPlanVO);
	public int insertPrcsPlan(PrcsPlanReqVO prcsPlanReqVO);
	
	//상세생산계획 등록
	//public int insertPrcsPlanDe(List<PrcsPlanVO> list);

	//생산계획 수정
	//public int updatePrcsPlan(List<PrcsPlanVO> list);
	public int updatePrcsPlan(PrcsPlanReqVO prcsPlanReqVO);
	
	//상세생산계획 수정
	//public int updatePrcsPlanDe(List<PrcsPlanVO> list);
		
	//생산계획 삭제
	public int deletePrcsPlan(List<String> list);
	
	
	
	//미계획 주문서 조회 
	public List<OrderVO> selectNotPlanOrderList(PrcsSearchVO prcsSearchVO);
	
	//미계획 상세 주문서 조회 
	public List<OrderVO> selectNotPlanOrderDeList(List<OrderVO> ordList);
		
	//생산계획 등록시 주문서 (미계획 -> 계획) 수정
	//public int updateNotPlanOrderList(PrcsPlanVO prcsPlanVO);

	//상세생산계획 모두 지시완료시 생산계획 수정
	//public int updatePlanDirSts(List<PrcsPlanVO> planList);
	
}
