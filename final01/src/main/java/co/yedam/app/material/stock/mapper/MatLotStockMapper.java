package co.yedam.app.material.stock.mapper;

import java.util.List;

import co.yedam.app.material.stock.service.MatLotStockVO;

public interface MatLotStockMapper {
	public List<MatLotStockVO> selectMatLotStockList(MatLotStockVO vo);
}
