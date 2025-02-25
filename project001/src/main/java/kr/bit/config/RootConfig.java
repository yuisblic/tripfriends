package kr.bit.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@ComponentScan(basePackages = {"kr.bit", "kr.bit.service"})
@MapperScan(basePackages = {"kr.bit.mapper"})
@PropertySource({ "classpath:persistence-mysql.properties"})	//property 파일을 가져온 경우
public class RootConfig {
	
	 @Autowired
	 private Environment env;	//property 파일의 값을 읽어오기 위해 Environment 클래스가 필요하다
	 
	 @Bean	
	 //@PropertySource를 가져왔으므로
	 public DataSource myDataSource() {
		 HikariConfig hikariConfig=new HikariConfig();
		 hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		 hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		 hikariConfig.setUsername(env.getProperty("jdbc.user"));
		 hikariConfig.setPassword(env.getProperty("jdbc.password"));
		 HikariDataSource myDataSource=new HikariDataSource(hikariConfig);
		 return myDataSource;
	 }
	 
	 //Hikari 데이터 소스와 연결하여 CP 커넥션풀 생성
	 @Bean
	 public SqlSessionFactory sessionFactory() throws Exception{
		 SqlSessionFactoryBean sessionFactory=new SqlSessionFactoryBean();	//myDataSource을 받는다
		 sessionFactory.setDataSource(myDataSource());
		 return (SqlSessionFactory)sessionFactory.getObject();
	 }
 }