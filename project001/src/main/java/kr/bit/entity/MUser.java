package kr.bit.entity;

import java.util.Collection;
import java.util.Collections;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class MUser extends User{	//UserDetails interface

	private kr.bit.entity.User user;
	
	public MUser(String username, String password, 
			  Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);	
	}
	
	public MUser(kr.bit.entity.User mvo) {
		super(mvo.getUserId(), mvo.getUserPw(),mapAuthorities());
		        this.user = mvo;
	}

    // 권한 정보를 SimpleGrantedAuthority 목록으로 반환하는 헬퍼 메서드
    private static Collection<? extends GrantedAuthority> mapAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));
    }
	

}
