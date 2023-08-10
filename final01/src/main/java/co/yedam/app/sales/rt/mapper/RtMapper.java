package co.yedam.app.sales.rt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.rt.service.RtVO;

public interface RtMapper {
	//전체조회
	public List<RtVO> selectRtAllList();
	//제품 목록
		public List<RtVO> selectProdAllList();
		//검색
		public List<RtVO> selectAllRt(@Param("prodCode")String prodCode);
}
