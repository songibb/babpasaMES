package co.yedam.app.common.bom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.common.bom.service.BomReqVO;

public interface BomCodeMapper {
	
	//전체 bom조회
	public List<BomCodeVO> selectBomCodeList();
	
	//검색조회
	public List<BomCodeVO> searchSelectBom(String prodName);
	
	//bom 상세 조회
	public List<BomCodeVO> selectDeBomCodeList(String bomNo);
	
	//bom 등록
	public int bomCodeInsert(BomCodeVO bomCodeVO);
	
	//bom 상세등록
	public int bomDeCodeInsert(BomCodeVO bomCodeVO);
	
	
	//bom 수정
	public int updateBom(BomCodeVO bomCodeVO);
	
	//bom 상세수정
	public int updateDeBom(BomCodeVO bomCodeVO);
	
	//bom 상세 삭제
	public int deleteDeBom(@Param("bomCode") BomCodeVO bomCode);
	
	
	
	//chart test
	public List<BomCodeVO> chartTest();

	
}
