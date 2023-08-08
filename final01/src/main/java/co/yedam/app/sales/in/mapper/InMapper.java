package co.yedam.app.sales.in.mapper;

import java.util.List;

import co.yedam.app.sales.in.service.InVO;

public interface InMapper {
	//전체조회
	public List<InVO> selectInAllList();
}
