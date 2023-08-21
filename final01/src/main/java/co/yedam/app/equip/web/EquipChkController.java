package co.yedam.app.equip.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;
import co.yedam.app.equip.service.EquipChkService;
import co.yedam.app.equip.service.EquipChkVO;

//장서영 - 설비 점검

@Controller
public class EquipChkController {

	@Autowired
	EquipChkService equipChkService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	
	//전체 점검설비
	@GetMapping("equipchkList")
	public String getEquipChkList(Model model) {
		model.addAttribute("equipchkList",equipChkService.getEquipChkList());
		return "equip/equipchkList";
	}
	
	//AJAX
	@GetMapping("selectEquipChkList") 
	@ResponseBody
	public List<EquipChkVO> getEquipChkAllList(){
		List<EquipChkVO> list = equipChkService.getEquipChkList();
		return list;
	}
	
	//점검 설비 수정
	@PostMapping("updateChkEquip")
	@ResponseBody
	public int updateChkEquip(@RequestBody List<EquipChkVO> list) {
		int result = 0;
		for(EquipChkVO vo : list) {
			equipChkService.updateChkEquip(vo);
			result++;
		}
		return result;
	}
	
	/*
	 * //모달 : 사원 조회
	 * 
	 * @GetMapping("/equipCodeList") public String empList(Model model) {
	 * model.addAttribute("empCodeList", equipChkService.selectEmpList());
	 * 
	 * return "equip/equipchkList"; }
	 */
	
	//AJAX
		@GetMapping("empCodeList") 
		@ResponseBody
		public List<EmpInfoVO> empCodeList(){
			List<EmpInfoVO> list = empInfoService.selectEmpInfoList();
			return list;
		}
}