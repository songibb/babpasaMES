package co.yedam.app.sales.out.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.order.service.OrderVO;

public interface OutService {
	//전체조회
	public List<OutVO> getOutList();
	
	//거래처 목록
	public List<OutVO> actAllList();
	
	//제품목록
	public List<OutVO> prodAllList();
	
	//검색
	public List<OutVO> searchOutList(String prodCode, String actCode, String startDate, String outDate, String before, String comple);
	
	//출고완료된 품목만 보여주는 출고 리스트
	public List<OutVO> getOutNList();
	
	//등록, 수정, 삭제
	public int modifyOut(GridVO<OutVO> data);
	
	//order detail list
	public List<OutVO> OrderDeList();
	
	//모달 검색 - 제품
	public List<OrderVO> prodSearchList(String prodName);
	
	//모달 검색 - 거래처
	public List<OutVO> actSearchList(String actName);
	
	//모달 검색 - 제품LOT
	public List<OutVO> lotSearchList(String prodName);
	
	//모달 검색 - 상세주문
	public List<OutVO> ordDeSearchList(String actName);
	
	//주문상세에서 해당하는 lot목록만 뜨도록 하는 ajax
	public List<OutVO> getProdLotList(String prodCode);
	
}
