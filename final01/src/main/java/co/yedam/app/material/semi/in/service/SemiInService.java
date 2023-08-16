package co.yedam.app.material.semi.in.service;

import java.util.List;

public interface SemiInService {
	//전체조회
	public List<SemiInVO> selectSemiInList();
	public List<SemiInVO> selectSemiInSearch(String productCode, String startDate, String endDate);
	
	//반제품목록 모달
	public List<SemiInVO> getSemiModal();
	
	//생산완료된 반제품 목록
	public List<SemiInVO> selectTestFinishList();
	
	//등록
	public int insertSemiIn(List<SemiInVO> inList);
	
	//수정
	public int updateSemiIn(List<SemiInVO> inList);
	
	//삭제
	public int deleteSemiIn(List<SemiInVO> inList);
}
