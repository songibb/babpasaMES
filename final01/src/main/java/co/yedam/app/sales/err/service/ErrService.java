package co.yedam.app.sales.err.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.dispose.service.MatDisVO;

public interface ErrService {
	//전체조회
	public List<ErrVO> getErrList();
	
	//등록, 수정, 삭제
	public int modifyErrDis(GridVO<ErrVO> data);
}
