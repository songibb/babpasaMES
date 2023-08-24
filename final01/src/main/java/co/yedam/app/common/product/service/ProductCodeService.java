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
	public List<String> deleteProdInfo(List<ProductCodeVO> checkedProd);
	
	
	//반제품만 보이기 
	public List<ProductCodeVO> selectSemiProdList();
	
	// BOM 등록안된제품가져오기
	public List<ProductCodeVO> bomNoProdList();
	
	//동일제품명 중복 확인용
	public int prodNameUseCheck(String prodNameUse);

}
