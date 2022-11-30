package com.mentor.mentee.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.mentor.mentee.domain.Study;
import com.mentor.mentee.mapper.StudyMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mentor.mentee.common.FileUploadUtil;
import com.mentor.mentee.dao.UserDao;
import com.mentor.mentee.domain.HomeWork;
import com.mentor.mentee.domain.HomeWorkInfo;
import com.mentor.mentee.mapper.HomeWorkMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class HomeWorkService {

    final UserDao userDao;
    final HomeWorkMapper homeWorkMapper;
    final StudyMapper studyMapper;
    final FileUploadUtil fileUploadUtil;

    public int uploadHomeWorkInfo(HomeWorkInfo homeWorkInfo) {
        return homeWorkMapper.uploadHomeWorkInfo(homeWorkInfo);
    }

    public List<HomeWork> getHomeWorkList(String user_id) {

        Study study = studyMapper.getStudyById(user_id);

        return homeWorkMapper.getHomeWorkList(study.getStudyNum());
    }

    public HomeWorkInfo getHomeWorkInfo(String userId) {
        String mentorId = userDao.getMentorId(userId);
        log.info("멘토 아이디 정보 호출 : "+mentorId);
        return homeWorkMapper.getHomeWorkInfo(mentorId);
    }

    public boolean checkHomeWork(String userId){
        String mentorId = userDao.getMentorId(userId);

        if(homeWorkMapper.checkHomeWork(mentorId) > 0)
            return true;

        return false;
    }

    public void homeWorkSubmit(HomeWork homeWork, MultipartFile[] uploadFiles) throws IllegalStateException, IOException{
        List<Map<String,String>> fileNameList = fileUploadUtil.saveFiles(uploadFiles);
        for(Map<String,String> nameMap : fileNameList) {
        	homeWork.setUuid(nameMap.get("uuid"));
            homeWork.setUploadPath(nameMap.get("filePath"));
            homeWork.setFilename(nameMap.get("orgFileName"));
        }
        log.info("HomeWork 업로드실행 : "+homeWork);
        homeWorkMapper.homeWorkSubmit(homeWork);
    }

    private String getFolder(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        log.info("저장경로 c:upload\\temp\\" + str.replace("-", File.separator));
        return str.replace("-", File.separator);

    }

    public int modifyHwInfo(HomeWorkInfo hwInfo) {
        return homeWorkMapper.modifyHwInfo(hwInfo);
    }

    public int deleteHwInfo(String hwInfoMentor) {
        int hwStudyNum = studyMapper.getStudyById(hwInfoMentor).getStudyNum();
        int result2 = homeWorkMapper.deleteHomeWorkAll(hwStudyNum);
        int result1 = homeWorkMapper.deleteHwInfo(hwInfoMentor);
        return result1 + result2;
    }

    public HomeWork getHomeWork(int hwStudyNum) {
        return homeWorkMapper.getHomeWork(hwStudyNum);
    }

    public int modifyHw(MultipartFile[] uploadFiles, HomeWork homeWork) throws IOException {
        if(uploadFiles!=null) {
            List<Map<String, String>> fileNameList = fileUploadUtil.saveFiles(uploadFiles);
            for (Map<String, String> nameMap : fileNameList) {
                homeWork.setUuid(nameMap.get("uuid"));
                homeWork.setUploadPath(nameMap.get("filePath"));
                homeWork.setFilename(nameMap.get("orgFileName"));
            }
        }else{
            homeWork.setUuid("");
            homeWork.setUploadPath("");
            homeWork.setFilename("");
        }
        log.info("HomeWork 업로드실행 : "+homeWork);

        return homeWorkMapper.modifyHw(homeWork);
    }

    public int deleteLoginUserHomeWork(String loginUserId) {
        return homeWorkMapper.deleteLoginUserHomeWork(loginUserId);
    }
}
