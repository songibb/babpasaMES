package co.yedam.app.prcs.plan.service;

import java.util.List;

public interface PrcsPlanService {
	//생산계획 조회
	public List<PrcsPlanVO> getPrcsPlanList();
	
	//생산계획 등록
	//생산계획 수정?
	//생산계획 삭제?
	
	
	//상세생산계획 조회
	public List<PrcsPlanVO> getPrcsPlanDeList();
	
	//상세생산계획 등록
	//상세생산계획 수정
	//상세생산계획 삭제
}
