package co.yedam.app.common.bom.service;

import java.util.List;

import lombok.Data;

@Data
public class BomReqVO {
	BomCodeVO bomCodeVO;
	List<BomCodeVO> bomList;
	
	List<BomCodeVO> bomUpList;
	List<BomCodeVO> bomUpDeList;
}
