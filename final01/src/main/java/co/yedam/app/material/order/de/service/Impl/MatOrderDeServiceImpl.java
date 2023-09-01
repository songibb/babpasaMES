package co.yedam.app.material.order.de.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.order.de.mapper.MatOrderDeMapper;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;
import co.yedam.app.material.stock.service.MatStockVO;
import co.yedam.app.sales.order.service.OrderVO;

@Service
public class MatOrderDeServiceImpl implements MatOrderDeService {
	//전체조회
	@Autowired
	MatOrderDeMapper modm;
	//전체조회
	@Override
	public List<MatOrderDeVO> selectMatOrderList() {
		return modm.selectMatOrderList();
	}
	
	//전체조회에서 검색
	@Override
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate,
			String endDate, String before, String comple) {
		
		return modm.selectMatOrderSearch(materialCode, accountCode, startDate, endDate, before, comple);
	}
	
	//등록, 수정, 삭제
	@Override
	public int modifyMatOrder(GridVO<MatOrderDeVO> data) {
		int result = 0;
		// TODO Auto-generated method stub
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(MatOrderDeVO vo : data.getDeletedRows()) {
				result += modm.deleteMatOrderDeList(vo);				
			}
			modm.deleteMatOrderList();
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(MatOrderDeVO vo : data.getUpdatedRows()) {
				result += modm.updateMatOrderList(vo);				
			}
			
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			modm.insertMatOrderList(data.getCreatedRows().get(0));
			for(MatOrderDeVO vo : data.getCreatedRows()) {
				result += modm.insertMatOrderDeList(vo);			
			}
		}
		
		return result;
	}
	
	//신규생산계획 조회
	@Override
	public List<MatStockVO> getNewPrcsPlan(String materialName) {
		
		return modm.selectNewPrcsPlan(materialName);
	}


	@Override
	public List<OrderVO> getActMatModal() {
		
		return modm.selectActMatModal();
	}

	@Override
	public List<OrderVO> getActMatModalSearch(String actName) {
		
		return modm.selectActMatModalSearch(actName);
	}

	@Override
	public List<MatOrderDeVO> getMatListPageOrderList() {
		
		return modm.selectMatListPageOrderList();
	}

	@Override
	public List<MatOrderDeVO> getMatListPageOrderDeList(String matOdCd) {
		
		return modm.selectMatListPageOrderDeList(matOdCd);
	}

	@Override
	public List<MatOrderDeVO> getMatListPageOrderListSearch(String accountCode, String startDate, String endDate) {
		
		return modm.selectMatListPageOrderListSearch(accountCode, startDate, endDate);
	}
	
	//해당자재 거래처 찾기
	@Override
	public List<MatOrderDeVO> getMatBuyAct(String matCode) {
		
		return modm.selectMatBuyAct(matCode);
	}

	@Override
	public MatOrderDeVO getActMatPrice(MatOrderDeVO vo) {
		
		return modm.selectActMatPrice(vo);
	}

}
