package co.yedam.app.material.dispose.service.Impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.dispose.mapper.MatDisMapper;
import co.yedam.app.material.dispose.service.MatDisService;
import co.yedam.app.material.dispose.service.MatDisVO;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.search.service.SearchVO;

@Service
public class MatDisServiceImpl implements MatDisService {
	
	@Autowired
	MatDisMapper mdm;
	
	@Override
	public List<MatDisVO> getMatDisList() {
		
		return mdm.selectMatDisList();
	}

	@Override
	public List<MatDisVO> getMatDisSearch(SearchVO vo) {
		
		return mdm.selectMatDisSearch(vo);
	}

	@Override
	public List<MatInVO> getOverDateList() {
		
		return mdm.selectOverDateList();
	}
	
	@Override
	public List<MatRtVO> getRtFailList() {
		
		return mdm.selectRtFailList();
	}

	@Override
	public int modifyMatDis(GridVO<MatDisVO> data) {
		int result = 0;
		// TODO Auto-generated method stub
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(MatDisVO vo : data.getDeletedRows()) {
				result += mdm.deleteMatDis(vo);
				mdm.updateMatStockAtMatDisDe(vo);
			}
			
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(MatDisVO vo : data.getUpdatedRows()) {
				result += mdm.updateMatDis(vo);
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(MatDisVO vo : data.getCreatedRows()) {
				result += mdm.insertMatDis(vo);
				mdm.updateMatStockAtMatDisIn(vo);
			}
		}
		
		return result;
	}

	@Override
	public List<MatRtVO> getDeletedRtInfo(List<MatDisVO> list) {
		List<MatRtVO> rtList = new ArrayList<>();
		if(list != null && list.size() > 0) {
			for(MatDisVO vo : list) {
				MatRtVO rtVO = mdm.deletedRtInfo(vo);
				rtList.add(rtVO);
			}
		}

		return rtList;
	}

	@Override
	public List<MatInVO> getDeletedExdInfo(List<MatDisVO> list) {
		List<MatInVO> inList = new ArrayList<>();
		if(list != null && list.size() > 0) {
			for(MatDisVO vo : list) {
				MatInVO inVO = mdm.deletedExdInfo(vo);
				inList.add(inVO);
			}
		}

		return inList;
	}


}
