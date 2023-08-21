package co.yedam.app.material.rt.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.search.service.SearchVO;




public interface MatRtService {
	//전체조회
	public List<MatRtVO> selectMatRtList();
	public List<MatRtVO> selectMatRtSearch(SearchVO vo);
	
	
	//검수완료 목록
	public List<MatTestVO> selectMatTestFinishList();
	
	//삭제 행 정보
	public List<MatTestVO> getDeletedRowsInfo(List<MatRtVO> list);
	
		
	//등록, 수정, 삭제
	public int modifyMatRt(GridVO<MatRtVO> data);
	
}
