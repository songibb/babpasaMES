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
	
	//�쟾泥� �꽕鍮�
	@GetMapping("/EquipList")
	public String selectEquipAllList(Model model) {
		model.addAttribute("EquipList", equipService.getEquipList());
		return "equip/EquipList";
	}
	
	//Ajax �뿰寃� - �쟾泥� �꽕鍮� 由ъ뒪�듃
	@GetMapping("selectEquipAllList") //Equiplist.jsp�쓽 ajax url怨� �뿰寃곕릺�뒗 寃� 
	@ResponseBody
	public List<EquipVO> getEquipList(){
		List<EquipVO> list = equipService.getEquipList();
		return list;
	}
	
	//�꽕鍮� �벑濡� �럹�씠吏�
		@GetMapping("/equipInsert")
		public String equipInsertForm() {
			return "equip/equipInsert";
		}
		
		//�벑濡� 泥섎━
		@PostMapping("/equipInsert")
		public String equipInsertProcess(EquipVO equipVO) {
			equipService.insertEquipInfo(equipVO);
			return  "redirect:EquipList";
		}
		
		/*
		 * //紐⑤떖 �꽕鍮� 議고쉶
		 * 
		 * @GetMapping("/ModalEquip") public String EquipModalList(Model model) {
		 * model.addAttribute("ModalEquip", equipService.getModalEquipList()); return
		 * "equip/equipInsert"; }
		 */
	
	//�꽕鍮� �닔�젙
	@PostMapping("/equipUpdate")
	@ResponseBody
	public Map<String, String> equipUpdateProcess(@RequestBody EquipVO equipVo ){
		return equipService.updateEquip(equipVo);
	}
		
	//�꽕鍮� �궘�젣
	@GetMapping("/equipDelete")
	@ResponseBody
	public String equipDelete(@RequestParam(name="eqCode", value="eqCode")String eqCode) {
		equipService.deleteEquipInfo(eqCode);
		return "equip/EquipList";
	}
	
	//�꽕鍮� �떒嫄� 議고쉶
	@GetMapping("getEquip") //Equiplist.jsp�쓽 ajax url怨� �뿰寃곕릺�뒗 寃� 
	@ResponseBody
	public EquipVO getEquipOne(@RequestParam String eqCode){
		EquipVO vo = new EquipVO();
		vo.setEqCode(eqCode);
		EquipVO findVO = equipService.getEquipInfo(vo);
		return findVO;
	}
	
	//설비검색조회
		@GetMapping("/searchEquip")
		@ResponseBody
		public List<EquipVO> SearchEquip(@RequestParam String eqName) {
			List<EquipVO> vo = equipService.searchEquip(eqName);
			return vo;
					
		}
}
