package com.mentor.mentee.mapper;

import com.mentor.mentee.domain.HomeWork;
import com.mentor.mentee.domain.HomeWorkInfo;
import com.mentor.mentee.domain.Study;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface HomeWorkMapper {

    // 매퍼 테스트용
    @Select("select sysdate from dual")
    public String getTime();

    public int uploadHomeWorkInfo(HomeWorkInfo homeWorkInfo);

    public HomeWorkInfo getHomeWorkInfo(String mentorId);

    public int homeWorkSubmit(HomeWork homeWork);

    public int checkHomeWork(String mentorId);

    public List<HomeWork> getHomeWorkList(int hwStudyNum);

    public int modifyHwInfo(HomeWorkInfo hwInfo);

    public int deleteHwInfo(String hwInfoMentor);

    public HomeWork getHomeWork(int hwStudyNum);

    public int deleteHomeWorkAll(int hwStudyNum);

    public int modifyHw(HomeWork homeWork);

    public int deleteLoginUserHomeWork(String loginUserId);

    public List<HomeWork> getOldFiles();
}
