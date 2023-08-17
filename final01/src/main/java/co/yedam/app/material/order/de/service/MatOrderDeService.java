package co.yedam.app.material.order.de.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;



public interface MatOrderDeService {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate, String endDate);
	
	
	//등록, 수정, 삭제
	public int modifyMatOrder(GridVO<MatOrderDeVO> data);
		
}
