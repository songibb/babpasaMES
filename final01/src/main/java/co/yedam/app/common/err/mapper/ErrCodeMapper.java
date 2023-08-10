package co.yedam.app.common.err.mapper;

import java.util.List;

import co.yedam.app.common.err.service.ErrCodeVO;

public interface ErrCodeMapper {
	
	//불량코드전체조회
	public List<ErrCodeVO> selectErrCodeList();
	
	//불량명검색조회
	public List<ErrCodeVO> searchSelectErrCode(String errName);
	

}
