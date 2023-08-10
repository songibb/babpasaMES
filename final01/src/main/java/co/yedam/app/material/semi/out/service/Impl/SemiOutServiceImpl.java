package co.yedam.app.material.semi.out.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.semi.out.mapper.SemiOutMapper;
import co.yedam.app.material.semi.out.service.SemiOutService;
import co.yedam.app.material.semi.out.service.SemiOutVO;

@Service
public class SemiOutServiceImpl implements SemiOutService {
	//전체조회
	@Autowired
	SemiOutMapper som;
	//전체조회
	@Override
	public List<SemiOutVO> selectSemiOutList() {
		return som.selectSemiOutList();
	}
	
	//전체조회 중 검색

	@Override
	public List<SemiOutVO> selectSemiOutSearch(String productCode, String startDate, String endDate) {
		
		return som.selectSemiOutSearch(productCode, startDate, endDate);
	}

}
