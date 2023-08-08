package co.yedam.app.material.semi.out.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.semi.out.mapper.SemiOutMapper;
import co.yedam.app.material.semi.out.service.SemiOutService;
import co.yedam.app.material.semi.out.service.SemiOutVO;

@Service
public class SemiOutServiceImpl implements SemiOutService {
	
	@Autowired
	SemiOutMapper som;
	
	@Override
	public List<SemiOutVO> selectSemiOutList(String productCode, String startDate, String endDate) {
		
		return som.selectSemiOutList(productCode, startDate, endDate);
	}

}
