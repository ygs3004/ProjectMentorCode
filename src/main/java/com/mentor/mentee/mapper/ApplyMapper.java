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

    List<Apply> getApproveList(String userId);

    List<Apply> getRefuseList(String userId);


    int refuseMentee(int applyNum);

    int checkApplyMsg(int studyNum, String userId);

    int getApproveTotal(String userId);

    List<Apply> getMsgList(String userId);

    int modifyMsg(String applyMsg, int applyNum);

    int deleteMsg(int applyNum);

    int deleteMsgById(String userId);
}

