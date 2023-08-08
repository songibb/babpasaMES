package co.yedam.app.prcs.prod.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.prod.service.PrcsProdService;
import co.yedam.app.prcs.prod.service.PrcsProdVO;

@Controller
public class PrcsProdController {
	
	@Autowired
	PrcsProdService prcsProdService;
	
	//제품별공정 조회 - 호출
	@GetMapping("prcsProdList")
	public String getPrcsProdList(Model model){
		model.addAttribute("prcsProdList",prcsProdService.getPrcsProdList());
		return "process/prcsProdList";
	}
	
	//제품별공정 조회 - 리스트
	@GetMapping("selectPrcsProdList")
	@ResponseBody
	public List<PrcsProdVO> getPrcsProdList(){
		List<PrcsProdVO> list = prcsProdService.getPrcsProdList();
		return list;
	}
		
}
