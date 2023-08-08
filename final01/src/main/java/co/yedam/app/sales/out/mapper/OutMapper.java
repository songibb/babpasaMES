package co.yedam.app.sales.out.mapper;

import java.util.List;

import co.yedam.app.sales.out.service.OutVO;

public interface OutMapper {
	//전체조회
	public List<OutVO> selectOutAllList();
}
