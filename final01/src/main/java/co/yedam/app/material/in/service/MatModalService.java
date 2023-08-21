package co.yedam.app.material.in.service;

import java.util.List;

public interface MatModalService {
	public List<MatModalVO> getMetList();
	
	//모달검색
	public List<MatModalVO> selectModalSearch(String matName);
}
