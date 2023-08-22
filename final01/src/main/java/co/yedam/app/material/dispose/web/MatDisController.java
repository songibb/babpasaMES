package co.yedam.app.material.dispose.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.dispose.service.MatDisService;
import co.yedam.app.material.dispose.service.MatDisVO;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.search.service.SearchVO;

@Controller
public class MatDisController {
	
	@Autowired
	MatDisService mds;

	//자재목록 모달
	@Autowired
	MatModalService mms;
		
	//전체조회
	@GetMapping("matDisList")
	public String getMatRtList(Model model){
		model.addAttribute("disList", mds.getMatDisList());
		model.addAttribute("matList", mms.getMetList());
			
		return "material/matDisList";
	}
		
	//검색 ajax
	@GetMapping("getMatDisFilter")
	@ResponseBody
	public List<MatDisVO> getMatRtFilter(SearchVO vo) {
		List<MatDisVO> findVO = mds.getMatDisSearch(vo);
		return findVO;
	}
		
	//삭제한 행 1번 그리드로 가는 ajax
//	@PostMapping("getDeletedRtInfo")
//	@ResponseBody
//	public List<MatTestVO> getDeletedMatInfo(@RequestBody List<MatRtVO> list) {
//				
//		return mrs.getDeletedRowsInfo(list);
//	}
		
	//관리페이지
	@GetMapping("matDisDir")
	public String getMatRtDir(Model model) {
		model.addAttribute("disList", mds.getMatDisList());
		model.addAttribute("rtList", mds.getRtFailList());
		model.addAttribute("exdList", mds.getOverDateList());
		model.addAttribute("matList", mms.getMetList());
		return "material/matDisDir";
	}
		
	//test목록 ajax
	@GetMapping("getRtFailFilter")
	@ResponseBody
	public List<MatRtVO> getRtFailFilter(){
		List<MatRtVO> vo = mds.getRtFailList();
		return vo;
	}
	
	@GetMapping("getOverDateFilter")
	@ResponseBody
	public List<MatInVO> getOverDateFilter(){
		List<MatInVO> vo = mds.getOverDateList();
		return vo;
	}
	
		
	//등록
	@PostMapping("matDisDirSave")
	@ResponseBody
	public int matInDirSave(@RequestBody GridVO<MatDisVO> data) {
		return mds.modifyMatDis(data);
	}

}
