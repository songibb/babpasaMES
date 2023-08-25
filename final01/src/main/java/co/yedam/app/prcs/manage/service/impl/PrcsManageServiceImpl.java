package co.yedam.app.prcs.manage.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.prcs.manage.mapper.PrcsManageMapper;
import co.yedam.app.prcs.manage.service.PrcsManageService;
import co.yedam.app.prcs.manage.service.PrcsManageVO;

@Service
public class PrcsManageServiceImpl implements PrcsManageService {

	@Autowired
	PrcsManageMapper prcsManageMapper;
	
	//공정관리 조회
	@Override
	public List<PrcsManageVO> selectPrcsManageList() {
		return prcsManageMapper.selectPrcsManageList();
	}

	//공정관리 등록, 수정, 삭제
	@Override
	public int updatePrcsManage(GridVO<PrcsManageVO> data) {
		int result = 0;

		if(data.getCreatedRows() != null && data.getCreatedRows().size()>0) {
			for(PrcsManageVO vo : data.getCreatedRows()) {
				result += prcsManageMapper.insertPrcsManage(vo);
			}
		}	
			
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() >0) {
			for(PrcsManageVO vo : data.getUpdatedRows()) {			
				result += prcsManageMapper.updatePrcsManage(vo);
			}
		}	
		
		if(data.getDeletedRows()!= null && data.getDeletedRows().size()>0) {
			for(PrcsManageVO vo : data.getDeletedRows()){		
				result += prcsManageMapper.deletePrcsManage(vo);
			}
		}

		return result;
	}

	

	

}
