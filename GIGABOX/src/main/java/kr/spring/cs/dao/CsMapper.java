package kr.spring.cs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.cs.vo.CategoryVO;
import kr.spring.cs.vo.CsPersonalVO;
import kr.spring.cs.vo.CsVO;
import kr.spring.cs.vo.FileVO;
import kr.spring.theater.vo.TheaterVO;

@Mapper
public interface CsMapper {
	//cs_qna_category 가져오기 
	@Select("SELECT * FROM cs_qna_category ORDER BY category_num ASC")
	public List<CategoryVO> selectAllQnaCategory();
	//cs_personal_category 가져오기
	@Select("SELECT * FROM cs_personal_category ORDER BY category_num ASC")
	public List<CategoryVO> selectAllPersonalCategory();
	//영화관 목록 가져오기
	@Select("SELECT * FROM theater ORDER BY th_num ASC")
	public List<TheaterVO> selectAllTheater();
	
	//디테일 보기
	@Select("SELECT * FROM cs_personal WHERE personal_num = #{personal_num}")
	public CsPersonalVO selectCsPersonal(Integer personal_num);
	
	@Update("UPDATE cs_personal SET state = 1 WHERE personal_num = #{personal_num}")
	public void updateState1(Integer personal_num);
	@Update("UPDATE cs_personal SET state = 0 WHERE personal_num = #{personal_num}")
	public void updateState0(Integer personal_num);
	
	@Update("UPDATE cs_personal SET title=#{title}, content=#{content}, modify_date=SYSDATE WHERE personal_num = #{personal_num}")
	public void updateCsPersonal(CsPersonalVO csPersonalVO);
	@Delete("DELETE FROM cs_personal WHERE personal_num = #{personal_num}")
	public void deleteCsPersonal(Integer personal_num);
	//파일 삭제
	@Delete("DELETE FROM cs_file WHERE personal_num = #{personal_num}")
	public void deleteCsFile(Integer personal_num);
	
	@Select("SELECT * FROM cs_answer WHERE personal_num = #{personal_num}")
	public CsPersonalVO selectCsAnswer(Integer personal_num);
	@Update("UPDATE cs_answer SET title=#{title}, content=#{content}, modify_date=SYSDATE WHERE personal_num = #{personal_num}")
	public void updateCsAnswer(CsPersonalVO csPersonalVO);
	@Delete("DELETE FROM cs_answer WHERE personal_num = #{personal_num}")
	public void deleteCsAnswer(Integer personal_num);
	
	
	@Select("SELECT cs_personal_seq.nextval FROM dual")
    public int selectPersonalNum();
	//글 작성하기(qna,noti공용) 
	public void insertCs(Map<String,Object> map);
	//글 작성하기 (personal용)
	public void insertPersonal(CsPersonalVO csPersonalVO);
	//글 보기
	//운영자 답변 작성하기
	public void insertAdminPersonal(CsPersonalVO csPersonalVO);
	
	//파일 검색
	@Select("SELECT * FROM cs_file WHERE personal_num = #{personal_num}")
	public List<FileVO> SelectNameList(Integer personal_num);
	//파일 선택
	@Select("SELECT * FROM cs_file WHERE file_num = #{file_num}")
	public FileVO selectFile(Integer File_num);
	//파일 업로드하기 
	public void saveAll(FileVO fileVO);
	
	//게시글 수 세기 (공용)
	public int selectRowCount(Map<String,Object> map);
	//qna 글 목록 가져오기
	public List<CsVO> selectQnaList(Map<String,Object> map);
	//noti 글 목록 가져오기
	public List<CsVO> selectNotiList(Map<String,Object> map);
	//personal 글 목록 가져오기 
	public List<CsPersonalVO> selectPersonalList(Map<String,Object> map);
	
	
	}
