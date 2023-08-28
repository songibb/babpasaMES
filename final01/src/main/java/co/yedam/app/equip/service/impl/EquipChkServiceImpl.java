package co.yedam.app.equip.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.equip.mapper.EquipChkMapper;
import co.yedam.app.equip.service.EquipChkService;
import co.yedam.app.equip.service.EquipChkVO;

@Service
public class EquipChkServiceImpl implements EquipChkService {

	
	//점검 설비 전체 조회
	@Autowired
	EquipChkMapper equipChkMapper;
	
	@Override
	public List<EquipChkVO> getEquipChkList() {
		// TODO Auto-generated method stub
		return equipChkMapper.selectEquipChkAllList();
	}
	
	//점검 설비 수정 - 사용 x
	@Override
	public int updateChkEquip(EquipChkVO equipChkVO) {
		int result = equipChkMapper.updateChkequip(equipChkVO);
		if(result > 0) {
			return 1;
		}else {
			return -1;
		}
		
	}
	
	//점검 페이지
	//곧 점검 설비 조회 - 왼쪽 그리드 
	@Override
	public List<EquipChkVO> LetChkEquipList(){
		return equipChkMapper.LetChkEquipList();
	}
	
	//eqCode 기반으로 상세점검등록/내역 - 오른쪽 그리도
	@Override
	public List<EquipChkVO> selectLetChkEquipInfo(String eqCode){
		return equipChkMapper.selectLetChkEquipInfo(eqCode);
	}
	
	//점검 설비 등록
	@Override
	public int modifyEquipChk(GridVO<EquipChkVO> data) {
		int result = 0;
		
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(EquipChkVO vo : data.getCreatedRows()) {
				result += equipChkMapper.insertChkEquip(vo);				
			}
		}
		return result;
		
	}

	//모달 : 사원 조회
	@Override
	public List<EquipChkVO> selectEmpList(){
		return equipChkMapper.selectEmpList();
				
	}

	//검색
	@Override
	public List<EquipChkVO> searchChkEquip(String startDate, String outDate) {
		return equipChkMapper.searchChkEquip(startDate, outDate);
	}

}