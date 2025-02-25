package kr.bit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.bit.entity.Board;
import kr.bit.entity.User;
import kr.bit.entity.Wish;

@Mapper
public interface UserMapper {
	public User userCheck(String userId);
	public int join(User vo);
	public User login(String username);
	public int modify(User vo);
	public void delete(User vo);
	public Wish wishCheck(Wish wish);
	public void wish(Wish wish);
	public void wishDel(Wish wish);
	public List<Board> loadWish(String userId);
	public void userProfileUpdate(User user);
}
