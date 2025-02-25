package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Reply;

public interface BoardService {

	public void register(Board vo);
	public List<Board> loadBest();
	public List<Board> loadCate(Criteria cri);
	public Board boardContent(int idx);
	public void boardCount(int idx);
	public void wishAdd(int idx);
	public void wishCancel(int idx);
	
	public void reply(Reply r);
	public void replyAdd(Reply r);
	public List<Reply> loadReply(int post_id);
	
	public int totalCount(Criteria cri);
	
	public void boardUpdate(Board vo);
	public void boardDel(int idx);
	
	public void replyDel(int idx);
}
