package co.yedam.app.sales.in.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.in.service.MatInVO;
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

	@Override
	public List<InVO> searchInList(String prodCode, String startDate, String endDate, String before, String comple) {
		return inMapper.selectAllIn(prodCode, startDate, endDate, before, comple);
	}

	@Override
	public List<InVO> prodAllList() {
		return inMapper.selectProdAllList();
	}

	@Override
	public int modifyProdIn(GridVO<InVO> data) {
		int result = 0;
		if (data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for (InVO vo : data.getDeletedRows()) {
				result += inMapper.deleteProductIn(vo);
			}
		}
		if (data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for (InVO vo : data.getUpdatedRows()) {
				result += inMapper.updateProductIn(vo);
			}
		}
		if (data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for (InVO vo : data.getCreatedRows()) {
				result += inMapper.insertProductIn(vo);
			}
		}

		return result;

	}

	@Override
	public List<InVO> CProdList() {
		return inMapper.selectCProd();
	}

	@Override
	public List<InVO> inMngList() {
		return inMapper.inMngList();
	}
}
