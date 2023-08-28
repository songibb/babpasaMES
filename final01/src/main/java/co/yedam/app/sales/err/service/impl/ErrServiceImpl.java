package co.yedam.app.sales.err.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.dispose.service.MatDisVO;
import co.yedam.app.sales.err.mapper.ErrMapper;
import co.yedam.app.sales.err.service.ErrService;
import co.yedam.app.sales.err.service.ErrVO;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

@Service
public class ErrServiceImpl implements ErrService {

	@Autowired
	ErrMapper errMapper;
	
	@Override
	public List<ErrVO> getErrList() {
		return errMapper.selectErrList();
	}

	@Override
	public int modifyErrDis(GridVO<ErrVO> data) {
		int result = 0;
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(ErrVO vo : data.getDeletedRows()) {
				result += errMapper.deleteErrDis(vo);
			}
			
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(ErrVO vo : data.getUpdatedRows()) {
				result += errMapper.updateErrDis(vo);
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(ErrVO vo : data.getCreatedRows()) {
				result += errMapper.insertErrDis(vo);
			}
		}
		
		return result;
	}

	@Override
	public List<ErrVO> searchErrList(String prodCode, String startDate, String outDate) {
		return errMapper.selectAllOut(prodCode, startDate, outDate);
	}

	@Override
	public List<OrderVO> prodSearchList(String prodName) {
		return errMapper.selectProdSearchList(prodName);
	}

	@Override
	public List<ErrVO> ModalDisList() {
		return errMapper.ModalDisList();
	}

	@Override
	public List<OutVO> prodAllList() {
		return errMapper.selectProdAllList();
	}

	@Override
	public List<ErrVO> ErrSearchList(String prodName) {
		return errMapper.ErrSearchList(prodName);
	}

}
