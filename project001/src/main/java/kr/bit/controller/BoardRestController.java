package kr.bit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;
import kr.bit.entity.Reply;
import kr.bit.entity.Wish;
import kr.bit.service.BoardService;
import kr.bit.service.UserService;

@Controller
@ResponseBody
@RequestMapping("/board/*")
public class BoardRestController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/best")
	public List<Board> loadBest() {
		List<Board> list = boardService.loadBest();
		return list;
	}
	
	@PutMapping("/count/{idx}")
	public void boardCount(@PathVariable("idx") int idx) {
		boardService.boardCount(idx);
		Board b = boardService.boardContent(idx);
	}
	
	@GetMapping("/replylist")
	public List<Reply> loadReply(@RequestParam("post_id") int post_id){
		List<Reply> list = boardService.loadReply(post_id);
		return list;
	}

	@PostMapping("/reply")
	public List<Reply> reply(@AuthenticationPrincipal UserDetails userDetails, @RequestParam("post_id") int post_id, @RequestParam("content") String content){
		String userId = userDetails.getUsername();
		Reply r = new Reply();
		r.setUserId(userId);
		r.setPost_id(post_id);
		r.setContent(content);
		boardService.reply(r);
		
		List<Reply> list = boardService.loadReply(post_id);
		
		return list;
	}
	
	@PostMapping("/replyAdd")
	public List<Reply> replyAdd(@AuthenticationPrincipal UserDetails userDetails, @RequestParam("idx") int idx, @RequestParam("content") String content) {
		String userId = userDetails.getUsername();
		Reply r = new Reply();
		r.setUserId(userId);
		r.setIdx(idx);
		r.setContent(content);
		boardService.replyAdd(r);
		
		List<Reply> list = boardService.loadReply(r.getPost_id());
		return list;
	}
	
	@PutMapping("/wish/{idx}")
	public Board boardWish(@PathVariable("idx") int idx, @AuthenticationPrincipal UserDetails userDetails) {
		//Wish 값 세팅하기
		Board b = boardService.boardContent(idx);
		String userId = userDetails.getUsername();
		Wish wish = new Wish();
		wish.setUserId(userId);
		wish.setIdx(idx);
		wish.setWriterId(b.getUserId());
		
		//찜을 이미 했다면 1, 아니면 0
		Wish w = userService.wishCheck(wish);
		if(w==null || w.equals("")) {
			//찜수 올리기
			boardService.wishAdd(idx);
			//찜목록에 추가하기
			userService.wish(wish);
		}else {
			//찜수 내리기
			boardService.wishCancel(idx);
			//찜목록에서 삭제하기
			userService.wishDel(wish);
		}
		//wish수가 반영된 b
		b = boardService.boardContent(idx);
		return b;
	}
	
	@GetMapping("/replyDelete")
	public void replyDel(@RequestParam("idx") int idx) {
		boardService.replyDel(idx);
	}
	
}





