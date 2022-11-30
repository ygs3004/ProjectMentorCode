package com.mentor.mentee.mapper;

import com.mentor.mentee.domain.Apply;
import com.mentor.mentee.domain.Study;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ApplyMapper {

    //Insert apply
    int insertApply(Apply apply);

    List<Apply> getApplyList(String userId);

    int approveMentee(int applyNum);

    int refuseMentee(int applyNum);

    int checkApplyMsg(int studyNum, String userId);
}

