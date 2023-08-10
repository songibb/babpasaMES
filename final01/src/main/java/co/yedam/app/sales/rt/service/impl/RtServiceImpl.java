package co.yedam.app.sales.rt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<RtVO> searchRtList(String prodCode) {
		return rtMapper.selectAllRt(prodCode);
	}

}
