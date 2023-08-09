package co.yedam.app.common.product.mapper;

import java.util.List;

import co.yedam.app.common.product.service.ProductCodeVO;

public interface ProductCodeMapper {
	
	//전체 제품 조회
	public List<ProductCodeVO> selectProdCodeList();
	
	//검색 조회
	public List<ProductCodeVO> searchSelectProdCode(String prodName);

}
