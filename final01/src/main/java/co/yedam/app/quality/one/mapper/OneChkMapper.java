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
	
	//완제품 품질 검사 등록(수정) - 프로시저
	public int OneChkUpdatePr (OneChkVO vo);
	
	//조회페이지
	//모든 마지막 공정 조회 (품질검사 처리 완료된 것들도 포함)
	public List<OneChkVO> selectAllLastPrcs();
}
