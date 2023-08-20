package kr.spring.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUtil {
	@Value("${file.upload}")
	public static String PATH;

	public static byte[] getBytes(String path) {
		
		FileInputStream fis = null;
		byte[] readbyte = null;
		try {
			fis = new FileInputStream(path);
			readbyte = new byte[fis.available()]; 
			fis.read(readbyte);
		} catch (Exception e) {
			log.error(e.toString());
		}finally {
			if(fis!=null)try {fis.close();}catch(IOException e) {}
		}
		return readbyte;
	}
	
	public static String generateSaveFilename(String origin_name) {
		String uuid = UUID.randomUUID().toString().replace("-", "");
		String extension = StringUtils.getFilenameExtension(origin_name);
		return uuid + "." + extension;
	}
}
