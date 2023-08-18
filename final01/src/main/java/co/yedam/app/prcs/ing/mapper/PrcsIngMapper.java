package co.yedam.app.prcs.ing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.prcs.ing.service.PrcsIngVO;

public interface PrcsIngMapper {
	//진행공정 조회
	public List<PrcsIngVO> selectPrcsIngList(@Param("prcsDirDeCode") String prcsDirDeCode, 
											 @Param("prodCode") String prodCode);

	//진행공정 등록 (프로시저)
	public int insertPrcsIng(String prcsDirDeCode);

	//사용 가능한 설비 조회 (진행공정 모달)
	public List<EquipVO> selectWaitEquipList(PrcsIngVO prcsIngVO);
	
	//투입 자재별 소모량 조회 (진행공정 모달)
	public List<BomCodeVO> selectMatBomList(PrcsIngVO prcsIngVO);
	
	

}
