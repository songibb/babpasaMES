package co.yedam.app.prcs.dir.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.service.PrcsDirReqVO;
import co.yedam.app.prcs.dir.service.PrcsDirService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.ing.service.PrcsIngService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;
// 20230821 백송이 - 생산 지시
@Controller
public class PrcsDirController {
	
	@Autowired
	PrcsDirService prcsDirService;
	
	@Autowired
	PrcsIngService prcsIngService;
	
	//생산지시 조회 - 페이지 호출
	@GetMapping("prcsDirList")
	public String getPrcsDirAllList(PrcsSearchVO prcsSearchVO, Model model) {
		model.addAttribute("dirList", prcsDirService.selectPrcsDirList(prcsSearchVO));
		return "process/prcsDirList";
	}
	
	//생산지시 조회 (아직 생산 완료 되지 않은 지시) - 리스트
	@GetMapping("selectPrcsDirList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirAllList(PrcsSearchVO prcsSearchVO) {
		List<PrcsDirVO> list = prcsDirService.selectPrcsDirList(prcsSearchVO);
		return list;
	}
	
	//생산지시 조회 (생산 완료된 지시) - 리스트
	@GetMapping("selectPrcsEndDirList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsEndDirList(PrcsSearchVO prcsSearchVO) {
		List<PrcsDirVO> list = prcsDirService.selectPrcsEndDirList(prcsSearchVO);
		return list;
	}
	
	//상세생산지시 조회
	@GetMapping("prcsDirDeList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirDeList(@RequestParam String prcsDirCode){
		List<PrcsDirVO> list = prcsDirService.selectPrcsDirDeList(prcsDirCode);
		return list;
	}
	
	
	//생산지시 + 상세생산지시 등록 - 페이지 호출
	@GetMapping("prcsDirInsert")
	public String getPrcsDirInsert() {	
		return "process/prcsDirInsert";
	}
	
	//생산지시 등록
	@PostMapping("prcsDirInsert")
	@ResponseBody
//	public String prcsDirInsert(@RequestBody PrcsDirVO prcsDirVO) { 
//		//selectKey값 가져오기
//		String prcsDirCode = prcsDirService.insertPrcsDir(prcsDirVO);
//		return prcsDirCode;
//	}
	public int prcsDirInsert(@RequestBody PrcsDirReqVO prcsDirReqVO) {
		return prcsDirService.insertPrcsDir(prcsDirReqVO);
	}
	
	
	//상세생산지시 등록
//	@PostMapping("prcsDirDeInsert")
//	@ResponseBody
//	public int prcsDirDeInsert(@RequestBody List<PrcsDirVO> list) {				
//		return prcsDirService.insertPrcsDirDe(list);
//	}
	
	
	//미지시 생산계획 조회
	@GetMapping("notDirPlanList")
	@ResponseBody
	public List<PrcsPlanVO> getNotDirPlanList(){
		List<PrcsPlanVO> list = prcsDirService.selectNotDirPlanList();
		return list;
	}
	
	//미지시 상세생산계획 조회
	@GetMapping("notDirPlanDeList")
	@ResponseBody
	public List<PrcsPlanVO> getNotDirPlanDeList(String prcsPlanCode){
		List<PrcsPlanVO> list = prcsDirService.selectNotDirPlanDeList(prcsPlanCode);
		return list;
	}
	
	

	//BOM 조회
	@GetMapping("bomList")
	@ResponseBody
	public List<BomCodeVO> getBomList(@RequestParam String prodCode, @RequestParam Integer prcsDirAmt){
		List<BomCodeVO> list = prcsDirService.selectBomList(prodCode, prcsDirAmt);
		return list;
	}
	
	//진행공정 모두 공정완료시 생산지시 수정
	@PostMapping("updateDirPrcsSts")
	@ResponseBody
	public int updateDirPrcsSts(@RequestBody List<PrcsDirVO> dirList) {
		return prcsDirService.updateDirPrcsSts(dirList);
	}
	
	
	//재지시 등록 - 완제품 (상세생산지시)
	@PostMapping("insertReDirDe")
	@ResponseBody
	public int insertReDirDe(@RequestBody List<PrcsDirVO> reDirList){
		return prcsDirService.insertReDirDe(reDirList);
	}
	
	//재지시 등록 - 반제품 (상세생산지시)
	@PostMapping("insertReDirDeSemi")
	@ResponseBody
	public int insertReDirDeSemi(@RequestBody PrcsDirVO prcsDirVO){
		return prcsDirService.insertReDirDeSemi(prcsDirVO);
	}
	
	
	
}
