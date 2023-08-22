package kr.spring.cs.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.spring.cs.dao.CsMapper;
import kr.spring.cs.vo.CategoryVO;
import kr.spring.cs.vo.CsPersonalVO;
import kr.spring.cs.vo.CsVO;
import kr.spring.cs.vo.FileVO;
import kr.spring.theater.vo.TheaterVO;
import kr.spring.util.FileUtil;

@Service
@Transactional
public class CsServiceImpl implements CsService{
	
	@Autowired
	CsMapper csMapper;
	
	@Override
	public List<TheaterVO> selectAllTheater() {
		return csMapper.selectAllTheater();
	}

	@Override
	public List<CategoryVO> selectAllQnaCategory() {
		return csMapper.selectAllQnaCategory();
	}
	
	@Override
	public List<CategoryVO> selectAllPersonalCategory() {
		return csMapper.selectAllPersonalCategory();
	}

	@Override
	public void insertCs(Map<String, Object> map) {
		csMapper.insertCs(map);
	}

	@Override
	public List<CsVO> selectQnaList(Map<String, Object> map) {
		return csMapper.selectQnaList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return csMapper.selectRowCount(map);
	}

	@Override
	public List<CsVO> selectNotiList(Map<String, Object> map) {
		return csMapper.selectNotiList(map);
	}

	@Override
	public void insertPersonal(CsPersonalVO csPersonalVO) throws IllegalStateException, IOException {
		csPersonalVO.setPersonal_num(csMapper.selectPersonalNum());
		csMapper.insertPersonal(csPersonalVO);
		
		 if (csPersonalVO.getFiles().length != 0) {
			 for(MultipartFile m : csPersonalVO.getFiles()) {
					
				 if(m.isEmpty()) {
						return;
					}
				 
					FileVO file = new FileVO();
					
					file.setPersonal_num(csPersonalVO.getPersonal_num());
					file.setOrigin_name(m.getOriginalFilename());
					file.setSave_name(FileUtil.generateSaveFilename(m.getOriginalFilename()));
					file.setFile_size(m.getSize());
					 
					m.transferTo(new File("C:\\Users\\Hunter\\git\\GIGABOX\\GIGABOX\\src\\main\\webapp\\image_upload\\cs\\"+file.getSave_name()));
				
					csMapper.saveAll(file);
	        }
		
		}
		
	}

	@Override
	public void insertAdminPersonal(CsPersonalVO csPersonalVO) {
		csMapper.insertAdminPersonal(csPersonalVO);
		
	}

	@Override
	public List<CsPersonalVO> selectPersonalList(Map<String, Object> map) {
		return csMapper.selectPersonalList(map);
	}


	@Override
	public CsPersonalVO selectCsPersonal(Integer personal_num) {
		return csMapper.selectCsPersonal(personal_num);
	}

	@Override
	public CsPersonalVO selectCsAnswer(Integer personal_num) {
		return csMapper.selectCsAnswer(personal_num);
	}

	@Override
	public void updateCsPersonal(CsPersonalVO csPersonalVO) {
		csMapper.updateCsPersonal(csPersonalVO);
		
	}

	@Override
	public void deleteCsPersonal(Integer personal_num) {
		csMapper.deleteCsPersonal(personal_num);
		
	}

	@Override
	public void updateCsAnswer(CsPersonalVO csPersonalVO) {
		csMapper.updateCsAnswer(csPersonalVO);
		
	}

	@Override
	public void deleteCsAnswer(Integer personal_num) {
		csMapper.deleteCsAnswer(personal_num);
		
	}

	@Override
	public void deleteCsFile(Integer personal_num) {
		csMapper.deleteCsFile(personal_num);
	}

	@Override
	public void updateState1(Integer personal_num) {
		csMapper.updateState1(personal_num);
		
	}

	@Override
	public void updateState0(Integer personal_num) {
		csMapper.updateState0(personal_num);		
	}

	@Override
	public List<FileVO> SelectNameList(Integer personal_num) {
	
		return csMapper.SelectNameList(personal_num);
	}

	@Override
	public FileVO selectFile(Integer File_num) {
		
		return csMapper.selectFile(File_num);
	}

	@Override
	public CsVO selectQna(Integer qna_num) {
		return csMapper.selectQna(qna_num);
	}

	@Override
	public CsVO selectNoti(Integer noti_num) {
		return csMapper.selectNoti(noti_num);
	}

	@Override
	public void deleteQna(Integer qna_num) {
		csMapper.deleteQna(qna_num);
	}

	@Override
	public void deleteNoti(Integer noti_num) {
		csMapper.deleteNoti(noti_num);
		
	}

	@Override
	public void updateQna(CsVO csVO) {
		csMapper.updateQna(csVO);
	}

	@Override
	public void updateNoti(CsVO csvVO) {
		csMapper.updateNoti(csvVO);
	}

	
}
