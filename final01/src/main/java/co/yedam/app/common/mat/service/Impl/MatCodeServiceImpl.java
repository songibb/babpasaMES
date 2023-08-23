package co.yedam.app.common.mat.service.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.common.mat.mapper.MatCodeMapper;
import co.yedam.app.common.mat.service.MatCodeService;
import co.yedam.app.common.mat.service.MatCodeVO;

@Service
public class MatCodeServiceImpl implements MatCodeService {

	
	@Autowired
	MatCodeMapper matCodeMapper;
	@Override
	public List<MatCodeVO> selectMatCodeList() {
		
		return matCodeMapper.selectMatCodeList();
	}
	
	
	@Override
	public List<MatCodeVO> searchMatCode(String matName) {

		return matCodeMapper.searchMatCode(matName);
	}
	
	
	/*
	 * @Override public int updateMatCode(GridVO<MatCodeVO> data) {
	 * 
	 * int result = 0; if(data.getDeletedRows()!= null &&
	 * data.getDeletedRows().size()>0) {
	 * 
	 * for(MatCodeVO vo : data.getDeletedRows()) { result +=
	 * matCodeMapper.matCodeDelete(vo); }
	 * 
	 * }
	 * 
	 * if(data.getUpdatedRows()!=null && data.getUpdatedRows().size()>0) {
	 * for(MatCodeVO vo : data.getUpdatedRows()) { result +=
	 * matCodeMapper.matCodeUpdate(vo); } }
	 * 
	 * if(data.getCreatedRows()!= null && data.getCreatedRows().size()>0) {
	 * for(MatCodeVO vo : data.getCreatedRows()) { result +=
	 * matCodeMapper.matCodeInsert(vo); } }
	 * 
	 * return result; }
	 */
	@Override
	public Map<String, Object> updateMatCode(GridVO<MatCodeVO> data) {
		
		Map<String, Object> map = new HashMap<>();
		
		int success = 0;
		
		int fail =0;
		
		if(data.getDeletedRows()!= null && data.getDeletedRows().size()>0) {
			
			for(MatCodeVO vo : data.getDeletedRows()) {
				matCodeMapper.matCodeDelete(vo);
				
				Integer error = vo.getResult();
				System.out.println(error);
				if(error == null) {
					fail=0;
				}else if(error == -1){
					fail++;
			}
			}
		}
		
		if(data.getUpdatedRows()!=null && data.getUpdatedRows().size()>0) {
			for(MatCodeVO vo : data.getUpdatedRows()) {
				success += matCodeMapper.matCodeUpdate(vo);
			}
		}
		
		if(data.getCreatedRows()!= null && data.getCreatedRows().size()>0) {
			for(MatCodeVO vo : data.getCreatedRows()) {
				success += matCodeMapper.matCodeInsert(vo);
			}
		}
		
	map.put("fail", fail);
	map.put("success", success);
	return map;
	}
}
