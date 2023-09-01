package co.yedam.app.equip.mapper;

import java.util.List;

import co.yedam.app.equip.service.EquipVO;

public interface EquipMapper {
	//설비 전체조회
	public List<EquipVO> selectEquipAllList();
	
	//설비등록
	public int insertEquipInfo(EquipVO equipVO);
	
	//모달에서의 설비 전체 조회
	public List<EquipVO> EquipModalList();
	
	//설비 수정
	public int updateEquip(EquipVO equipVO);
	
	//삭제
	public int deleteEquip(String eqCode);
	
	//설비 관리 페이지에서 단건 조회(모달에서 받아옴)
	public EquipVO selectEquipInfo(EquipVO equipVO);

	//설비 검색
	public List<EquipVO> searchEquip(EquipVO equipVO);

}
