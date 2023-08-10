package co.yedam.app.material.in.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.in.mapper.MatModalMapper;
import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.in.service.MatModalVO;

@Service
public class MatModalServiceImpl implements MatModalService {
	
	@Autowired
	MatModalMapper mmm;
	
	@Override
	public List<MatModalVO> getMetList() {
		
		return mmm.getMetList();
	}

}
