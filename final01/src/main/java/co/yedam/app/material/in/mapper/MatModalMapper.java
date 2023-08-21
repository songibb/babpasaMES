package co.yedam.app.material.in.mapper;

import java.util.List;

import co.yedam.app.material.in.service.MatModalVO;

public interface MatModalMapper {
	public List<MatModalVO> getMetList();
	
	//모달검색
	public List<MatModalVO> selectModalSearch(String matName);
}
