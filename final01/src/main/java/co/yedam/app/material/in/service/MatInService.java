package co.yedam.app.material.in.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.rt.service.MatTestVO;
import co.yedam.app.material.search.service.SearchVO;
import co.yedam.app.material.stock.service.MatLotStockVO;




public interface MatInService {
	//조회
	public List<MatInVO> selectMatInList();
	public List<MatInVO> selectMatInSearch(SearchVO vo);
	
	//검수됐지만 입고안 된 자재들 목록
	public List<MatTestVO> selectMatTestFinishList();
	
	//삭제한 행 정보찾기
	public List<MatTestVO> getDeletedMatTest(List<MatInVO> list);
	
	//등록, 수정, 삭제
	public int modifyMatIn(GridVO<MatInVO> data);
	
	//정산 페이지
	public List<MatInVO> getMatLotModal(MatLotStockVO vo);
}
