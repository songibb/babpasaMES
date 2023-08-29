package co.yedam.app.quality.semi.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface SemiChkService {
	
	//공정 진행 조회
	public List<SemiChkVO> selectPrcsIng();
	
	//클릭시 품질 검사 실시 그리드
	public List<SemiChkVO> selectSemiChkList(String testNum);
	
	//상세 품질 검사 수정
	public int SemiChkUpdate(SemiChkReqVO semiChkReqVO);
	
	
	//조회 페이지
	//모든 공정 진행 조회
	public List<SemiChkVO> selectAllPrcsIng();
	
	//검사번호 검색
	public List<SemiChkVO> searchSemiChk(String testNum);
}
