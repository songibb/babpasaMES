package co.yedam.app.sales.rt.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

public interface RtService {
	// 전체조회
	public List<RtVO> getRtList();
	// 제품목록
	public List<RtVO> prodAllList();
	// 검색
	public List<RtVO> searchRtList(String prodCode, String startDate, String outDate);
	//반품 등록
	public int insertRtList(List<RtVO> rtList);
	//출고 완료된 목록
	public List<RtVO> getAlreadyOutList();
	//등록, 수정, 삭제
	public int modifyRt(GridVO<RtVO> data);
	//출고목록조회 모달
	public List<OutVO> getOutList();
	//모달 검색 - 제품
	public List<OrderVO> prodSearchList(String prodName);
	//모달 검색 - 출고목록
	public List<RtVO> outSearchList(String prodName);

}
