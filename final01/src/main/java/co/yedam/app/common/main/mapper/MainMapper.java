package co.yedam.app.common.main.mapper;

import java.util.List;

import co.yedam.app.common.main.service.MainVO;

public interface MainMapper {

	//제품별 재고량 확인(top 5)
	public List<MainVO> selectProdAmtList();
	
	//제품별 전일 판매량 확인(top 5)
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
