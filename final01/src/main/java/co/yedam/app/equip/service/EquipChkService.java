package co.yedam.app.equip.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface EquipChkService {
	//점검 설비 전체 조회
	public List<EquipChkVO> getEquipChkList();

	//점검 설비 수정 (사용x)
	public int updateChkEquip(EquipChkVO equipChkVO);
	
	// 모달 : 사원 조회
	public List<EquipChkVO> selectEmpList();

	
	//등록 페이지
	// 곧 점검해야할 설비 목록 조회 - 왼쪽 그리드
	public List<EquipChkVO> LetChkEquipList();
	
	//클릭시 상세 설비 점검 등록 - 오른쪽 그리도
	public List<EquipChkVO> selectLetChkEquipInfo(String eqCode);
	
	//점검 설비 등록
	public int modifyEquipChk(GridVO<EquipChkVO> data);
	
	//검색
	public List<EquipChkVO> searchChkEquip(String startDate, String outDate);
}