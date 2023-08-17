package co.yedam.app.material.order.de.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.order.de.mapper.MatOrderDeMapper;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;

@Service
public class MatOrderDeServiceImpl implements MatOrderDeService {
	//전체조회
	@Autowired
	MatOrderDeMapper modm;
	//전체조회
	@Override
	public List<MatOrderDeVO> selectMatOrderList() {
		return modm.selectMatOrderList();
	}
	
	//전체조회에서 검색
	@Override
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate,
			String endDate) {
		
		return modm.selectMatOrderSearch(materialCode, accountCode, startDate, endDate);
	}
	
	//등록, 수정, 삭제
	@Override
	public int modifyMatOrder(GridVO<MatOrderDeVO> data) {
		int result = 0;
		// TODO Auto-generated method stub
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			modm.deleteMatOrderList(data.getDeletedRows());
			result += data.getDeletedRows().size();
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			modm.updateMatOrderList(data.getUpdatedRows());
			result += data.getUpdatedRows().size();
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			modm.insertMatOrderList(data.getCreatedRows());
			result += data.getCreatedRows().size();
		}
		
		return result;
	}

}
