package kr.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.PageMaker;
import kr.bit.entity.Reply;
import kr.bit.entity.Wish;
import kr.bit.mapper.BoardMapper;
import kr.bit.service.BoardService;
import kr.bit.service.UserService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/register")
	public String registerForm() {
		return "/board/register";
	}
	
	@PostMapping("/register")
	public String register(Board vo, RedirectAttributes rttr) {
		boardService.register(vo);
		rttr.addFlashAttribute("msg","게시글이 등록되었습니다.");
		return "redirect:/";
	}
	
	@GetMapping("/content")
	public String content(@RequestParam("idx") int idx, Model model) {
		boardService.boardCount(idx);
		Board b = boardService.boardContent(idx);
		model.addAttribute("b",b);
		model.addAttribute("cate", b.getCategori());  // 현재 카테고리
		return "board/content";
	}
	
	@RequestMapping("/cate")
    public String getBoardList(@RequestParam(value = "cate", required = false, defaultValue = "") String cate,
    						   @RequestParam(value = "type", required = false, defaultValue = "") String type,
    						   @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
                               @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                               @RequestParam(value = "perPageNum", required = false, defaultValue = "10") int perPageNum,
                               Model model) {

        Criteria cri = new Criteria();
        cri.setCate(cate);
        cri.setType(type);
        cri.setKeyword(keyword);
        cri.setPage(page);
        cri.setPerPageNum(perPageNum);

        // 게시판 목록을 가져옵니다.
        List<Board> boardList = boardService.loadCate(cri);

        // 페이징 정보 생성
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(boardService.totalCount(cri));

        model.addAttribute("list", boardList);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("cate", cate);  // 현재 카테고리

        return "board/list";  // JSP 뷰 이름
    }
	
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model) {
		
		Board b = boardService.boardContent(idx);
		model.addAttribute("b",b);
		return "board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(Board b, RedirectAttributes rttr) {
		System.out.println("idx="+b.getIdx());
		System.out.println("title="+b.getTitle());
		System.out.println("content="+b.getContent());
		
		boardService.boardUpdate(b);
		rttr.addFlashAttribute("msg","게시글을 수정하였습니다.");
		return "redirect:/";
	}
	
	@GetMapping("/delete")
	public String boardDel(@RequestParam("idx") int idx, RedirectAttributes rttr) {
		boardService.boardDel(idx);
		rttr.addFlashAttribute("msg", "게시물을 삭제하였습니다.");
		return "redirect:/";
	}
	
	@Autowired
	private WebApplicationContext context;
	
	@PostMapping("/imageUpload")
	public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file) throws IllegalStateException, IOException {
	    System.out.println("!!이미지 업로드 컨트롤러!!");

	    // 서버의 실제 경로를 구합니다.
	    String uploadDirectory = context.getServletContext().getRealPath("/resources/images/upload");
	    System.out.println(uploadDirectory);
	    File directory = new File(uploadDirectory);
	    if (!directory.exists()) {
	        directory.mkdirs();  // 폴더가 없으면 생성
	    }

	    // 업로드 된 파일의 이름
	    String originalFileName = file.getOriginalFilename();
	    
	    // 파일 확장자 추출
	    String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	    
	    // UUID로 파일 이름 생성 (중복 방지)
	    String uuidFileName = UUID.randomUUID().toString() + fileExtension;
	    
	    // 실제 디렉터리에 파일을 저장
	    file.transferTo(new File(uploadDirectory, uuidFileName));
	    
	    // 업로드된 파일의 상대 경로를 반환
	    String fileUrl = "/resources/images/upload/" + uuidFileName;
	    
	    System.out.println("************************ 업로드 완료 ************************");
	    System.out.println("업로드 경로: " + uploadDirectory);
	    
	    // Ajax에서 업로드된 파일 이름을 응답으로 전달
	    return ResponseEntity.ok(fileUrl);
	}


	
}
