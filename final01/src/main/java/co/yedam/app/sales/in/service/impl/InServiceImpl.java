package co.yedam.app.sales.in.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.sales.in.mapper.InMapper;
import co.yedam.app.sales.in.service.InService;
import co.yedam.app.sales.in.service.InVO;

@Service
public class InServiceImpl implements InService {

	@Autowired
	InMapper inMapper;
	
	@Override
	public List<InVO> getInList() {
		return inMapper.selectInAllList();
	}

}
