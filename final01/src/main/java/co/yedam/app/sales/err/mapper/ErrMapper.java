package co.yedam.app.sales.err.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.err.service.ErrVO;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

public interface ErrMapper {
	//전체조회
	public List<ErrVO> selectErrList();
	
	//등록
	public int insertErrDis(ErrVO vo);

	//삭제
	public int deleteErrDis(ErrVO vo);
	
	//수정
	public int updateErrDis(ErrVO vo);
	
	//검색
	public List<ErrVO> selectAllOut(@Param("prodCode")String prodCode
									, @Param("startDate")String startDate
									, @Param("endDate")String endDate);
	
	//모달내 검색 - 제품
	public List<OrderVO> selectProdSearchList(String prodName);
	
	//그리드 모달 - 폐기목록
	public List<ErrVO> ModalDisList();
	
	//그리드 모달 - 제품목록
	public List<OutVO> selectProdAllList();
	
	//모달 검색 - 검수
	public List<ErrVO> ErrSearchList(String prodName);
}
