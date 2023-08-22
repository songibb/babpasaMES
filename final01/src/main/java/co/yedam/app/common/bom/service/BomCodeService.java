package co.yedam.app.common.bom.service;

import java.util.List;


public interface BomCodeService {

	//전체조회
	public List<BomCodeVO> getBomCodeAll();
	
	//검색조회
	public List<BomCodeVO> searchSelectBom(String prodName);
	
	//BOM상세조회
	public List<BomCodeVO> getBomDeCodeList(String bomNo);
	
	//bom 등록
	public int bomCodeInsert(BomReqVO bomReqVO);
	
	
	//bom 최종 헤더만 수정하기
	public int updateBomHeader(List<BomCodeVO> list);
	
	//bom 수정
	public int updateBom(BomReqVO bomReqVO);
	
	//bom 상세수정
	//public int updateDeBom(List<BomCodeVO> list);
	
	//bom 상세 삭제
	public int deleteDeBom(List<BomCodeVO> list);
	
	
	
	
	//chart test
	public List<BomCodeVO> chartTest();
}
