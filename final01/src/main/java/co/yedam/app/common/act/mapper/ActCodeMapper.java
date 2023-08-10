package co.yedam.app.common.act.mapper;

import java.util.List;

import co.yedam.app.common.act.service.ActCodeVO;

public interface ActCodeMapper {

	//거래처전체조회
	public List<ActCodeVO> selectActCodeList();
	
	//거래처검색조회
	public List<ActCodeVO> searchSelectActCode(String actName);
	
	
	//거래처 등록
	public int insertActInfo(ActCodeVO actCodeVO);
	
	//거래처 수정
	public int updateActInfo(ActCodeVO actCodeVO);
	
	//거래처 삭제
	public int deleteActInfo(ActCodeVO actCodeVO);
	
}
