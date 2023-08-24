package co.yedam.app.common.main.mapper;

import java.util.List;

import co.yedam.app.common.main.service.MainVO;

public interface MainMapper {

	//제품별 재고량 확인(top 5)
	public List<MainVO> selectProdAmtList();
	
	//제품별 판매량 확인(top 5)
	public List<MainVO> selectSaleAmtList();
	
}
