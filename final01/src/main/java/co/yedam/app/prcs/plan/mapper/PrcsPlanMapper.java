package co.yedam.app.prcs.plan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;
import co.yedam.app.sales.order.service.OrderVO;

public interface PrcsPlanMapper {
	//생산계획 조회
	//public List<PrcsPlanVO> selectPrcsPlanList(@Param("searchPlanName") String searchPlanName, @Param("startDate")String startDate, @Param("endDate")String endDate);
	public List<PrcsPlanVO> selectPrcsPlanList(PrcsSearchVO prcsSearchVO);
	
	//상세생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanDeList(@Param("prcsPlanCode") String prcsPlanCode);
	
	//생산계획 등록
	public int insertPrcsPlan(PrcsPlanVO prcsPlanVO);
	
	//상세생산계획 등록
	public int insertPrcsPlanDe(PrcsPlanVO prcsPlanVO);
	
	//생산계획 수정
	public int updatePrcsPlan(PrcsPlanVO prcsPlanVO);
	
	//상세생산계획 수정
	public int updatePrcsPlanDe(PrcsPlanVO prcsPlanVO);
	
	//생산계획 삭제
	public int deletePrcsPlan(String planCode);
	
	
	
	//미계획 주문서 조회 
	public List<OrderVO> selectNotPlanOrderList(PrcsSearchVO prcsSearchVO);
	
	//미계획 상세 주문서 조회 
	public List<OrderVO> selectNotPlanOrderDeList(@Param("ordCode") String ordCode);
	
	//생산계획 등록시 주문서 (미계획 -> 계획 / 계획코드 등록) 수정
	public int updateNotPlanOrderList(PrcsPlanVO prcsPlanVO);
	
	//생산계획 삭제시 주문서 (계획 -> 미계획 / 계획코드 삭제) 수정
	public int UpdatePlanOrderList(String planCode);
	
	
	//상세생산계획 모두 지시완료시 생산계획 수정
	public int updatePlanDirSts(@Param("prcsPlanCode") String prcsPlanCode);
	
}
