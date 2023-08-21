package co.yedam.app.common.comm.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.grid.service.GridVO;

public interface CommCodeService {
	
	//공통코드 조회
	public List<CommCodeVO> selectCommCodeList();
	
	//공통코드 검색
	public List<CommCodeVO> searchCommCode(String commCode);
		
	//공통코드 클릭시 상세공통코드 조회 
	public List<CommCodeVO> selectCommDeCodeList(String commCode);
	
	
	//공통상세 추가/수정/삭제
	public int updateCommDeCode(GridVO<CommCodeVO> data);
	
	//공통코드 select box사용시 가져가는것
	public List<CommCodeVO> searchCommCodeUse(@Param("commCode") String code);

	// eqType 조회하는 부분
	public List<CommCodeVO> selectEquipTypeList();
	
	// eqSts 조회하는 부분
	public List<CommCodeVO> selectEquipStsList();

		
}
