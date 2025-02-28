package kr.bit.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.config.RootConfig;
import kr.bit.entity.Board;
import lombok.extern.log4j.Log4j;

@Log4j	
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = RootConfig.class)
public class BoardMapperTest {
	@Autowired
	BoardMapper boardMapper;
	
	@Test
	public void testInsert() {
		
	}
	
	
}
