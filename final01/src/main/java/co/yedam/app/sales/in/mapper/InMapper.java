package co.yedam.app.sales.in.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.in.service.InVO;

public interface InMapper {
	//전체조회
	public List<InVO> selectInAllList();
	//검색
	public List<InVO> selectAllIn( @Param("prodCode")String prodCode
			, @Param("startDate")String startDate
			, @Param("endDate")String endDate);
	//제품목록
	public List<InVO> selectProdAllList();
	//등록
	public int insertProductIn(InVO vo);
	//수정
	public int updateProductIn(InVO vo);
	//삭제
	public int deleteProductIn(InVO vo);
}