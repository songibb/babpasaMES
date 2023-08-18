package co.yedam.app.material.stock.service;

import lombok.Data;

@Data
public class MatStockVO {
	//조회
	
	//자재코드, 자재명, 규격, 재고량, 안전재고량
	private String matCode;
	private String matName;
	private String matUnit;
	private String matStd;
	private Integer totalStock;
	private Integer matSafe;
	
	//제품의 Lot별 재고(모달창)
	
}
