package co.yedam.app.material.calculator.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.calculator.mapper.MatCalMapper;
import co.yedam.app.material.calculator.service.MatCalService;
import co.yedam.app.material.calculator.service.MatCalVO;
import co.yedam.app.material.in.service.MatInVO;

@Service
public class MatCalServiceImpl implements MatCalService {

	@Autowired
	MatCalMapper mcm;
	
	@Override
	public List<MatCalVO> getMatCalList() {
		
		return mcm.selectMatCalList();
	}

	@Override
	public List<MatCalVO> getMatCalSearch(String materialCode, String calIn, String calOut, String startDate,
			String endDate) {
		return mcm.selectMatCalSearch(materialCode, calIn, calOut, startDate, endDate);
	}

	@Override
	public int modifyMatCal(GridVO<MatCalVO> data) {
		int result = 0;
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(MatCalVO vo : data.getCreatedRows()) {
				result += mcm.insertMatCal(vo);
				MatInVO matLotInfo = mcm.findMatLotInfoAtMatCal(vo);
				vo.setActCode(matLotInfo.getActCode());
				vo.setMatExd(matLotInfo.getMatExd());
				
				if(String.valueOf(vo.getCalCategory()).equals("I")) {
					mcm.insertMatInAtMatCal(vo);
				} else if(String.valueOf(vo.getCalCategory()).equals("O")) {
					mcm.insertMatOutAtMatCal(vo);
					mcm.updateMatInAtMatCal(vo);
				}
			}
		}
		
		return result;
	}

}
