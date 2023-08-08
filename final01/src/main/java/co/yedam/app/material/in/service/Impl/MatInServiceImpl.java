package co.yedam.app.material.in.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.in.mapper.MatInMapper;
import co.yedam.app.material.in.service.MatInService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;

@Service
public class MatInServiceImpl implements MatInService {
	
	@Autowired
	MatInMapper mim;
	
	@Override
	public List<MatOrderDeVO> selectMatInList(String materialCode, String accountCode, String startDate,
			String endDate) {
		
		return mim.selectMatInList(materialCode, accountCode, startDate, endDate);
	}

}
