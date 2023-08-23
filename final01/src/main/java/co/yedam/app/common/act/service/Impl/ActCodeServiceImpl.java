package co.yedam.app.common.act.service.Impl;

import java.util.ArrayList;
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
	public Map<String, String> updateActInfo(ActCodeVO actCodeVO) {
		
		Map<String, String> map = new HashMap<>();
		
		int result = actCodeMapper.updateActInfo(actCodeVO);
		
		if(result == 1) {
			map.put("결과", "Success");
		} else {
			map.put("결과", "Fail");
		}
		return map;
	}

	/*
	 * @Override public Map<String, String> deleteActInfo(List<ActCodeVO>
	 * checkedAct) { Map<String, String> map = new HashMap<>(); int result =
	 * actCodeMapper.deleteActInfo(checkedAct); if(result >= 1) { map.put("결과",
	 * "Success"); } else { map.put("결과", "Fail"); } return map; }
	 */

	@Override
	public List<String> deleteActInfo(List<ActCodeVO> checkedAct) {
		
		List<String> list = new ArrayList<>();
		
		for(ActCodeVO vo : checkedAct) {
			actCodeMapper.deleteActInfo(vo);
			
			String error = vo.getResult();
			if(error != null) {
				list.add(error);
			}
		}
		return list;
	}



}
