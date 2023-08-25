package co.yedam.app.prcs.prod.service;


import co.yedam.app.common.grid.service.GridVO;
import lombok.Data;

@Data
public class PrcsProdReqVO {
	String prodCode;
	GridVO<PrcsProdVO> gridVO;
}
