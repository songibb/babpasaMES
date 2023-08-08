package co.yedam.app.material.order.de.service.Impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import co.yedam.app.material.order.de.mapper.MatOrderDeMapper;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;

@Service
public class MatOrderDeServiceImpl implements MatOrderDeService {

	@Autowired
	MatOrderDeMapper modm;
	
	@Override
	public List<MatOrderDeVO> selectMatOrderList(String startDate, String endDate) {
		return modm.selectMatOrderList(startDate, endDate);
	}

}
