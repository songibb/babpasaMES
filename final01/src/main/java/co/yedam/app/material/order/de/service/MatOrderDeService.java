package co.yedam.app.material.order.de.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.stock.service.MatStockVO;
import co.yedam.app.sales.order.service.OrderVO;



public interface MatOrderDeService {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate, String endDate, String before, String comple);
	
	
	//등록, 수정, 삭제
	public int modifyMatOrder(GridVO<MatOrderDeVO> data);
	
	//신규생산계획 조회
	public List<MatStockVO> getNewPrcsPlan(String materialName);

	
	//자재 거래처 모달
	public List<OrderVO> getActMatModal();
	
	//자재 거래처 모달 검색
	public List<OrderVO> getActMatModalSearch(String actName);
	
	//헤더 그리드
	public List<MatOrderDeVO> getMatListPageOrderList();
	public List<MatOrderDeVO> getMatListPageOrderListSearch(String accountCode, String startDate, String endDate);
	
	//상세 그리드
	public List<MatOrderDeVO> getMatListPageOrderDeList(String matOdCd);
	
	//해당 자재 거래처 찾기
	public List<MatOrderDeVO> getMatBuyAct(String matCode);
	
	//해당 자재 해당 거래처 가격 찾기
	public MatOrderDeVO getActMatPrice(MatOrderDeVO vo);
}
