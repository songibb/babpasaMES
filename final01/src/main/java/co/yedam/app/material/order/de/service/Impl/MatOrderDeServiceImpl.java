package co.yedam.app.material.order.de.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.order.de.mapper.MatOrderDeMapper;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;

@Service
public class MatOrderDeServiceImpl implements MatOrderDeService {
	//전체조회
	@Autowired
	MatOrderDeMapper modm;
	//전체조회
	@Override
	public List<MatOrderDeVO> selectMatOrderList() {
		return modm.selectMatOrderList();
	}
	
	//전체조회에서 검색
	@Override
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate,
			String endDate) {
		
		return modm.selectMatOrderSearch(materialCode, accountCode, startDate, endDate);
	}
	
	//등록
	@Override
	public int insertMatOrderList(List<MatOrderDeVO> orderList) {
		return modm.insertMatOrderList(orderList);
	}

	@Override
	public int updateMatOrderList(List<MatOrderDeVO> orderList) {
		
		return modm.updateMatOrderList(orderList);
	}

	@Override
	public int deleteMatOrderList(List<MatOrderDeVO> orderList) {
		
		return modm.deleteMatOrderList(orderList);
	}

}
