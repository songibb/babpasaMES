package co.yedam.app.sales.out.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.sales.order.service.OrderVO;
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

	@Override
	public List<OutVO> actAllList() {
		return outMapper.selectActAllList();
	}

	@Override
	public List<OutVO> prodAllList() {
		return outMapper.selectProdAllList();
	}

	@Override
	public List<OutVO> searchOutList(String prodCode, String actCode, String startDate,
			String outDate) {
		return outMapper.selectAllOut(actCode, prodCode, startDate, outDate);
	}

	//등록
	@Override
	public int insertOutList(List<OutVO> outList) {
		return outMapper.insertOutList(outList);
	}

}
