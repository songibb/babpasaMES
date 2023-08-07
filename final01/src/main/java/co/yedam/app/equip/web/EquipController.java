package co.yedam.app.equip.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import co.yedam.app.equip.service.EquipService;
import co.yedam.app.equip.service.EquipVO;

@Controller
public class EquipController {

	@Autowired
	EquipService equipService;
	
	//전체 설비 조회
	@GetMapping("/EquipList")
	public String selectEquipAllList(Model model) {
		model.addAttribute("EquipList", equipService.getEquipList());
		return "equip/EquipList";
	}
	
	//설비 등록 페이지
	@GetMapping("/equipInsert")
	public String equipInsertForm() {
		return "equip/equipInsert";
	}
	
	//등록 처리
	@PostMapping("/equipInsert")
	public String equipInsertProcess(EquipVO equipVO) {
		equipService.insertEquipInfo(equipVO);
		return  "redirect:EquipList";
	}
}
