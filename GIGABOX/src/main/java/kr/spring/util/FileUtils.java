package kr.spring.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import kr.spring.cs.vo.FileVO;

@Component
public class FileUtils {

	private final String uploadPath = Paths.get("C:", "Users","Hunter","Desktop","upload-files").toString();
	///파일이 저장되는 위치 설정. 후에 수정한다.
	//C:\Users\Hunter\Desktop
	public List<FileVO> uploadFiles(final List<MultipartFile> multipartFiles){
		List<FileVO> files = new ArrayList<>();
		
		for(MultipartFile multipartFile : multipartFiles) {
			if (multipartFile.isEmpty()) {
				continue;
			}
			
			files.add(uploadFile(multipartFile));
		}
		return files;
	}
	
	public FileVO uploadFile(final MultipartFile multipartFile) {
		if (multipartFile.isEmpty()) {
			return null;
		}
		
		String save_name = generateSaveFilename(multipartFile.getOriginalFilename());
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd")).toString();
		String uploadPath = getUploadPath(today) + File.separator + save_name;
		File uploadFile = new File(uploadPath);
		
		try {
			multipartFile.transferTo(uploadFile);
		}catch(IOException e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	private String generateSaveFilename(final String filename) {
		String uuid = UUID.randomUUID().toString().replace("-", "");
		String extension = StringUtils.getFilenameExtension(filename);
		return uuid + "." + extension;
	}
	

	
	private String getUploadPath(final String addPath) {
		return makeDirectories(uploadPath + File.separator + addPath);
	}
	
	private String makeDirectories(final String path) {
		File dir = new File(path);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
		return dir.getPath();
	}
}
