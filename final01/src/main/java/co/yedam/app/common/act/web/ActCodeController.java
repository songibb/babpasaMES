package co.yedam.app.common.act.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.act.service.ActCodeService;
import co.yedam.app.common.act.service.ActCodeVO;

@Controller
public class ActCodeController {
	
	@Autowired
	ActCodeService actCodeService;
	
	//전체조회
	@GetMapping("/ActCodeList")
	public String ActCodeList(Model model) {
		model.addAttribute("actList", actCodeService.selectActCodeList());
		return "common/actCodeList";
	}
	//검색조회
	@GetMapping("/ActCodeSearch")
	@ResponseBody
	public List<ActCodeVO>  ActCodeSearch(@RequestParam String commdeName){
		List<ActCodeVO> vo = actCodeService.searchSelectActCode(commdeName);
		return vo;
	}
}
