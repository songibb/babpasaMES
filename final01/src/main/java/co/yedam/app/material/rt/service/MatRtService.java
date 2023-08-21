package co.yedam.app.material.rt.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;




public interface MatRtService {
	//전체조회
	public List<MatRtVO> selectMatRtList();
	public List<MatRtVO> selectMatRtSearch(String materialCode, String accountCode, String startDate, String endDate);
	
	
	//검수완료 목록
	public List<MatTestVO> selectMatTestFinishList();
	
	//삭제 행 정보
	public List<MatTestVO> getDeletedRowsInfo(List<MatRtVO> list);
	
		
	//등록, 수정, 삭제
	public int modifyMatRt(GridVO<MatRtVO> data);
	
}
