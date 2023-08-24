package co.yedam.app.quality.mat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.mat.mapper.MatChkMapper;
import co.yedam.app.quality.mat.service.MatChkService;
import co.yedam.app.quality.mat.service.MatChkVO;

@Service
public class MatChkServiceImpl implements MatChkService {

	@Autowired
	MatChkMapper matchkMapper;
	
	
	//전체조회
	@Override
	public List<MatChkVO> selectMatChkList() {
		// TODO Auto-generated method stub
		return matchkMapper.selectMatChkLIst();
	}
	
	//자재 상세 발주 조회(모달)
	@Override
	public List<MatChkVO> selectNotChkMatList(){
		return matchkMapper.selectNotChkMatList();
	}
	
	//등록, 수정, 삭제
		@Override
		public int modifyMatChk(GridVO<MatChkVO> data) {
			int result = 0;
			// TODO Auto-generated method stub
			
			if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
				for(MatChkVO vo : data.getDeletedRows()) {
					result += matchkMapper.deleteMatChk(vo);				
				}
			}
			if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
				for(MatChkVO vo : data.getUpdatedRows()) {
					result += matchkMapper.updateMatChk(vo);				
				}
			}
			
			if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
				for(MatChkVO vo : data.getCreatedRows()) {
					result += matchkMapper.insertMatChk(vo);				
				}
			}
			
			return result;
			
		}
		
		//모달 : 사원 조회
		@Override
		public List<MatChkVO> selectEmpList(){
			return matchkMapper.selectEmpList();
					
		}
		
		//자재 검색
		@Override
		public List<MatChkVO> searchMatChk(String matName){
			return matchkMapper.searchMatChk(matName);
		}

}
