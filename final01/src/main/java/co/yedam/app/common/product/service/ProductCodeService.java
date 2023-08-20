package co.yedam.app.common.product.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface ProductCodeService {
	
	//전체조회
	public List<ProductCodeVO> getProductCodeAll();
	
	//검색 조회
	public List<ProductCodeVO> searchSelectProdCode(String prodName);
	
	//제품 등록 
	public Map<String, String> insertProdInfo(ProductCodeVO productCodeVO);
		
		
	//제품 정보 수정
	public Map<String, String> updateProdInfo(ProductCodeVO productCodeVO);
	
	//제품 삭제
	public int deleteProdInfo(ProductCodeVO productCodeVO);
	
	
	//반제품만 보이기 
	public List<ProductCodeVO> selectSemiProdList();

}
