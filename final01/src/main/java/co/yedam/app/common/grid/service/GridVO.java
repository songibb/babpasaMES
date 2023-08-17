package co.yedam.app.common.grid.service;

import java.util.List;

import lombok.Data;

@Data
public class GridVO<T> {
	private List<T> updatedRows;
	private List<T> deletedRows;
	private List<T> createdRows;
}
