package co.yedam.app.common.mat.service;

import java.util.List;
import java.util.Map;



import co.yedam.app.common.grid.service.GridVO;

public interface MatCodeService {

	//전체 자재코드 조회
	public List<MatCodeVO> selectMatCodeList();
	
	
	//자재명 검색 조회
	public List<MatCodeVO> searchMatCode(MatCodeVO matCodeVO);
	
	
	//자재코드 추가 수정 삭제
	public Map<String, Object> updateMatCode(GridVO<MatCodeVO> data);
	
}
