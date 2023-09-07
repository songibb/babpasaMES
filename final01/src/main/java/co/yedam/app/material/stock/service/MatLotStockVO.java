package co.yedam.app.material.stock.service;

import java.util.Date;

import lombok.Data;

@Data
public class MatLotStockVO {

	private String matLot;
	private String matCode;
	private Integer lotStock;
	private Date matExd;
	private String matName;
	
	private String materialCode;
	private String lotName;
}
