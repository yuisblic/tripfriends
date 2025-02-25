package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.User;
import kr.bit.entity.Wish;
import kr.bit.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;
	
	@Override
	public User userCheck(String userId) {
		User u = userMapper.userCheck(userId);
		return u;
	}

	@Override
	public int join(User vo) {
		int result = userMapper.join(vo);
		return result;
	}

	@Override
	public User login(String username) {
		User u = userMapper.login(username);
		return u;
	}

	@Override
	public int modify(User vo) {
		int result = userMapper.modify(vo);
		return result;
	}

	@Override
	public void delete(User vo) {
		userMapper.delete(vo);
	}

	@Override
	public Wish wishCheck(Wish wish) {
		Wish w = userMapper.wishCheck(wish);
		return w;
	}

	@Override
	public void wish(Wish wish) {
		userMapper.wish(wish);
	}

	@Override
	public void wishDel(Wish wish) {
		userMapper.wishDel(wish);
	}

	@Override
	public List<Board> loadWish(String userId) {
		List<Board> list = userMapper.loadWish(userId);
		return list;
	}

	@Override
	public void userProfileUpdate(User user) {
		userMapper.userProfileUpdate(user);
	}

}
