package co.yedam.app.sales.out.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
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
	public List<OutVO> searchOutList(String prodCode, String actCode, String startDate, String outDate, String before, String comple) {
		return outMapper.selectAllOut(actCode, prodCode, startDate, outDate, before, comple);
	}

	@Override
	public List<OutVO> getOutNList() {
		return outMapper.selectOutNList();
	}
	//등록, 수정, 삭제
	@Override
	public int modifyOut(GridVO<OutVO> data) {
		int result = 0;
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(OutVO vo : data.getDeletedRows()) {
			result += outMapper.deleteOut(vo);
			}
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(OutVO vo : data.getUpdatedRows()) {
				result += outMapper.updateOut(vo);
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(OutVO vo : data.getCreatedRows()) {
				result += outMapper.insertOut(vo);
			}
		}
		return result;
	}

	@Override
	public List<OutVO> LotList() {
		return outMapper.selectLotList();
	}

	@Override
	public List<OutVO> OrderDeList() {
		return outMapper.selectOrderDeList();
	}
}
