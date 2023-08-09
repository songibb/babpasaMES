package co.yedam.app.material.stock.service;

import java.util.List;

public interface MatStockService {
	public List<MatStockVO> selectMatStockList(String materialCode);
}
