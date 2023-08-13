package co.yedam.app.prcs.plan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.sales.order.service.OrderVO;

public interface PrcsPlanMapper {
	//생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanList(@Param("searchPlanName") String searchPlanName, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//상세생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanDeList(@Param("prcsPlanCode") String prcsPlanCode);
	
	//생산계획 등록
	public int insertPrcsPlan(PrcsPlanVO prcsPlanVO);
	
	//상세생산계획 등록
	public int insertPrcsPlanDe(PrcsPlanVO prcsPlanVO);

	//생산계획 + 상세생산계획 등록
//	public int insertPrcsPlan(List<PrcsPlanVO> prcsPlanList);
	
	//미계획 주문서 조회 
	public List<OrderVO> selectNotPlanOrderList();
	
	//생산계획 수정
	public int updatePrcsPlan(PrcsPlanVO prcsPlanVO);
	
	//상세생산계획 수정
	public int updatePrcsPlanDe(PrcsPlanVO prcsPlanVO);
	
	//생산계획 삭제
	public int deletePrcsPlan(@Param("prcsPlanCode") String prcsPlanCode);

}
