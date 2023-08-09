package co.yedam.app.common.product.service;

import java.util.List;

public interface ProductCodeService {
	
	//전체조회
	public List<ProductCodeVO> getProductCodeAll();
	
	//검색 조회
	public List<ProductCodeVO> searchSelectProdCode(String prodName);

}
