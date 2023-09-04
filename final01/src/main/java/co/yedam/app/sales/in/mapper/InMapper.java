package co.yedam.app.sales.in.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.in.service.InVO;
import co.yedam.app.sales.order.service.OrderVO;

public interface InMapper {
	//전체조회
	public List<InVO> selectInAllList();
	
	//검색
	public List<InVO> selectAllIn( @Param("prodCode")String prodCode
			, @Param("startDate")String startDate
			, @Param("endDate")String endDate
			, @Param("before") String before
			, @Param("comple") String comple);
	
	//제품목록
	public List<InVO> selectProdAllList();
	
	//등록
	public int insertProductIn(InVO vo);
	
	//수정
	public int updateProductIn(InVO vo);
	
	//삭제
	public int deleteProductIn(InVO vo);
	
	//검수까지 마친 생산품 목록
	public List<InVO> selectCProd();
	
	//입고관리 페이지 그리드
	public List<InVO> inMngList();
	
	//모달 검색 - 제품
	public List<OrderVO> selectProdSearchList(String prodName);
}