package co.yedam.app.quality.semi.mapper;

import java.util.List;

import co.yedam.app.quality.semi.service.SemiChkVO;

public interface SemiChkMapper {

	//공정 진행중 조회
	public List<SemiChkVO> selectPrcsIng();
	
	//공정 진행중 클릭 시 검사 진행 조회 테이블(상세)
	public List<SemiChkVO> selectSemiChkList(String testNum);
	
	//품질 검사 등록(수정)
	public int SemiChkUpdate(SemiChkVO vo);
	

}
