package co.yedam.app.prcs.dir.service;

import java.util.List;

import lombok.Data;

@Data
public class PrcsDirReqVO {
	PrcsDirVO prcsDirVO;
	List<PrcsDirVO> insertList;
}
