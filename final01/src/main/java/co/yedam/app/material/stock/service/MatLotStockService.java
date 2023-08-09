package co.yedam.app.material.stock.service;

import java.util.List;

public interface MatLotStockService {
	public List<MatLotStockVO> selectMatLotStockList(String materialCode);
}
