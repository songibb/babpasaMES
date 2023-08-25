package co.yedam.app.quality.semi.mapper;

import java.util.List;

import co.yedam.app.quality.semi.service.SemiChkVO;

public interface SemiChkMapper {

	//공정 진행중 조회 (처리 전) - 왼쪽 그리도
	public List<SemiChkVO> selectPrcsIng();
	
	//공정 진행중 클릭 시 검사 진행 조회 테이블(상세) - 오른쪽 그리드 
	public List<SemiChkVO> selectSemiChkList(String testNum);
	
	//품질 검사 등록(수정)
	public int SemiChkUpdate(SemiChkVO vo);
	
	//품질 검사 등록(수정) 프로시저 
	public int SemiChkUpdatePr(SemiChkVO vo);
	
	
	//조회페이지
	//공정 진행중 조회 (모든 공정 진행중, 처리완료된 것들도 포함)
	public List<SemiChkVO> selectAllPrcsIng();
	
	//모든 공정 진행중 클릭 시 검사 진행 조회 테이블(상세)
	public List<SemiChkVO> selectAllSemiChkList(String testNum);
 
}
