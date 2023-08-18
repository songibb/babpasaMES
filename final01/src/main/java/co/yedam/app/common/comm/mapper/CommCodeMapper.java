package co.yedam.app.common.comm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.comm.service.CommCodeVO;
import co.yedam.app.common.grid.service.GridVO;

public interface CommCodeMapper {
	
	//공통코드 조회
	public List<CommCodeVO> selectCommCodeList();
	
	
	//공통코드 검색
	public List<CommCodeVO> searchCommCode(String commCode);
	
	//공통코드 클릭시 상세공통코드 조회 
	public List<CommCodeVO> selectCommDeCodeList(String commCode);
	
	//공통코드 사용여부 조회
	public List<CommCodeVO> selectCommUseInfo();
	
	//공통상세 추가
	public int commDeCodeInsert(CommCodeVO vo);
	
	//공통상세 수정
	public int commDeCodeUpdate(CommCodeVO vo);
	
	//공통상세 삭제
	public int commDeCodeDelete(CommCodeVO vo);
	
	
	
	
	
	//거래처 관리 파트
	//상세 actType 만 조회하는 부분
	public List<CommCodeVO> selectActTypeList();
	
	//act 거래여부 상세공통코드가져오기
	public List<CommCodeVO> selectActStsList();
	
	//상세 eqType 조회 부분
	public List<CommCodeVO> selectEquipTypeList();
	
	//상세 eqSts 조회 부분
	public List<CommCodeVO> selectEquipStsList();
	
	
	
	
	
	
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
	
	
}
