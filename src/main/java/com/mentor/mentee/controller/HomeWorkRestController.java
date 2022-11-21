package com.mentor.mentee.controller;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

import com.mentor.mentee.domain.User;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.mentor.mentee.domain.HomeWork;
import com.mentor.mentee.domain.HomeWorkInfo;
import com.mentor.mentee.service.HomeWorkService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Slf4j
@RestController
@RequestMapping("/homework")
@RequiredArgsConstructor
public class HomeWorkRestController {

    final HomeWorkService homeWorkService;

    @GetMapping("/homeWorkList")
    @ResponseBody
    public ResponseEntity<List<HomeWork>> getHomeWorkList(String hwInfoMentor){
        List<HomeWork> hwList = homeWorkService.getHomeWorkList(hwInfoMentor);
        if(hwList!=null && !hwList.isEmpty()) {
            log.info(hwInfoMentor + "의 과제리스트 전달" + hwList.get(0));
        }else {
            log.info("등록된 과제리스트가 없습니다.");
        }

        return hwList.size() != 0
                ? new ResponseEntity<>(hwList, HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/getHomeWork")
    @ResponseBody
    public ResponseEntity<HomeWork> getHomeWork(String hwInfoMentor, int studyNum){

        HomeWork homeWork = homeWorkService.getHomeWork(studyNum);

        return homeWork != null
            ? new ResponseEntity<>(homeWork, HttpStatus.OK)
            : new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PatchMapping("/{hwInfoMentor}")
    @ResponseBody
    public ResponseEntity<String> modifyHwInfo(
            @RequestBody HomeWorkInfo hwInfo,
            @PathVariable String hwInfoMentor
            ){

        hwInfo.setHwInfoMentor(hwInfoMentor);
        log.info("확인 바람"+ hwInfo);
        int updateCount = homeWorkService.modifyHwInfo(hwInfo);

        return updateCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @DeleteMapping("/{hwInfoMentor}")
    @ResponseBody
    public ResponseEntity<String> modifyHwInfo(@PathVariable String hwInfoMentor){

        int deleteCount = homeWorkService.deleteHwInfo(hwInfoMentor);

        return deleteCount == 2 || deleteCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/modifyHw/{loginUserId}")
    @ResponseBody
    public ResponseEntity<String> modifyHw(
            @RequestParam HashMap<Object, Object> param,
            MultipartFile[] uploadFiles,
            @PathVariable String loginUserId) throws IOException {

        HomeWork homeWork = new HomeWork();

        homeWork.setHwContent((String) param.get("hwContent"));
        homeWork.setHwUserId(loginUserId);

        log.info("homework 되면 안되겠니?"+ homeWork);

        int updateContent = homeWorkService.modifyHw(uploadFiles, homeWork);

        return updateContent == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @DeleteMapping("/deleteHw/{loginUserId}")
    @ResponseBody
    public ResponseEntity<String> deleteHw(
            @PathVariable String loginUserId){

        int deleteCount = homeWorkService.deleteLoginUserHomeWork(loginUserId);

        return deleteCount == 2 || deleteCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }


    @GetMapping( value = "/downloadHw", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent")String userAgent, String filename){
        log.info("다운로드 첨부파일 : " + filename);

        Resource resource = new FileSystemResource(filename);

        if(!resource.exists()){
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        log.info("resource : "+resource);
        String resourceName = resource.getFilename();

        //다운로드 받은 사람의 파일이름 uuid 제거
        String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);

        HttpHeaders headers = new HttpHeaders();
        try{
            String downloadName = null;

            if(userAgent.contains("Trident")){
                log.info("IE browser 에서의 다운로드");
                downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", "");
            }else if(userAgent.contains("Edge")){
                log.info("Edge browser 에서의 다운로드");
                downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
            }else{
                log.info("Chrome browser에서의 다운로드");
                downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
            }

            headers.add("Content-Disposition", "attachment; filename=" + downloadName);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }

}
