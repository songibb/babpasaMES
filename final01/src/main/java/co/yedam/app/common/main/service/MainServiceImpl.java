package co.yedam.app.common.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.main.mapper.MainMapper;


@Service
public class MainServiceImpl implements MainService{

	@Autowired
	MainMapper mainMapper;
	
	@Override
	public List<MainVO> selectProdAmtList() {
		
		return mainMapper.selectProdAmtList();
	}

	@Override
	public List<MainVO> selectSaleAmtList() {
		
		return mainMapper.selectSaleAmtList();
	}

}
