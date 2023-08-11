package co.yedam.app.prcs.dir.service;

import java.util.List;



public interface PrcsDirService {
	//생산지시 조회
	public List<PrcsDirVO> getPrcsDirList();
	
	//상세생산지시 조회
	public List<PrcsDirVO> getPrcsDirDeList(String prcsDirCode);
	
	//생산지시 등록
	public String insertPrcsDir(PrcsDirVO prcsDirVo);
	
	//상세생산지시 등록
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO);
}
