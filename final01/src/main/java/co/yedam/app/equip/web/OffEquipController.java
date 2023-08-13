package co.yedam.app.equip.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.equip.service.OffEquipService;
import co.yedam.app.equip.service.OffEquipVO;

@Controller
public class OffEquipController {

	@Autowired
	OffEquipService offEquipService;
	
	
	//��� �񰡵� ��ü��ȸ
	@GetMapping("/offequip")
	public String getOffEquipList(Model model) {
		model.addAttribute("offequip",offEquipService.getOffEquipList());
		
		model.addAttribute("allequip", offEquipService.getAllEquip());
		return "equip/offequip";
	}
	
	
		
	//���������
	@GetMapping("/insertOffEquip")
	public String OffEquipInsertForm() {
		return "equip/offequip";
				
	}
	
	//�񰡵� ���� ���
	@PostMapping("/insertOffEquip")
	public String OffEquipInsert(OffEquipVO offequipVO) {
		offEquipService.insertOffEquip(offequipVO);
		return "redirect:offequip";
	}
	
	//��� ������ ��ü���� �ܰ����� �ֱ�(��ȸ)
	@GetMapping("getOffEquipInfo")
	@ResponseBody
	public OffEquipVO getOffEquipOne(@RequestParam String eqCode) {
		OffEquipVO vo = new OffEquipVO();
		vo.setEqCode(eqCode);
		OffEquipVO findVO = offEquipService.getOffEquipInfo(vo);
		return findVO;
	}
	
}