package com.mentor.mentee.common;

import com.mentor.mentee.domain.HomeWork;
import com.mentor.mentee.mapper.HomeWorkMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.http.fileupload.FileUpload;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class FileCheckTask {

    final private HomeWorkMapper homeWorkMapper;

    private String getFolderYesterDay(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar cal = Calendar.getInstance();

        cal.add(Calendar.DATE, -1);

        String str = sdf.format(cal.getTime());

        return str.replace("-", File.separator);
    }

    //seconds minutes, hours, day, months, day of week, year(optional)
    @Scheduled(cron ="0 0 * * * *")
    public void checkFiles() throws Exception{
        log.warn("================스케쥴링 동작 확인==================");
        log.warn("현재 날짜 : " + new Date());

        List<HomeWork> fileList = homeWorkMapper.getOldFiles();
        if(fileList.isEmpty()) return;

        log.info(fileList.get(0).toString());
        List<Path> fileListPath = new ArrayList<>();

        for(HomeWork homeWork:  fileList){
            String[] paths = homeWork.getHwUploadPath().split(",");
            for(String path : paths){
                fileListPath.add(Paths.get(path));
                log.warn("DB에 저장되어 있는 파일들 : "+ path);
            }
        }

        File targetDir = Paths.get(FileUploadUtil.getRootFolder(), getFolderYesterDay()).toFile();
        log.info("target 폴더 : "+targetDir);

        File[] removeFiles = targetDir.listFiles(file -> !fileListPath.contains(file.toPath()));

        log.warn("------------------------------------------------");

        for(File file : removeFiles){
            log.warn("DB에 저장되어있지 않아 삭제됩니다."+file.getAbsolutePath());
            if(file.delete()) log.warn("삭제되었습니다.");
        }
    }

}
