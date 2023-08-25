package co.yedam.app.common.main.service;

import java.util.List;

public interface MainService {
	
	//제품별 재고량 확인(top 5)
	public List<MainVO> selectProdAmtList();
	
	//제품별 판매량 확인(top 5)
	public List<MainVO> selectSaleAmtList();
	
	//제품별 생산량 확인(top 5)
	public List<MainVO> selectPrcsAmtList();
	
	
	//총판매량
	public MainVO selectTotalSale();
	
	//총생산량
	public MainVO selectTotalPrcs();
	
	//총폐기량
	public MainVO selectTotalErr();

}
