package co.yedam.app.quality.semi.service;

import java.util.List;

import co.yedam.app.common.bom.service.BomCodeVO;
import lombok.Data;

@Data
public class SemiChkReqVO {
	
	SemiChkVO semiChkVO;
	List<SemiChkVO> semiList;
	
}
