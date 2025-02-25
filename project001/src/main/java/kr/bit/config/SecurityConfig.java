package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

import kr.bit.security.MUserDetailsService;

@Configuration
@ComponentScan(basePackages = {"kr.bit", "kr.bit.service"})
@EnableWebSecurity	
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Autowired
    private MUserDetailsService mUserDetailsService;
	 
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(mUserDetailsService).passwordEncoder(passwordEncoder());
		System.out.println("인증매니저 시작");
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
	    web.ignoring()
	       .antMatchers("/css/**", "/images/**", "/resources/**", "/favicon.ico");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class);
		
		http
			.authorizeRequests()
	            .antMatchers("/css/**", "/images/**", "/resources/**").permitAll()
	            .antMatchers("/").permitAll()
	            .antMatchers("/user/profileUpdate").authenticated()
				.and()			
			.formLogin()
				.loginPage("/user/login")
				.loginProcessingUrl("/login")
				.permitAll()
				.and()
			.logout()				
				.logoutUrl("/user/logout")
				.invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")
				.logoutSuccessUrl("/")
				.and()
			//로그인을 하지 않고 다른 화면에 접근하려고 할때 해당 페이지로 이동
			.exceptionHandling().accessDeniedPage("/access-denied");
				
	}
	
	//패스워드 인코딩해주는 객체
	@Bean
	public PasswordEncoder passwordEncoder() {	//평이한 패스워드를 암호화 코드로 바꿔준다
		return new BCryptPasswordEncoder();
	}
	
	//멀티파트
	@Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(5242880);  // 5MB
        return resolver;
    }
	
}
