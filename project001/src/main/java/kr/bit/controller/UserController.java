package kr.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.bit.entity.Board;
import kr.bit.entity.MUser;
import kr.bit.entity.User;
import kr.bit.mapper.UserMapper;
import kr.bit.security.MUserDetailsService;
import kr.bit.service.UserService;

@RequestMapping("/user/*")
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MUserDetailsService mUserDetailsService;
	
	@Autowired
	PasswordEncoder pwEncoder;
	
	@Autowired
	UserMapper userMapper;
	
	
	@GetMapping("/signUp")
	public String signUp() {
		return "/user/signUp";
	}
	
	@GetMapping("/userCheck")
	public @ResponseBody int userCheck(@RequestParam("userId") String userId) {
		User u = userService.userCheck(userId);
		if(u!=null || userId.equals("")) {
			return 0;
		}
		return 1;
	}
	
	@PostMapping("/join")
	public String join(User vo, RedirectAttributes rttr) {
		System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁuserProfile="+vo.getUserProfile());
		String encyptPw = pwEncoder.encode(vo.getUserPw());
		vo.setUserPw(encyptPw);
		int result = userService.join(vo);
		if(result==1) {
			//회원가입 성공
			rttr.addFlashAttribute("msg","회원가입에 성공했습니다.");
			return "redirect:/user/login";
		}else {
			//회원가입 실패
			rttr.addFlashAttribute("msg","이미 존재하는 회원입니다.");
			return "redirect:/user/signUp";
		}
	}
	@GetMapping("/login")
	public String loginForm() {
		return "/user/login";
	}
	
	@GetMapping("/editPage")
	public String editPage() {
		return "/user/editPage";
	}
	
	@GetMapping("/modify")
	public String modifyForm() {
		return "/user/modify";
	}
	
	@PostMapping("/modify")
	public String modify(User u, RedirectAttributes rttr) {
		String encyptPw=pwEncoder.encode(u.getUserPw());	//입력받은 비밀번호를 암호화
		u.setUserPw(encyptPw);
		int result = userService.modify(u);
		if(result==1) {
			rttr.addFlashAttribute("msg","회원정보가 수정되었습니다.");
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			MUser userAccount = (MUser) authentication.getPrincipal();
			SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userAccount.getUser().getUserId()));
			User vo = userService.userCheck(u.getUserId());	
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msg","회원정보가 수정을 실패했습니다.");
			return "redirect:/user/modify";
		}
	}
	
	@GetMapping("/delete")
	public String deleteForm() {
		return "/user/delete";
	}
	
	@PostMapping("/delete")
	public String delete(User vo, HttpSession session, RedirectAttributes rttr) {
		userService.delete(vo);
		rttr.addFlashAttribute("msg","회원탈퇴가 정상적으로 처리되었습니다.");
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@GetMapping("/wishList")
	public String wishList(@AuthenticationPrincipal UserDetails userDetails, Model model) {
		String userId = userDetails.getUsername();
		List<Board> list = userService.loadWish(userId);
		model.addAttribute("wishList", list);
		return "/user/wishList";
	}
	
	//스프링 보안 = 새로운 세션 생성 메서드
	//기존 인증정보
	protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		//DB에서 이 username 회원에 해당하는 정보를 가지고 온다
		UserDetails newPrincipal = mUserDetailsService.loadUserByUsername(username);
		//새로운 인증정보를 만든다															//새로 바뀐 회원정보, 		기존의 인증정보		, 새로운 인증정보 
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		//새로운 세션 객체를 생성한다
		newAuth.setDetails(currentAuth.getDetails());	
		//만들어진 새로운 세션 객체를 다시 리턴받는다
		return newAuth;		
	}
	
	//스프링 시큐리티 서버 설정 중 잘못된 접근 시 띄울 url
	@GetMapping("/access-denied")
	public String showAccessDenied() {
		return "/access-denied";
	}
	
	
	@GetMapping("/profileForm")
	public String profileForm() {
		return "/user/profileForm";
	}
	
	// @PostMapping("/profileUpdate")
	// public String profileUpdate(MultipartHttpServletRequest mpRequest, HttpSession session , String userProfile, String userId)throws Exception {
//	         
//	         userProfile = fileUtil.updateImg(mpRequest); 
	// 
//	         User user = (User) session.getAttribute("login");
//	         
//	         userService.userProfileUpdate(userProfile, userId);
//	         
//	         user.setUserProfile(userProfile);
//	         session.setAttribute("login", user);
//	         
//	                 
//	         return "redirect:/";
//	     }

	@PostMapping("/profileUpdate")
	public String profileUpdate(@RequestParam("userProfile") MultipartFile file, 
	                            @RequestParam("userId") String userId,
	                            HttpServletRequest request,
	                            RedirectAttributes rttr) {
	    System.out.println("ㅁㅁㅁㅁㅁㅁㅁ프로필업데이트ㅁㅁㅁㅁㅁㅁㅁ");
	    if (file.isEmpty()) {
	        rttr.addFlashAttribute("msg", "파일을 선택해주세요.");
	        return "redirect:/user/profileForm";
	    }

	    try {
	        // 파일 저장 경로 설정
	        String uploadDir = request.getServletContext().getRealPath("/resources/images/upload/");
	        File uploadPath = new File(uploadDir);
	        if (!uploadPath.exists()) {
	            uploadPath.mkdirs();
	        }

	        // 파일 이름 생성 (중복 방지를 위해 UUID 사용)
	        String originalFilename = file.getOriginalFilename();
	        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	        String newFilename = UUID.randomUUID().toString() + fileExtension;

	        // 파일 저장
	        File destFile = new File(uploadPath, newFilename);
	        file.transferTo(destFile);

	        // 데이터베이스 업데이트
	        User user = userMapper.userCheck(userId);
	        if (user != null) {
	            user.setUserProfile(newFilename);
	            userMapper.userProfileUpdate(user);

	            // 세션 업데이트
	            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	            MUser userDetails = (MUser) auth.getPrincipal();
	            userDetails.getUser().setUserProfile(newFilename);

	            rttr.addFlashAttribute("msg", "프로필 사진이 성공적으로 업데이트되었습니다.");
	        } else {
	            rttr.addFlashAttribute("msg", "사용자를 찾을 수 없습니다.");
	        }
	    } catch (IOException e) {
	        rttr.addFlashAttribute("msg", "파일 업로드 중 오류가 발생했습니다.");
	        e.printStackTrace();
	    }

	    return "redirect:/";
	}



}
