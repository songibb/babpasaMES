package co.yedam.app.material.in.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.in.mapper.MatInMapper;
import co.yedam.app.material.in.service.MatInService;
import co.yedam.app.material.in.service.MatInVO;

@Service
public class MatInServiceImpl implements MatInService {
	//조회
	@Autowired
	MatInMapper mim;
	
	//조회
	@Override
	public List<MatInVO> selectMatInList(String materialCode, String accountCode, String startDate,
			String endDate) {
		
		return mim.selectMatInList(materialCode, accountCode, startDate, endDate);
	}

}
