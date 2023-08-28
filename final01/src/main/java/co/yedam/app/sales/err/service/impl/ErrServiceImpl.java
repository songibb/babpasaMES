package co.yedam.app.sales.err.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.dispose.service.MatDisVO;
import co.yedam.app.sales.err.mapper.ErrMapper;
import co.yedam.app.sales.err.service.ErrService;
import co.yedam.app.sales.err.service.ErrVO;

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

}
