package co.yedam.app.common.product.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public Map<String, String> insertProdInfo(ProductCodeVO productCodeVO) {
		Map<String, String> map = new HashMap<>();
		
		int result = productCodeMapper.insertProdInfo(productCodeVO);
		
		if(result == 1) {
			map.put("결과", "Success");
		} else {
			map.put("결과", "Fail");
		}
		return map;
	}

	@Override
	public Map<String, String> updateProdInfo(ProductCodeVO productCodeVO) {
		Map<String, String> map = new HashMap<>();
		
		int result = productCodeMapper.updateProdInfo(productCodeVO);
		
		if(result == 1) {
			map.put("결과", "Success");
		} else {
			map.put("결과", "Fail");
		}
		return map;
	}

	@Override
	public int deleteProdInfo(ProductCodeVO productCodeVO) {
		
		int result = productCodeMapper.deleteProdInfo(productCodeVO);
		
		 return result;
	}

	@Override
	public List<ProductCodeVO> selectSemiProdList() {
		
		return productCodeMapper.selectSemiProdList();
	}

	@Override
	public List<ProductCodeVO> bomNoProdList() {
		
		return productCodeMapper.bomNoProdList();
	}

	@Override
	public int prodNameUseCheck(String prodNameUse) {
		List<ProductCodeVO> list = productCodeMapper.prodNameUseCheck(prodNameUse);
		System.out.println(list);
		if(list.isEmpty()) {
			return 1;
		}else {
			return 0;
		}
	}

}
