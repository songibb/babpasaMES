package co.yedam.app.prcs.plan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.plan.service.PrcsPlanVO;

public interface PrcsPlanMapper {
	//생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanList();
	
	//상세생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanDeList(@Param("prcsPlanCode") String prcsPlanCode);
	
	//생산계획 등록
	public int insertPrcsPlan(PrcsPlanVO prcsPlanVO);
	
	//상세생산계획 등록	
	public int insertPrcsPlanDe(PrcsPlanVO prcsPlanVO);
	
	//생산계획 수정
	
	//생산계획 삭제
	

	//상세생산계획 수정
	//상세생산계획 삭제
}
