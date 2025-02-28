package kr.bit.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.config.RootConfig;
import kr.bit.mapper.BoardMapperTest;
import lombok.extern.log4j.Log4j;

@Log4j	
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = RootConfig.class)
public class BoardServiceTest {

	@Autowired
	BoardService boardService;
	
	@Test
	public void testGetList() {
	}
	
}
