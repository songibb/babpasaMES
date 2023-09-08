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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import co.yedam.app.common.act.service.ActCodeService;
import co.yedam.app.common.act.service.ActCodeVO;
import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.equip.service.EquipService;
import co.yedam.app.equip.service.EquipVO;

@Controller
public class EquipController {

	@Autowired
	EquipService equipService;
	
	@Autowired
	CommCodeService commCodeService;
	
	@Autowired
	ActCodeService actCodeService;
	
	//전체 설비
	@GetMapping("/EquipList")
	public String selectEquipAllList(Model model) {
		model.addAttribute("EquipList", equipService.getEquipList());
		model.addAttribute("EquipTypeList", commCodeService.selectEquipTypeList());
		model.addAttribute("EquipStsList", commCodeService.selectEquipStsList());
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
		public String equipInsertForm(Model model) {
			model.addAttribute("EquipTypeList", commCodeService.selectEquipTypeList());
			model.addAttribute("EquipStsList", commCodeService.selectEquipStsList());
			model.addAttribute("actList", actCodeService.selectActCodeList());
			return "equip/equipInsert";
		}
		
		//등록 처리
//		@PostMapping("/equipInsert")
//		public String equipInsertProcess(EquipVO equipVO) {
//			equipService.insertEquipInfo(equipVO);
//			return  "redirect:EquipList";
//		}
		@PostMapping("/equipInsert")
		public String equipInsertProcess(EquipVO equipVO, RedirectAttributes rtt) {
			String result = equipService.insertEquipInfo(equipVO);
			System.out.println(result);
			rtt.addFlashAttribute("result", result);
			return  "redirect:equipInsert";
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
	@ResponseBody
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

	//설비검색조회
		@GetMapping("/searchEquip")
		@ResponseBody
		public List<EquipVO> SearchEquip(EquipVO equipVO) {
			List<EquipVO> vo = equipService.searchEquip(equipVO);
			return vo;
					
		}
		
	//ajax조회
	@GetMapping("/ajaxActCodeList2")
	@ResponseBody
	public List<ActCodeVO> ajaxActCodeList(){
		List<ActCodeVO> actList = actCodeService.selectActCodeList();
		return actList;
	}
		
	
}
