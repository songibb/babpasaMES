package co.yedam.app.material.out.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.out.mapper.MatOutMapper;
import co.yedam.app.material.out.service.MatOutService;
import co.yedam.app.material.out.service.MatOutVO;

@Service
public class MatOutServiceImpl implements MatOutService {

	@Autowired
	MatOutMapper mom;
	
	@Override
	public List<MatOutVO> selectMatOutList(String materialCode, String accountCode, String startDate, String endDate) {
		
		return mom.selectMatOutList(materialCode, accountCode, startDate, endDate);
	}

}
