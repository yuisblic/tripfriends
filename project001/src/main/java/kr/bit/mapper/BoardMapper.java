package kr.bit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Reply;

public interface BoardMapper {	
	
	public void register(Board vo);
	public List<Board> loadBest();
	public List<Board> loadCate(Criteria cri);
	public Board boardContent(int idx);
	
	@Update("update board_tbl set count=count+1 where idx=#{idx}")
	public void boardCount(int idx);
	
	@Update("update board_tbl set wish=wish+1 where idx=#{idx}")
	public void wishAdd(int idx);
	
	@Update("update board_tbl set wish= case When wish >0 Then wish-1 Else 0 End where idx=#{idx}")
	public void wishCancel(int idx);
	
	public List<Reply> loadReply(int post_id);
	public Reply read(int idx);
	public void replyUpdate(Reply r);
	public void reply(Reply r);
	public void replyAdd(Reply r);
	
	public int totalCount(Criteria cri);
	
	public void boardUpdate(Board vo);
	public void boardDel(int idx);
	
	@Update("update reply_tbl set content='삭제된 댓글입니다.' where idx=#{idx}")
	public void replyDel(int idx);
	
}
