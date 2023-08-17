package co.yedam.app.equip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.equip.service.OffEquipVO;

public interface OffEquipMapper {
	
	//설비 전체 조회
	public List<OffEquipVO> selectAllequip();
	
	//비가동 설비 전체조회
	public List<OffEquipVO> selectOffEquipAllList();
	
	//비가동 설비 등록
	public int insertOffEquip(OffEquipVO offequipVO);
	
	//비가동 설비 수정
	public int updateOffEquip(OffEquipVO offequipVO);
	
	//모달 조회된 전체설비 단건으로 가져오기(조회)
	public OffEquipVO selectOffEquipInfo(OffEquipVO offequipVO);
	
	//비가동 설비명 검색
	public List<EquipVO> offsearchEquip(String eqName);
}