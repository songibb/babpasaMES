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
	public int insertPrcsPlanDe(List<PrcsPlanVO> list);
	
	//생산계획 + 상세생산계획 등록
//	public int prcsPlanInsert(List<PrcsPlanVO> prcsPlanList);

	//생산계획 수정
	public int updatePrcsPlan(List<PrcsPlanVO> list);
	
	//상세생산계획 수정
	public int updatePrcsPlanDe(List<PrcsPlanVO> list);
		
	//생산계획 삭제
	public int deletePrcsPlan(List<String> list);
	
	
	
	//미계획 주문서 조회 
	public List<OrderVO> getNotPlanOrderList();
	
	//미계획 상세 주문서 조회 
//	public List<OrderVO> getNotPlanOrderDeList(String ordCode);
	public List<OrderVO> getNotPlanOrderDeList(List<OrderVO> ordList);
		
	//생산계획 등록시 주문서 (미계획 -> 계획) 수정
	//public int updateNotPlanOrderList(PrcsPlanVO prcsPlanVO);
	
	
}
