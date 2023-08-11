package co.yedam.app.common.act.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public Map<String, String> insertActInfo(ActCodeVO actCodeVO) {
		
		Map<String, String> map = new HashMap<>();
		
		int result = actCodeMapper.insertActInfo(actCodeVO);
		
		if(result == 1) {
			map.put("결과", "Success");
		} else {
			map.put("결과", "Fail");
		}
		return map;
	}
	
	@Override
	public int updateActInfo(ActCodeVO actCodeVO) {
		
		return 0;
	}

	@Override
	public int deleteActInfo(ActCodeVO actCodeVO) {
		
		return 0;
	}



}
