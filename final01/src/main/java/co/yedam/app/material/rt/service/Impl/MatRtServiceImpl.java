package co.yedam.app.material.rt.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.rt.mapper.MatRtMapper;
import co.yedam.app.material.rt.service.MatRtService;
import co.yedam.app.material.rt.service.MatRtVO;

@Service
public class MatRtServiceImpl implements MatRtService {
	
	@Autowired
	MatRtMapper mrm;
	
	@Override
	public List<MatRtVO> selectMatRtList(String materialCode, String accountCode, String startDate, String endDate) {
		
		return mrm.selectMatRtList(materialCode, accountCode, startDate, endDate);
	}

}
