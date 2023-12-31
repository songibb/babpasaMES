package co.yedam.app.sales.rt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;
import co.yedam.app.sales.rt.mapper.RtMapper;
import co.yedam.app.sales.rt.service.RtService;
import co.yedam.app.sales.rt.service.RtVO;

@Service
public class RtServiceImpl implements RtService {

	@Autowired
	RtMapper rtMapper;

	@Override
	public List<RtVO> getRtList() {
		return rtMapper.selectRtAllList();
	}

	@Override
	public List<RtVO> prodAllList() {
		return rtMapper.selectProdAllList();
	}

	@Override
	public List<RtVO> searchRtList(String prodCode, String startDate, String outDate) {
		return rtMapper.selectAllRt(prodCode, startDate, outDate);
	}

	@Override
	public int insertRtList(List<RtVO> rtList) {
		return rtMapper.insertRtList(rtList);
	}

	@Override
	public List<RtVO> getAlreadyOutList() {
		return rtMapper.selectRtList();
	}

	// 등록, 수정, 삭제
	@Override
	public int modifyRt(GridVO<RtVO> data) {
		int result = 0;
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(RtVO vo : data.getDeletedRows()) {
				result += rtMapper.deleteRt(vo);
			}
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(RtVO vo : data.getUpdatedRows()) {
				result += rtMapper.updateRt(vo);
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(RtVO vo : data.getCreatedRows()) {
				if(String.valueOf(vo.getSalesRtWhy()).equals("E")) {
					result += rtMapper.insertRtE(vo);
				} else if(String.valueOf(vo.getSalesRtWhy()).equals("J")) {
					result += rtMapper.insertRt(vo);
				}
			
			}
		}
		return result;
	}

	@Override
	public List<OutVO> getOutList() {
		return rtMapper.selectOutList();
	}

	@Override
	public List<OrderVO> prodSearchList(String prodName) {
		return rtMapper.selectProdSearchList(prodName);
	}

	@Override
	public List<RtVO> outSearchList(String prodName) {
		return rtMapper.selectOutSearchList(prodName);
	}

}
