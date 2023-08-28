package co.yedam.app.sales.err.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.dispose.service.MatDisVO;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

public interface ErrService {
	//전체조회
	public List<ErrVO> getErrList();
	
	//등록, 수정, 삭제
	public int modifyErrDis(GridVO<ErrVO> data);
	
	//검색
	public List<ErrVO> searchErrList(String prodCode, String startDate, String outDate);
	
	//모달 검색 - 제품
	public List<OrderVO> prodSearchList(String prodName);
	
	//그리드 모달 - 폐기목록
	public List<ErrVO> ModalDisList();
	
	//그리드 모달 - 제품목록
	public List<OutVO> prodAllList();
	
	//모달 검색 - 검수
	public List<ErrVO> ErrSearchList(String prodName);
}
