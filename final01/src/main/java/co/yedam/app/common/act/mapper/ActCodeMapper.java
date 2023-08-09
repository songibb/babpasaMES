package co.yedam.app.common.act.mapper;

import java.util.List;

import co.yedam.app.common.act.service.ActCodeVO;

public interface ActCodeMapper {

	//전체조회
	public List<ActCodeVO> selectActCodeList();
	
	//검색조회
	public List<ActCodeVO> searchSelectActCode(String commdeName);
}
