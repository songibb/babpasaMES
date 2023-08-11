package co.yedam.app.equip.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.equip.service.EquipService;
import co.yedam.app.equip.service.EquipVO;

@Controller
public class EquipController {

	@Autowired
	EquipService equipService;
	
	//전체 설비
	@GetMapping("/EquipList")
	public String selectEquipAllList(Model model) {
		model.addAttribute("EquipList", equipService.getEquipList());
		return "equip/EquipList";
	}
	
	//Ajax 연결 - 전체 설비 리스트
	@GetMapping("selectEquipAllList") //Equiplist.jsp의 ajax url과 연결되는 것 
	@ResponseBody
	public List<EquipVO> getEquipList(){
		List<EquipVO> list = equipService.getEquipList();
		return list;
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
		
		/*
		 * //모달 설비 조회
		 * 
		 * @GetMapping("/ModalEquip") public String EquipModalList(Model model) {
		 * model.addAttribute("ModalEquip", equipService.getModalEquipList()); return
		 * "equip/equipInsert"; }
		 */
	
	//설비 수정
	@PostMapping("/equipUpdate")
	public Map<String, String> equipUpdateProcess(@RequestBody EquipVO equipVo ){
		return equipService.updateEquip(equipVo);
	}
		
	//설비 삭제
	@GetMapping("/equipDelete")
	@ResponseBody
	public String equipDelete(@RequestParam(name="eqCode", value="eqCode")String eqCode) {
		equipService.deleteEquipInfo(eqCode);
		return "equip/EquipList";
	}
	
	//설비 단건 조회
	@GetMapping("getEquip") //Equiplist.jsp의 ajax url과 연결되는 것 
	@ResponseBody
	public EquipVO getEquipOne(@RequestParam String eqCode){
		EquipVO vo = new EquipVO();
		vo.setEqCode(eqCode);
		EquipVO findVO = equipService.getEquipInfo(vo);
		return findVO;
	}
}
