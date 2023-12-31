package co.yedam.app.prcs.prod.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.plan.service.PrcsSearchVO;
import co.yedam.app.prcs.prod.service.PrcsProdVO;

public interface PrcsProdMapper {
	
	//제품별공정 조회
	public List<PrcsProdVO> selectPrcsProdList(@Param("prodCode") String prodCode);
	
	//제품 목록 조회
	public List<PrcsProdVO> selectProdList(PrcsSearchVO prcsSearchVO);
	
	//제품별공정 등록
	public int insertPrcsProd(PrcsProdVO prcsProdVO);
	
	//제품별공정 수정
	public int updatePrcsProd(PrcsProdVO prcsProdVO);
	
	//제품별공정 삭제
	public int deletePrcsProd(PrcsProdVO prcsProdVO);
}
