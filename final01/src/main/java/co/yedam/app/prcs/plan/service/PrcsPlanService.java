package co.yedam.app.prcs.plan.service;

import java.util.List;


import co.yedam.app.sales.order.service.OrderVO;

public interface PrcsPlanService {
	//생산계획 조회
	public List<PrcsPlanVO> getPrcsPlanList(String searchPlanName, String startDate, String endDate);
	

	//상세생산계획 조회
	public List<PrcsPlanVO> getPrcsPlanDeList(String prcsPlanCode);
	
	//생산계획 등록
	public String insertPrcsPlan(PrcsPlanVO prcsPlanVO);
	
	//상세생산계획 등록
	public int insertPrcsPlanDe(PrcsPlanVO prcsPlanVO);
	
	
	
	//생산계획 + 상세생산계획 등록
//	public int prcsPlanInsert(List<PrcsPlanVO> prcsPlanList);
	
	//미계획 주문서 조회 
	public List<OrderVO> getNotPlanOrderList();
	
	//생산계획 수정
		
	//생산계획 삭제?
	
	
	//상세생산계획 등록
	//상세생산계획 수정
	//상세생산계획 삭제
}
