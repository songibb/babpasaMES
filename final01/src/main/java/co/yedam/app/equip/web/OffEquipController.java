package co.yedam.app.equip.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.equip.service.OffEquipService;
import co.yedam.app.equip.service.OffEquipVO;

@Controller
public class OffEquipController {

	@Autowired
	OffEquipService offEquipService;
	
	//전체조회
	@GetMapping("/offequip")
	public String getOffEquipList(Model model) {
		model.addAttribute("offequip",offEquipService.getOffEquipList());
		model.addAttribute("allequip", offEquipService.getAllEquip());
		return "equip/offequip";
	}
	
	//AJAX 연결
		@GetMapping("selectOffEquipAllList") //Equiplist.jsp의 ajax url과 연결되는 것 
		@ResponseBody
		public List<OffEquipVO> getOffEquipChkAllList(){
			List<OffEquipVO> list = offEquipService.getOffEquipList();
			return list;
		}
		
	
}