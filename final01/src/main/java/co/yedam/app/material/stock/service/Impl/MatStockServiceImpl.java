package co.yedam.app.material.stock.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.stock.mapper.MatStockMapper;
import co.yedam.app.material.stock.service.MatStockService;
import co.yedam.app.material.stock.service.MatStockVO;

@Service
public class MatStockServiceImpl implements MatStockService {

	@Autowired
	MatStockMapper msm;
	
	@Override
	public List<MatStockVO> selectMatStockList(String materialCode) {
		
		return msm.selectMatStockList(materialCode);
	}

}
