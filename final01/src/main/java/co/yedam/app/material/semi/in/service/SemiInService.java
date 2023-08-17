package co.yedam.app.material.semi.in.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface SemiInService {
	//전체조회
	public List<SemiInVO> selectSemiInList();
	public List<SemiInVO> selectSemiInSearch(String productCode, String startDate, String endDate);
	
	//반제품목록 모달
	public List<SemiInVO> getSemiModal();
	
	//생산완료된 반제품 목록
	public List<SemiInVO> selectTestFinishList();
	
	//등록, 수정, 삭제
	public int modifySemiIn(GridVO<SemiInVO> data);
	
}
