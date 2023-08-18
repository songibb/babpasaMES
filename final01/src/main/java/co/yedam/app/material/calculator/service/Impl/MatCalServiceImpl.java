package co.yedam.app.material.calculator.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.calculator.mapper.MatCalMapper;
import co.yedam.app.material.calculator.service.MatCalService;
import co.yedam.app.material.calculator.service.MatCalVO;

@Service
public class MatCalServiceImpl implements MatCalService {

	@Autowired
	MatCalMapper mcm;
	
	@Override
	public List<MatCalVO> getMatCalList() {
		
		return mcm.selectMatCalList();
	}

	@Override
	public List<MatCalVO> getMatCalSearch(String materialCode, String calIn, String calOut, String startDate,
			String endDate) {
		return mcm.selectMatCalSearch(materialCode, calIn, calOut, startDate, endDate);
	}

}
