package co.yedam.app.common.comm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.comm.service.CommCodeVO;

public interface CommCodeMapper {
	
	//공통코드 조회
	public List<CommCodeVO> selectCommCodeList();
	
	
	//공통코드 검색
	public List<CommCodeVO> searchCommCode(String commCode);
	public List<CommCodeVO> searchCommCodeUse(@Param("commCode") String code);
	
	//공통코드 클릭시 상세공통코드 조회 
	public List<CommCodeVO> selectCommDeCodeList(String commCode);
	
	
	//공통상세 추가
	public int commDeCodeInsert(CommCodeVO vo);
	
	//공통상세 수정
	public int commDeCodeUpdate(CommCodeVO vo);
	
	//공통상세 삭제
	public int commDeCodeDelete(CommCodeVO vo);
	
	
	
	
	
	//상세 eqType 조회 부분
	public List<CommCodeVO> selectEquipTypeList();
	
	//상세 eqSts 조회 부분
	public List<CommCodeVO> selectEquipStsList();
	
	
	
	
	

	
}
