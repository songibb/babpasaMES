package co.yedam.app.material.calculator.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;




public interface MatCalService {
	
	//전체조회
	public List<MatCalVO> getMatCalList();
	
	//검색
	public List<MatCalVO> getMatCalSearch(String materialCode, String calIn, String calOut, String startDate, String endDate);
	
	//insert
	public int modifyMatCal(GridVO<MatCalVO> data);
}
