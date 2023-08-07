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
	
	//��ü ���� ��ȸ
	@GetMapping("/EquipList")
	public String selectEquipAllList(Model model) {
		model.addAttribute("EquipList", equipService.getEquipList());
		return "equip/EquipList";
	}
	
	//���� ��� ������
	@GetMapping("/equipInsert")
	public String equipInsertForm() {
		return "equip/equipInsert";
	}
	
	//��� ó��
	@PostMapping("/equipInsert")
	public String equipInsertProcess(EquipVO equipVO) {
		equipService.insertEquipInfo(equipVO);
		return  "redirect:EquipList";
	}
}
