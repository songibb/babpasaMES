package co.yedam.app.material.order.de.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.order.de.service.MatOrderDeVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;

public interface MatOrderDeMapper {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate, @Param("before") String before, @Param("comple") String comple);
	
	//거래처목록, 구매품목 필요함
	//구매품목 select
	public List<MatInVO> selectBuyMatList(String actCode); 
	
	//등록
	public int insertMatOrderList(MatOrderDeVO vo);
	public int insertMatOrderDeList(MatOrderDeVO vo);
	
	//수정
	public int updateMatOrderList(MatOrderDeVO vo);
	
	//삭제
	public int deleteMatOrderList();
	public int deleteMatOrderDeList(MatOrderDeVO vo);
	
	//신규생산계획
	public List<PrcsPlanVO> selectNewPrcsPlan();
	
	//해당 계획 소모 자재
	public List<MatInVO> selectNewPlanUseAmt(String prodCode);
}
