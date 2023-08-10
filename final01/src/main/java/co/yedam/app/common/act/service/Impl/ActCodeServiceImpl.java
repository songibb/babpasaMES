package co.yedam.app.common.act.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.act.mapper.ActCodeMapper;
import co.yedam.app.common.act.service.ActCodeService;
import co.yedam.app.common.act.service.ActCodeVO;

@Service
public class ActCodeServiceImpl implements ActCodeService{

	@Autowired
	ActCodeMapper actCodeMapper;
	
	@Override
	public List<ActCodeVO> selectActCodeList() {
		
		return actCodeMapper.selectActCodeList();
	}

	@Override
	public List<ActCodeVO> searchSelectActCode(String actName) {
		
		return actCodeMapper.searchSelectActCode(actName);
	}

}
