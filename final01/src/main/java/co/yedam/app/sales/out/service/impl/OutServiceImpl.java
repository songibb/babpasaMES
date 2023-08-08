package co.yedam.app.sales.out.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.sales.out.mapper.OutMapper;
import co.yedam.app.sales.out.service.OutService;
import co.yedam.app.sales.out.service.OutVO;

@Service
public class OutServiceImpl implements OutService {

	@Autowired
	OutMapper outMapper;
	
	@Override
	public List<OutVO> getOutList() {
		return outMapper.selectOutAllList();
	}

}
