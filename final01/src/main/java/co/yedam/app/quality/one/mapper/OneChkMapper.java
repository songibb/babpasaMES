package co.yedam.app.quality.one.mapper;

import java.util.List;

import co.yedam.app.quality.one.service.OneChkVO;

public interface OneChkMapper {
	
	//마지막 공정 조회
	public List<OneChkVO> selectLastPrcs();
	
	//마지막 공정 클릭 시 검사 진행 조회 테이블 (상세)
	public List<OneChkVO> selectOneChkList(String testNum);
	
	//품질 검사 등록(수정)
	public int OneChkUpdate(OneChkVO vo);
}
