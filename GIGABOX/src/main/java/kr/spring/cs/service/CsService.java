package kr.spring.cs.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;


import kr.spring.cs.vo.CategoryVO;
import kr.spring.cs.vo.CsPersonalVO;
import kr.spring.cs.vo.CsVO;
import kr.spring.cs.vo.FileVO;
import kr.spring.theater.vo.TheaterVO;


public interface CsService {
	
	//cs_qna_category 가져오기 
	public List<CategoryVO> selectAllQnaCategory();
	//cs_personal_category 가져오기
	public List<CategoryVO> selectAllPersonalCategory();
	//영화관 목록 가져오기
	public List<TheaterVO> selectAllTheater();
	//글작성하기 
	public void insertCs(Map<String,Object> map);
	//글 작성하기 (personal용)
	public void insertPersonal(CsPersonalVO csPersonalVO) throws IllegalStateException, IOException ;
	//운영자 답변 작성하기
	public void insertAdminPersonal(CsPersonalVO csPersonalVO);
	
	public List<FileVO> SelectNameList(Integer personal_num);
	public FileVO selectFile(Integer File_num);
	
	public CsPersonalVO selectCsPersonal(Integer personal_num);
	public void updateCsPersonal(CsPersonalVO csPersonalVO);
	public void deleteCsPersonal(Integer personal_num);
	
	public CsPersonalVO selectCsAnswer(Integer personal_num);
	public void updateCsAnswer(CsPersonalVO csPersonalVO);
	public void deleteCsAnswer(Integer personal_num);
	
	public void deleteCsFile(Integer personal_num);
	public void updateState1(Integer personal_num);
	public void updateState0(Integer personal_num);
	
	//글 목록 가져오기(.xml 작성) 
	public List<CsVO> selectQnaList(Map<String,Object> map);
	public List<CsVO> selectNotiList(Map<String,Object> map);
	public List<CsPersonalVO> selectPersonalList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
}
