package com.mentor.mentee.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class FileUploadUtil {

	private static final String ROOT_PATH;
	static {
		String osName = System.getProperty("os.name");
		if(osName!=null) {
			//osName에 window가 포함되어 있을 경우는 window로 판단하여 폴더를 c부터 시작하게 한다.
			if(osName.toLowerCase().contains("window")) {
				ROOT_PATH = "c:\\upload\\temp\\";
			}else {
				//osName에 window가 포함되지 않았다는 얘기는 Linux로 판단한다.
				ROOT_PATH = "/var/files/";
			}			
		}else {
			ROOT_PATH = "";
		}
	}
	public static String getRootFolder() {
		return ROOT_PATH;
	}
    public String getFolder(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        log.info("저장경로 c:upload\\temp\\ 또는 /var/files" + str.replace("-", File.separator));
        return str.replace("-", File.separator);
    }
    
    public List<Map<String,String>> saveFiles(MultipartFile[] uploadFiles) throws IllegalStateException, IOException{
    	List<Map<String,String>> fileNameList = new ArrayList<>();
        for(MultipartFile uploadFile : uploadFiles){
            if(!uploadFile.isEmpty()) {
            	fileNameList.add(saveFile(uploadFile));
            }
        }
        return fileNameList;
    }
    
    public Map<String,String> saveFile(MultipartFile uploadFile) throws IllegalStateException, IOException {
    	String uploadFolderPath = getFolder(); // 년/월/일
    	Map<String,String>  result = new HashMap<>();
        // 폴더 생성
        File uploadPath = new File(ROOT_PATH, uploadFolderPath);
        if(!uploadPath.exists()){
            uploadPath.mkdirs();
        }
        String originalFileName = uploadFile.getOriginalFilename();
        result.put("orgFileName", originalFileName);
        log.info("==========================");
        log.info("upload File name :" + originalFileName);
        log.info("upload File Size : " + uploadFile.getSize());
        //IE는 파일 경로도 같이 전송되므로 잘라준다
        String uploadFileName = originalFileName.substring(originalFileName.lastIndexOf("\\")+1);
        // 중복 파일명 방지를 위한 난수
        UUID uuid = UUID.randomUUID();
        result.put("uuid", uuid.toString());
        uploadFileName = uuid.toString() + "_" + uploadFileName;
        File saveFile = new File(uploadPath, uploadFileName);
        uploadFile.transferTo(saveFile);
        result.put("filePath", saveFile.getAbsolutePath());
        return result;
    }
}
