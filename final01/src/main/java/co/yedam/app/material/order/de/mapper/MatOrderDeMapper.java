package co.yedam.app.material.order.de.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.order.de.service.MatOrderDeVO;
import co.yedam.app.material.stock.service.MatStockVO;
import co.yedam.app.sales.order.service.OrderVO;

public interface MatOrderDeMapper {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate, @Param("before") String before, @Param("comple") String comple);
	
	//거래처목록, 구매품목 필요함
	//구매품목 select
	public List<MatInVO> selectBuyMatList(String actCode); 
	
	//등록
	public int insertMatOrderList(MatOrderDeVO vo);
	public int insertMatOrderDeList(MatOrderDeVO vo);
	
	//수정
	public int updateMatOrderList(MatOrderDeVO vo);
	
	//삭제
	public int deleteMatOrderList();
	public int deleteMatOrderDeList(MatOrderDeVO vo);
	
	//신규생산계획
	public List<MatStockVO> selectNewPrcsPlan(String materialName);
	
	
	//자재 거래처 모달
	public List<OrderVO> selectActMatModal();
	
	//자재 거래처 모달 검색
	public List<OrderVO> selectActMatModalSearch(String actName);
	
	//헤더 그리드
	public List<MatOrderDeVO> selectMatListPageOrderList();
	
	//헤더에서 검색
	public List<MatOrderDeVO> selectMatListPageOrderListSearch(@Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//상세 그리드
	public List<MatOrderDeVO> selectMatListPageOrderDeList(String matOdCd);
	
	//해당 자재 거래처찾기
	public List<MatOrderDeVO> selectMatBuyAct(String matCode);
	//해당 자재 거래처 가격찾기
	public MatOrderDeVO selectActMatPrice(MatOrderDeVO vo);
}
