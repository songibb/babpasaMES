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

	@Override
	public List<MainVO> selectPrcsAmtList() {
	
		return mainMapper.selectPrcsAmtList();
	}

	@Override
	public MainVO selectTotalSale() {
		
		MainVO vo = mainMapper.selectTotalSale();
		System.out.println("===================="+vo);
		if(vo==null) {
			MainVO vo2 = new MainVO();
			vo2.setSalesOutTotalAmt(0);
			return vo2;
		}else {
			return vo;
		}
	}

	@Override
	public MainVO selectTotalPrcs() {
		
		MainVO vo = mainMapper.selectTotalPrcs();
		if(vo==null) {
			MainVO vo2 = new MainVO();
			vo2.setPassAmt(0);
			return vo2;
		}else {
			return vo;
		}
	}

	@Override
	public MainVO selectTotalErr() {
		
		MainVO vo= mainMapper.selectTotalErr();
		System.out.println(vo);
		
		if(vo==null) {
			MainVO vo2 = new MainVO();
			vo2.setNonPassAmt(0);
			System.out.println(vo);
			return vo2;
			
		}else {
			return vo;
		}
		
	}

}
