package com.mentor.mentee.mapper;

import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;

import java.util.List;

import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {

	// 아이디 중복 확인
    @Select("SELECT USER_ID " +
            "FROM USERS " +
            "WHERE USER_ID = #{userId}")
    String checkUserIdExist(String userId);

    // 이메일 중복 확인
    @Select("SELECT USER_EMAIL " +
            "FROM USERS " +
            "WHERE USER_EMAIL = #{userEmail}")
    String checkUserEmailExist(String userEmail);
    
    // 로그인 
    @Select("SELECT * FROM USERS WHERE USER_ID = #{userId} AND USER_PW = #{userPw}")
    User getLoginUserInfo(User tempLoginUserBean);
    
    // 정보 수정 회원 정보 
    @Select("SELECT USER_ID, USER_NAME FROM USERS WHERE USER_IDX = #{userIdx}")
    User getModifyUserInfo(int userIdx);
    
    // 회원 정보 수정
    @Update("UPDATE USERS SET USER_PW = #{userPw}, USER_PW2 = #{userPw2}, USER_EMAIL = #{userEmail}, USER_PHONE = #{userPhone} WHERE USER_IDX = #{userIdx}")
    void modifyUserInfo(User modifyUserBean);
    
    // 회원 가입
    @Insert("INSERT INTO USERS (USER_IDX, STUDY_NUM, USER_ROLE, USER_NAME, USER_ID, USER_PW, USER_PW2, USER_EMAIL, USER_PHONE, USER_GENDER, USER_SCHOOL) " + "VALUES (USER_IDX, 0, #{userRole}, #{userName}, #{userId}, #{userPw}, #{userPw2}, #{userEmail}, #{userPhone}, #{userGender}, #{userSchool})")
    void addUserInfo(User joinUserBean);
    
    // 아이디로 회원 정보 확인
    @Select("SELECT * FROM USERS WHERE USER_ID = #{userId}")
    User getUserInfo(String userId);

    // 매퍼 테스트용
    @Select("select sysdate from dual")
    public String getTime();

    // mentorRoom 생성 후 users에 mentorRoomNo update
    @Update("UPDATE USERS SET STUDY_NUM = #{studyNum} WHERE USER_ID = #{userId}")
    public int updateStudyNum(@Param("studyNum") int studyNum, @Param("userId") String userId);

    // 회원 탈퇴 회원 정보
    @Select("SELECT USER_ID, USER_NAME from USERS WHERE USER_IDX = #{userIdx}")
    User getDeleteUserInfo(int userIdx);;
    
    // 회원 탈퇴
    @Delete("DELETE FROM USERS WHERE USER_ID = #{userId} ")
    int deleteUserInfo(User deleteUserBean);
    
	
	  // select all list
	  
	  @Select("SELECT USER_IDX, STUDY_NUM, USER_ROLE, USER_NAME, USER_ID, USER_EMAIL, USER_PHONE, USER_GENDER, USER_SCHOOL FROM USERS"
	  ) List<User> getUserList(User userListBean);
	 
}

