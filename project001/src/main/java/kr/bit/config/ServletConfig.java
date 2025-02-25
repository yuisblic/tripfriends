package kr.bit.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"kr.bit.controller"})	//포조를 자동으로 메모리 스프링 컨테이너에 객체를 올리는 빈

public class ServletConfig implements WebMvcConfigurer {
//servlet-context.xml 을 대신하는 config 파일
	
	//viewResolver 역할
	 @Override
	 public void configureViewResolvers(ViewResolverRegistry registry) {
		 InternalResourceViewResolver bean=new InternalResourceViewResolver();
		 bean.setPrefix("/WEB-INF/views/");
		 bean.setSuffix(".jsp");
		 registry.viewResolver(bean);
	 }
	 
	 //resource 파일 관리
	 @Override
	 public void addResourceHandlers(ResourceHandlerRegistry registry) {
		 registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	 }
	 
	 @Bean
	 public MultipartResolver multipartResolver() {
	     StandardServletMultipartResolver resolver = new StandardServletMultipartResolver();
	     return resolver;
	 }


}
