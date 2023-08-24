package co.yedam.app.quality.one.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface OneChkService {
	
	//마지막 공정 조회
	public List<OneChkVO> selectLastPrcs();
	
	//클릭 시 품질 검사 실시 그리드(상세)
	public List<OneChkVO> selectOneChkList(String testNum);
	
	//상세 품질 검사 수정
	public int OneChkUpdate(OneChkReqVO oneChkReqVO);
	
	//조회페이지
	//모든 마지막 공정 조회
	public List<OneChkVO> selectAllLastPrcs();
}
