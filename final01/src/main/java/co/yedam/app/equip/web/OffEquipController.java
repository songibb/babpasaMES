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
	
	
	//상단 비가동 전체조회
	@GetMapping("/offequip")
	public String getOffEquipList(Model model) {
		model.addAttribute("offequip",offEquipService.getOffEquipList());
		
		model.addAttribute("allequip", offEquipService.getAllEquip());
		return "equip/offequip";
	}
		
		
	//Ajax 연결 - 전체 설비 리스트
	@GetMapping("selectoffequip") //Equiplist.jsp의 ajax url과 연결되는 것 
	@ResponseBody
	public List<OffEquipVO> getOffequip(){
		List<OffEquipVO> list = offEquipService.getOffEquipList();
		return list;
	}
		
	//등록페이지
	@GetMapping("/insertOffEquip")
	public String OffEquipInsertForm() {
		return "equip/offequip";
				
	}
	
	//비가동 설비 등록
	@PostMapping("/insertOffEquip")
	@ResponseBody
	public String OffEquipInsert(OffEquipVO offequipVO) {
		return offEquipService.insertOffEquip(offequipVO);
		
	}
	
	//비가동 설비 수정
	@PostMapping("/updateOffEquip")
	@ResponseBody
	public String OffEquipUpdate(OffEquipVO offequipVO) {
		return offEquipService.updateOffEquip(offequipVO);
		
	}
	
	
	//모달 가져온 전체설비 단건으로 넣기(조회)
	@GetMapping("getOffEquipInfo")
	@ResponseBody
	public OffEquipVO getOffEquipOne(@RequestParam String eqCode) {
		OffEquipVO vo = new OffEquipVO();
		vo.setEqCode(eqCode);
		OffEquipVO findVO = offEquipService.getOffEquipInfo(vo);
		return findVO;
	}
	
	//설비검색조회
	@GetMapping("/offsearchEquip")
	@ResponseBody
	public List<EquipVO> offSearchEquip(@RequestParam String eqName) {
		List<EquipVO> vo = offEquipService.offsearchEquip(eqName);
		return vo;
				
	}
}