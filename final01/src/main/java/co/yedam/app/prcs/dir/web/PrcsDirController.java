package co.yedam.app.prcs.dir.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	//상세생산지시 조회
	@GetMapping("prcsDirDeList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirDeList(@RequestParam String prcsDirCode){
		List<PrcsDirVO> list = prcsDirService.getPrcsDirDeList(prcsDirCode);
		return list;
	}
}
