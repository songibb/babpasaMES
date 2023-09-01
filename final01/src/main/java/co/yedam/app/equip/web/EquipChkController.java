package co.yedam.app.equip.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;
import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.equip.service.EquipChkService;
import co.yedam.app.equip.service.EquipChkVO;
import co.yedam.app.sales.out.service.OutVO;

//장서영 - 설비 점검

@Controller
public class EquipChkController {

	@Autowired
	EquipChkService equipChkService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	@Autowired
	CommCodeService commCodeService;
	
	//전체 점검설비
	@GetMapping("equipchkList")
	public String getEquipChkList(Model model) {
		model.addAttribute("equipchkList",equipChkService.getEquipChkList());
		model.addAttribute("equipPassType", commCodeService.searchCommCodeUse("0N"));
		model.addAttribute("equipTypeChk", commCodeService.searchCommCodeUse("EQUIP-TYPE"));
		return "equip/equipchkList";
	}
	
	//AJAX
	@GetMapping("selectEquipChkList") 
	@ResponseBody
	public List<EquipChkVO> getEquipChkAllList(){
		List<EquipChkVO> list = equipChkService.getEquipChkList();
		return list;
	}
	
	/*
	 * //점검 설비 등록
	 * 
	 * @PostMapping("insertChkEquip")
	 * 
	 * @ResponseBody public int insertChkEquip(@RequestBody GridVO<EquipChkVO> data)
	 * { return equipChkService.modifyEquipChk(data); }
	 */
	
	//점검 설비 수정 - 사용 x
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
	
	//검사 페이지
	@GetMapping("/equipchkInsert")
	public String selectChkEquipList(Model model) {
		model.addAttribute("equipchkInsert", equipChkService.LetChkEquipList());
		model.addAttribute("equipPassType", commCodeService.searchCommCodeUse("0N"));;
		return "equip/equipchkInsert";
	}
	
	// 곧 점검할 설비 목록 - 왼쪽 그리드 (ajax 조회)
	@GetMapping("/letChkEquip")
	@ResponseBody
	public List<EquipChkVO> selectLetChkEquipList(){
		List<EquipChkVO> letChklist = equipChkService.LetChkEquipList();
		return letChklist;
	}
	
	//해당 설비 별 설비검사/조회 (상세 그리드)
	@GetMapping("/ajaxletChkInfoEquip")
	@ResponseBody
	public List<EquipChkVO> ajaxletChkInfoEquip(@RequestParam String eqCode){
		List<EquipChkVO> vo = equipChkService.selectLetChkEquipInfo(eqCode);
		return vo;
	}
	
	//상세 점검 설비 등록(저장버튼)
	@PostMapping("/insertChkEquip")
	@ResponseBody
	public int insertInfoChkEquip(@RequestBody GridVO<EquipChkVO> data ) {
		return equipChkService.modifyEquipChk(data);
	}
	
	//모달 : 사원 목록
		@GetMapping("empCodeList") 
		@ResponseBody
		public List<EmpInfoVO> empCodeList(){
			List<EmpInfoVO> list = empInfoService.selectEmpInfoList();
			return list;
		}
		
	// 검색 ajax
	@GetMapping("/searchChkEquip")
	@ResponseBody
	public List<EquipChkVO> outListFilter(@RequestParam(value = "startDate", required = false) String startDate
									, @RequestParam(value = "endDate", required = false) String endDate
									, @RequestParam(value = "eqName", required = false) String eqName
									, @RequestParam(value="before", required=false) String before 
									, @RequestParam(value="comple", required=false) String comple) {
		List<EquipChkVO> vo = equipChkService.searchChkEquip(startDate, startDate, eqName, before, comple);
		return vo;
	}
}