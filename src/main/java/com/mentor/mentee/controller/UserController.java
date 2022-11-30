package com.mentor.mentee.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.mentor.mentee.domain.Study;
import com.mentor.mentee.domain.User;
import com.mentor.mentee.service.UserService;
import com.mentor.mentee.validator.UserValidator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Resource(name = "loginUserBean")
	private User loginUserBean;

	// 로그인
	@GetMapping("/login")
	public String login(@ModelAttribute("tempLoginUserBean") User tempLoginUserBean,
			@RequestParam(value = "fail", defaultValue = "false") boolean fail, Model model) {

		model.addAttribute("fail", fail);

		return "user/login";
	}

	@PostMapping("/login_pro")
	public String login_pro(@Valid @ModelAttribute("tempLoginUserBean") User tempLoginUser, BindingResult result) {
		log.info(tempLoginUser.toString());
		System.out.println("controller : " + tempLoginUser.getUserId());
		System.out.println("controller : " + tempLoginUser.getUserPw());
		System.out.println(result.getAllErrors().toString());

		if (result.hasErrors()) {
			return "user/login";

		}
		userService.getLoginUserInfo(tempLoginUser);

		if (loginUserBean.isUserLogin() == true) {
			log.info("로그인에 성공하셨습니다 : " + loginUserBean);
			return "user/login_success";
		} else {
			return "user/login_fail";
		}
	}

	// 회원 가입
	@GetMapping("/join")
	public String join(@ModelAttribute("joinUser") User joinUserBean) {
		return "user/join";
	}

	@PostMapping("/join_pro")
	public String join_pro(@Valid @ModelAttribute("joinUser") User joinUserBean, BindingResult result) {
		if (result.hasErrors()) {
			return "user/join";
		}
		userService.addUserInfo(joinUserBean);
		return "user/join_success";
	}

	// 회원 정보수정
	@GetMapping("/modify")
	public String modify(@ModelAttribute("modifyUserBean") User modifyUserBean) {

		userService.getModifyUserInfo(modifyUserBean);
		return "user/modify";
	}

	@PostMapping("/modify_pro")
	public String modify_pro(@Valid @ModelAttribute("modifyUserBean") User modifyUserBean, BindingResult result) {

		if (result.hasErrors()) {
			return "user/modify";
		}
		userService.modifyUserInfo(modifyUserBean);
		return "user/modify_success";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout() {
		loginUserBean.setUserLogin(false);
		return "user/logout";
	}

	// 로그인안했을경우
	@GetMapping("/not_login")
	public String not_login() {
		return "user/not_login";
	}

	// 회원 탈퇴
	@GetMapping("/delete")
	public String delete(@ModelAttribute("deleteUserBean") User deleteUserBean) {

		userService.getDeleteUserInfo(deleteUserBean);
		return "user/delete";
	}

	@PostMapping("/delete_pro")
	public String delete_pro(@Valid @ModelAttribute("deleteUserBean") User deleteUserBean, BindingResult result, Model model) {

		if (result.hasErrors()) {
			return "user/delete";
		}
		boolean isDelete = userService.deleteUserInfo(deleteUserBean);
		if(isDelete) {
			loginUserBean.setUserLogin(false);
		}
		model.addAttribute("isDelete", isDelete);
		return "user/delete_success";
	}

	// 회원 정보 리스트
	@GetMapping("/user_list")
	public String user_list(@ModelAttribute("userListBean") User userListBean, Model model) {

		userService.getUserList(userListBean);
		return "user/user_list";
	}

    // 회원정보관리 json
	/*
	 * @GetMapping("/userList") public @ResponseBody PageInfo<User> getUserList(User
	 * user) { return userService.getUserList(user); }
	 */
	
	/*
	 * @GetMapping("/userList") public String modify(@ModelAttribute("userListBean")
	 * User userListBean) {
	 * 
	 * userService.getModifyUserInfo(userListBean); return "user/user_list"; }
	 */
    
    
	/*
	 * @PostMapping("/delete-user") public @ResponseBody boolean
	 * deleteUser(@RequestBody User deleteUserBean) { return
	 * userService.deleteUserInfo(deleteUserBean); }
	 */
	 
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		UserValidator validator1 = new UserValidator(loginUserBean);
		binder.addValidators(validator1);
	}
}
