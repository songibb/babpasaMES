package co.yedam.app.equip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.equip.service.EquipChkVO;

public interface EquipChkMapper {

	//점검 설비 전체 조회(그리드)
	public List<EquipChkVO> selectEquipChkAllList();

	//점검 설비 수정
	public int updateChkequip(EquipChkVO equipChkVO);
	
	//점검 담당자 모달 전체 리스트
	public List<EquipChkVO> selectEmpList();
	
	
	
	//등록 페이지 
	//왼쪽 그리드 : 오늘 점검 해야할 애들
	public List<EquipChkVO> LetChkEquipList();
	
	//오른쪽 그리드 : 오늘 점검해야할 애들 클릭시 상세조회 (eqCode 기반)
	public List<EquipChkVO> selectLetChkEquipInfo(String eqCode);
	
	//점검 설비 등록
	public int insertChkEquip(EquipChkVO vo);
	
	//검색
	public List<EquipChkVO> searchChkEquip(@Param("startDate")String startDate
										 , @Param("endDate")String endDate
										 , @Param("eqName") String eqName
										 , @Param("before") String before
										 , @Param("comple") String comple);
}