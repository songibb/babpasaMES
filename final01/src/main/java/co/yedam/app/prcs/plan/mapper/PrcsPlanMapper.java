package co.yedam.app.prcs.plan.mapper;

import java.util.List;

import co.yedam.app.prcs.plan.service.PrcsPlanVO;

public interface PrcsPlanMapper {
	//생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanList();
	
	//생산계획 등록
	//생산계획 수정
	//생산계획 삭제
	
	
	//상세생산계획 조회
	public List<PrcsPlanVO> selectPrcsPlanDeList();
	
	//상세생산계획 등록
	//상세생산계획 수정
	//상세생산계획 삭제
}
