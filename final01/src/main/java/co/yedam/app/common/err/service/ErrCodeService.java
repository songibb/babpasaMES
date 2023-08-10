package co.yedam.app.common.err.service;

import java.util.List;

public interface ErrCodeService {
	
	//불량코드전체조회
	public List<ErrCodeVO> selectErrCodeList();
	
	//불량명검색조회
	public List<ErrCodeVO> searchSelectErrCode(String errName);
}
