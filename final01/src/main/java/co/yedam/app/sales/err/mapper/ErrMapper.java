package co.yedam.app.sales.err.mapper;

import java.util.List;

import co.yedam.app.sales.err.service.ErrVO;
import co.yedam.app.sales.out.service.OutVO;

public interface ErrMapper {
	//전체조회
	public List<ErrVO> selectErrList();
	
	//등록
	public int insertErrDis(ErrVO vo);

	//삭제
	public int deleteErrDis(ErrVO vo);
	
	//수정
	public int updateErrDis(ErrVO vo);
}
