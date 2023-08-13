package co.yedam.app.equip.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.equip.service.EquipChkService;
import co.yedam.app.equip.service.EquipChkVO;

@Controller
public class EquipChkController {

	@Autowired
	EquipChkService equipChkService;
	
	//��ü��ȸ
	@GetMapping("/equipchkList")
	public String getEquipChkList(Model model) {
		model.addAttribute("equipchkList",equipChkService.getEquipChkList());
		return "equip/equipchkList";
	}
	
	//AJAX ����
	@GetMapping("selectEquipChkList") //Equiplist.jsp�� ajax url�� ����Ǵ� �� 
	@ResponseBody
	public List<EquipChkVO> getEquipChkAllList(){
		List<EquipChkVO> list = equipChkService.getEquipChkList();
		return list;
	}
}