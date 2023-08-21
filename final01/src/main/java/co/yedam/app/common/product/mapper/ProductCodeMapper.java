package co.yedam.app.common.product.mapper;

import java.util.List;


import co.yedam.app.common.product.service.ProductCodeVO;

public interface ProductCodeMapper {
	
	//전체 제품 조회
	public List<ProductCodeVO> selectProdCodeList();
	
	//검색 조회
	public List<ProductCodeVO> searchSelectProdCode(String prodName);
	
	//제품 등록 
	public int insertProdInfo(ProductCodeVO productCodeVO);
	
	
	//제품 정보 수정
	public int updateProdInfo(ProductCodeVO productCodeVO);
	
	//제품 삭제
	public int deleteProdInfo(ProductCodeVO productCodeVO);
	
	
	
	//반제품만 보이기 
	public List<ProductCodeVO> selectSemiProdList();
	
	
	// BOM 등록안된제품가져오기
	public List<ProductCodeVO> bomNoProdList();

}
