package co.yedam.app.material.semi.in.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.search.service.SearchVO;
import co.yedam.app.material.semi.in.service.SemiInService;
import co.yedam.app.material.semi.in.service.SemiInVO;

@Controller
public class SemiInController {
	//전체조회
	@Autowired
	SemiInService sis;
	
	//전체조회
	@GetMapping("semiInList")
	public String getSemiInList(Model model) {
		model.addAttribute("inList", sis.selectSemiInList());
		model.addAttribute("prodList", sis.getSemiModal());
		return "material/semiInList";
	}
	
	//전체조회 중 검색
	@GetMapping("getSemiInFilter")
	@ResponseBody
	public List<SemiInVO> getSemiInFilter(SearchVO vo) {
		List<SemiInVO> findVO = sis.selectSemiInSearch(vo);
		return findVO;
	}
	
	//모달검색
	@GetMapping("getSemiModalSearch")
	@ResponseBody
	public List<SemiInVO> getSemiModalSearch(String prodName){
		return sis.getSemiModalSearch(prodName);
	}
	
	//삭제한 행 1번 그리드로 가는 ajax
	@PostMapping("getDeletedSemiInfo")
	@ResponseBody
	public List<SemiInVO> getDeletedMatInfo(@RequestBody List<SemiInVO> list) {
				
		return sis.getDeletedRowsInfo(list);
	}
	
	//관리페이지
	@GetMapping("semiInDir")
	public String getSemiInDir(Model model) {
		model.addAttribute("inList", sis.selectSemiInList());
		model.addAttribute("prodList", sis.getSemiModal());
		model.addAttribute("testList", sis.selectTestFinishList());
		return "material/semiInDir";
	}
	
	//test목록 ajax
	@GetMapping("getSemiTestFinish")
	@ResponseBody
	public List<SemiInVO> getMatTestInFilter(){
		List<SemiInVO> vo = sis.selectTestFinishList();
		return vo;
	}
	
	//등록
	@PostMapping("semiInDirSave")
	@ResponseBody
	public int matInDirSave(@RequestBody GridVO<SemiInVO> data) {
		return sis.modifySemiIn(data);
	}

}
