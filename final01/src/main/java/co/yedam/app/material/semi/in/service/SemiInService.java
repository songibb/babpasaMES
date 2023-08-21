package co.yedam.app.material.semi.in.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.search.service.SearchVO;

public interface SemiInService {
	//전체조회
	public List<SemiInVO> selectSemiInList();
	public List<SemiInVO> selectSemiInSearch(SearchVO vo);
	
	//반제품목록 모달
	public List<SemiInVO> getSemiModal();
	
	//모달 검색
	public List<SemiInVO> getSemiModalSearch(String prodName);
	
	//생산완료된 반제품 목록
	public List<SemiInVO> selectTestFinishList();
	
	//삭제 행 정보
	public List<SemiInVO> getDeletedRowsInfo(List<SemiInVO> list);
	
	//등록, 수정, 삭제
	public int modifySemiIn(GridVO<SemiInVO> data);
	
	
}
