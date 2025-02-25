package kr.bit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.bit.entity.MUser;
import kr.bit.entity.User;
import kr.bit.service.UserService;

@Service
public class MUserDetailsService implements UserDetailsService{

	@Autowired
	private UserService userService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("***********username="+username+"***********");
		User mvo = userService.login(username);
		if(mvo != null) {
			return new MUser(mvo);
		}else {
			//아이디가 존재하지 않을 때 띄우는 예외 메시지
			throw new UsernameNotFoundException("User with username" +username+ "does not exist.");
		}
	}

}