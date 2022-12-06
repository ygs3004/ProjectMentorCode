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

    int resetStudyNum(int studyNum);

    // Select studyINFO BY num
    Study getStudyByNum(int studyNum);

    // Select studyINFO BY user_id
    Study getStudyById(String userId);

    // Delete Room BY user_id
    int delStudyInfo(String userId);

    // select all list
    List<Study> getStudyList();

    //update nowcapacist +=1
    int updateCapacity(int num, int studyNum);

    String getMentorIdByNum(int studyNum);
}

