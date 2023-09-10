package co.yedam.app.material.out.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.out.mapper.MatOutMapper;
import co.yedam.app.material.out.service.MatOutService;
import co.yedam.app.material.out.service.MatOutVO;

@Service
public class MatOutServiceImpl implements MatOutService {
	//전체조회
	@Autowired
	MatOutMapper mom;
	//전체조회 검색
	@Override
	public List<MatOutVO> selectMatOutList(String materialCode, String accountCode, String startDate, String endDate) {
		
		return mom.selectMatOutList(materialCode, accountCode, startDate, endDate);
	}
	
	//전체조회
	@Override
	public List<MatOutVO> selectMatOutListAll() {
		
		return mom.selectMatOutListAll();
	}

}
