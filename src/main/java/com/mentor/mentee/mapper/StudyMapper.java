package com.mentor.mentee.mapper;

import com.mentor.mentee.domain.Study;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface StudyMapper {

    //Insert study
    int createStudy(Study study);

    // Update study
    int updateStudy(Study study);

    // Select studyINFO BY num
    Study getStudyByNum(int studyNum);

    // Select studyINFO BY user_id
    Study getStudyById(String userId);

    // Delete Room BY user_id
    int delStudyInfo(String userId);

    // select all list
    List<Study> getStudyList();

    String getMentorIdByNum(int studyNum);
}

