package co.yedam.app.common.bom.service;

import java.util.List;

public interface BomCodeService {

	//전체조회
	public List<BomCodeVO> getBomCodeAll();
	
	//검색조회
	public List<BomCodeVO> searchSelectBom(String prodName);
	
	//BOM상세조회
	public List<BomCodeVO> getBomDeCodeList(String bomNo);
}
