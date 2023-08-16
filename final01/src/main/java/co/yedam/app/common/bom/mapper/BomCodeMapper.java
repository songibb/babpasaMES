package co.yedam.app.common.bom.mapper;

import java.util.List;

import co.yedam.app.common.bom.service.BomCodeVO;

public interface BomCodeMapper {
	
	//전체 bom조회
	public List<BomCodeVO> selectBomCodeList();
	
	//검색조회
	public List<BomCodeVO> searchSelectBom(String prodName);
	
	//bom 상세 조회
	public List<BomCodeVO> selectDeBomCodeList(String bomNo);

}
