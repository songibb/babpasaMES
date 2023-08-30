package co.yedam.app.material.order.de.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.sales.order.service.OrderVO;



public interface MatOrderDeService {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate, String endDate, String before, String comple);
	
	
	//등록, 수정, 삭제
	public int modifyMatOrder(GridVO<MatOrderDeVO> data);
	
	//신규생산계획 조회
	public List<PrcsPlanVO> getNewPrcsPlan();
	
	//해당 계획 소모 자재
	public List<MatInVO> getNewPlanUseAmt(String prodCode);
	
	//자재 거래처 모달
	public List<OrderVO> getActMatModal();
	
	//자재 거래처 모달 검색
	public List<OrderVO> getActMatModalSearch(String actName);
	
	//헤더 그리드
	public List<MatOrderDeVO> getMatListPageOrderList();
	
	//상세 그리드
	public List<MatOrderDeVO> getMatListPageOrderDeList(String matOdCd);
}
