package kr.bit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Reply;
import kr.bit.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
		
	@Autowired
	BoardMapper boardMapper;

	@Override
	public void register(Board vo) {
		boardMapper.register(vo);
	}

	@Override
	public List<Board> loadBest() {
		List<Board> list = boardMapper.loadBest();
		return list;
	}

	@Override
	public List<Board> loadCate(Criteria cri) {
		List<Board> list = boardMapper.loadCate(cri);
		return list;
	}

	@Override
	public Board boardContent(int idx) {
		Board b = boardMapper.boardContent(idx);
		return b;
	}

	@Override
	public void boardCount(int idx) {
		boardMapper.boardCount(idx);
	}

	@Override
	public void wishAdd(int idx) {
		boardMapper.wishAdd(idx);
	}

	@Override
	public void wishCancel(int idx) {
		boardMapper.wishCancel(idx);
	}

	@Override
	public List<Reply> loadReply(int post_id) {
		List<Reply> list = boardMapper.loadReply(post_id);
		return list;
	}

	@Override
	public void reply(Reply r) {
		boardMapper.reply(r);
	}

	@Override
	public void replyAdd(Reply r) {
		//원댓 가져오기
		Reply parent = boardMapper.read(r.getIdx());
		//원댓 post_id 값을 r에 저장
		r.setPost_id(parent.getPost_id());
		//원댓 ref 값을 r에 저장
		r.setRef(parent.getRef());
		//원댓 reStep 값 +1 -> r에 저장
		r.setReStep(parent.getReStep()+1);
		//원댓 reLevel 값 +1 -> r에 저장
		r.setReLevel(parent.getReLevel()+1);
		//같은 ref 중 원댓 reStep보다 큰 값은 모두 +1 씩 업데이트
		boardMapper.replyUpdate(parent);
		//댓글, 대댓글 저장
		boardMapper.replyAdd(r);
	}

	@Override
	public int totalCount(Criteria cri) {
		return boardMapper.totalCount(cri);
	}

	@Override
	public void boardUpdate(Board vo) {
		boardMapper.boardUpdate(vo);
	}

	@Override
	public void boardDel(int idx) {
		boardMapper.boardDel(idx);
	}

	@Override
	public void replyDel(int idx) {
		boardMapper.replyDel(idx);
	}

}
