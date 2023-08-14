package co.yedam.app.common.comm.mapper;

import java.util.List;

import co.yedam.app.common.comm.service.CommCodeVO;

public interface CommCodeMapper {
	
	//공통코드 조회
	public List<CommCodeVO> selectCommCodeList();
	
	//상세공통코드 조회
	public List<CommCodeVO> selectCommDeCodeList();
	
	//상세 actType 만 조회하는 부분
	public List<CommCodeVO> selectActTypeList();
	
	//act 거래여부 상세공통코드가져오기
	public List<CommCodeVO> selectActStsList();
	
	
}
