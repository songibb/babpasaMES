package co.yedam.app.material.stock.mapper;

import java.util.List;


import co.yedam.app.material.stock.service.MatStockVO;

public interface MatStockMapper {
	public List<MatStockVO> selectMatStockList(String materialCode);
}
