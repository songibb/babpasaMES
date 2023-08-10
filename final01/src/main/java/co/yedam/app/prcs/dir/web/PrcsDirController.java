package co.yedam.app.prcs.dir.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.dir.service.PrcsDirService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;

@Controller
public class PrcsDirController {
	
	@Autowired
	PrcsDirService prcsDirService;
	
	//생산지시 조회
	@GetMapping("prcsDirList")
	public String getPrcsDirAllList(Model model) {
		model.addAttribute("dirList", prcsDirService.getPrcsDirList());
		return "process/prcsDirList";
	}
	
	//생산지시 조회 - 리스트
	@GetMapping("selectPrcsDirList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirAllList() {
		List<PrcsDirVO> list = prcsDirService.getPrcsDirList();
		return list;
	}
	
	
	
	//상세생산지시 조회
	@GetMapping("prcsDirDeList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirDeList(@RequestParam String prcsDirCode){
		List<PrcsDirVO> list = prcsDirService.getPrcsDirDeList(prcsDirCode);
		return list;
	}
	
	//생산지시 등록 - 페이지 호출
	@GetMapping("prcsDir")
	public String getPrcsDirInsert() {
		return "process/prcsDir";
	}
	
	//생산지시 등록
	@PostMapping("prcsDirInsert")
	@ResponseBody
	public String prcsDirInsert(@RequestBody PrcsDirVO prcsDirVO) {
		 prcsDirService.insertPrcsDir(prcsDirVO);
		 return "redirect:prcsDir";
	}
}
