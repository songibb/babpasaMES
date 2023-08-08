package co.yedam.app.sales.rt.mapper;

import java.util.List;

import co.yedam.app.sales.rt.service.RtVO;

public interface RtMapper {
	//전체조회
	public List<RtVO> selectRtAllList();
}
