package co.yedam.app.common.product.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.product.mapper.ProductCodeMapper;
import co.yedam.app.common.product.service.ProductCodeService;
import co.yedam.app.common.product.service.ProductCodeVO;

@Service
public class ProductCodeServiceImpl implements ProductCodeService {

	@Autowired
	ProductCodeMapper productCodeMapper;
	
	@Override
	public List<ProductCodeVO> getProductCodeAll() {
		
		return productCodeMapper.selectProdCodeList();
	}

	@Override
	public List<ProductCodeVO> searchSelectProdCode(String prodName) {
		
		return productCodeMapper.searchSelectProdCode(prodName);
	}

}
