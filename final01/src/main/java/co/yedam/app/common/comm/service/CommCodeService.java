package co.yedam.app.common.comm.service;

import java.util.List;


import co.yedam.app.common.grid.service.GridVO;

public interface CommCodeService {
	
	//공통코드 조회
	public List<CommCodeVO> selectCommCodeList();
	
	//공통코드 검색
	public List<CommCodeVO> searchCommCode(String commCode);
		
	//공통코드 클릭시 상세공통코드 조회 
	public List<CommCodeVO> selectCommDeCodeList(String commCode);
	
	//공통코드 사용여부 조회
	public List<CommCodeVO> selectCommUseInfo();
	
	//공통상세 추가/수정/삭제
	public int updateCommDeCode(GridVO<CommCodeVO> data);
	
	
	
	
	//상세 actType 만 조회하는 부분
	public List<CommCodeVO> selectActTypeList();
	
	// eqType 조회하는 부분
	public List<CommCodeVO> selectEquipTypeList();
	
	// eqSts 조회하는 부분
	public List<CommCodeVO> selectEquipStsList();
	
	//act 거래여부 상세공통코드가져오기
	public List<CommCodeVO> selectActStsList();
	

	//bom관리 파트
	//제품에 대한 bom 코드가 사용중인지 
	public List<CommCodeVO> selectBomUseInfo();
	
	//현재공정에 이 제품 BOM이 사용즁인지
	public List<CommCodeVO> selectBomPrcsUseInfo();
	
	
	//자재관리 파트
	// 단위
	public List<CommCodeVO> selectMatUnitInfo();

	//제품 반/완제품 구분
	public List<CommCodeVO> selectProdTypeInfo();
	
	

	//BOM 단위
	public List<CommCodeVO> selectBomUnit();
		
}
