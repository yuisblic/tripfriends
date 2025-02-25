package kr.bit.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kr.bit.service.BoardServiceTest;
import lombok.extern.log4j.Log4j;

@Log4j	
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})	//context:component-scan controller가 해당 위치에 있으므로 디렉토리가 두개 필요하여 추가해줌 
public class BoardControllerTest {
	
	@Autowired
	private WebApplicationContext ctx;	//Spring Container 메모리 공간
	
	private MockMvc mockMvc;	//가상의 MVC 환경을 만들어주는 역할
	
	@Before
	public void setup() {	
		//가상의 MVC환경이 만들어진다
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		//가상의 MVC환경에 test할 코드 작성
		// 요청 -> 리턴 -> 모델과 뷰를 가져오자 = 데이터와 jsp를 의미함
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView().getModelMap());
	}

}
