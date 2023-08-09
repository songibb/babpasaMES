package co.yedam.app.material.stock.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.stock.mapper.MatLotStockMapper;
import co.yedam.app.material.stock.service.MatLotStockService;
import co.yedam.app.material.stock.service.MatLotStockVO;

@Service
public class MatLotStockServiceImpl implements MatLotStockService {
	
	@Autowired
	MatLotStockMapper mlsm;	
	
	@Override
	public List<MatLotStockVO> selectMatLotStockList(String materialCode) {
		
		return mlsm.selectMatLotStockList(materialCode);
	}

}
