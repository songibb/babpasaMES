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
	public List<MatInVO> selectMatInList() {
		
		return mim.selectMatInList();
	}
	
	//조회페이지에서 검색
	@Override
	public List<MatInVO> selectMatInSearch(String materialCode, String accountCode, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mim.selectMatInSearch(materialCode, accountCode, startDate, endDate);
	}

}
