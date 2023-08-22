package co.yedam.app.sales.rt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.out.service.OutVO;
import co.yedam.app.sales.rt.service.RtVO;

public interface RtMapper {
	//전체조회
	public List<RtVO> selectRtAllList();
	//제품 목록
	public List<RtVO> selectProdAllList();
	//검색
	public List<RtVO> selectAllRt(@Param("prodCode")String prodCode);
	//반품 등록
	public int insertRtList(@Param("rtList") List<RtVO> rtList);
	//반품 등록 페이지 리스트
	public List<RtVO> selectRtList();
	//등록
	public int insertRt(RtVO vo);
	
	//수정
	public int updateRt(RtVO vo);
	
	//삭제
	public int deleteRt(RtVO vo);
	
	//출고목록조회 모달
	public List<OutVO> selectOutList();
}
