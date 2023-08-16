package co.yedam.app.material.in.service;

import java.util.List;



import co.yedam.app.material.rt.service.MatTestVO;




public interface MatInService {
	//조회
	public List<MatInVO> selectMatInList();
	public List<MatInVO> selectMatInSearch(String materialCode, String accountCode, String startDate, String endDate);
	
	//검수됐지만 입고안 된 자재들 목록
	public List<MatTestVO> selectMatTestFinishList();
	
	//등록
	public int insertMatIn(List<MatInVO> inList);
		
	//수정
	public int updateMatIn(List<MatInVO> inList);
		
	//삭제
	public int deleteMatIn(List<MatInVO> inList);
}
