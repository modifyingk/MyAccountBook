package com.modifyk.accountbook.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class BoardController {
	@Autowired
	BoardDAO bDao;
	
	// 글 작성
	@RequestMapping("board/insertBoard")
	public String insertBoard(BoardVO boardVO) {
		// 익명여부 null인 경우 x 값 넣어주기
		if(boardVO.getIsanony() == null) {
			boardVO.setIsanony("x");
		}
		// 글 작성
		bDao.insertBoard(boardVO);
		int bno = boardVO.getBno(); // 글 작성 후 auto increment 되는 bno값 받아오기
		
		List<FileVO> file = boardVO.getFileList();
		
		// 첨부파일이 있는 경우
		if(file != null) {
			for(int i = 0; i < file.size(); i++) {
				file.get(i).setBno(bno); // 첨부파일에 해당하는 글의 bno 값 setting
				bDao.insertFile(file.get(i)); // 파일 정보 insert
			}
		}
		
		return "redirect:/board/board.jsp";
	}
	
	// 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	// 이미지 파일 판단
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 파일 업로드
	@ResponseBody
	@RequestMapping("board/uploadFile")
	public ResponseEntity<List<FileVO>> uploadFile(MultipartFile[] filename) {
		
		List<FileVO> list = new ArrayList<FileVO>();
		String uploadFolder = "C:\\MyAccountBook\\AccountBook\\src\\main\\webapp\\resources\\upload";
		
		// 년/월/일 폴더 생성
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : filename) {
			FileVO fileVO = new FileVO();

			// 파일명
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			fileVO.setFilename(uploadFileName);
			
			// 파일명 중복 방지
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				fileVO.setUuid(uuid.toString());
				fileVO.setUploadpath(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					fileVO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					thumbnail.close();
				}
				list.add(fileVO);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	// 파일 섬네일 보여주기
	@RequestMapping("board/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String filename) {
		File file = new File("C:\\MyAccountBook\\AccountBook\\src\\main\\webapp\\resources\\upload\\" + filename);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 업로드 파일 삭제
	@RequestMapping("board/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String filename, String type) {
		File file;
		try {
			file = new File("C:\\MyAccountBook\\AccountBook\\src\\main\\webapp\\resources\\upload\\" + URLDecoder.decode(filename, "UTF-8"));
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				file = new File(largeFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	// 게시물 목록
	@ResponseBody
	@RequestMapping("board/selectBoard")
	public List<BoardVO> selectBoard(int currentPage) {
		PageVO pageVO = new PageVO(10, currentPage);
		return bDao.selectBoard(pageVO);
	}
	
	// 게시물 수에 따른 페이지 수
	@ResponseBody
	@RequestMapping("board/countBoard")
	public PageVO2 countBoard(int showPage) {
		int totalBoard = bDao.countBoard();
		PageVO2 pageVO2 = new PageVO2(totalBoard, showPage);
		return pageVO2;
	}
	
	// 게시물 내용
	@RequestMapping("board/boardInfo")
	public String boardInfo(int bno, Model model) {
		BoardVO board = bDao.boardInfo(bno);
		List<FileVO> file = bDao.fileInfo(bno);
		List<ReplyVO> reply =  bDao.selectReply(bno);
		
		model.addAttribute("board", board);
		model.addAttribute("file", file);
		model.addAttribute("reply", reply);
		
		return "board/boardInfo";
	}
	
	// 게시물 삭제
	@ResponseBody
	@RequestMapping("board/deleteBoard")
	public String deleteBoard(int bno) {
		int result = bDao.deleteBoard(bno);
		if(result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 댓글 등록
	@RequestMapping("board/insertReply")
	public String insertReply(ReplyVO replyVO, HttpServletRequest request) {
		bDao.insertReply(replyVO);
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
	// 댓글 삭제
	@RequestMapping("board/deleteReply")
	public String deleteReply(int rno, HttpServletRequest request) {
		bDao.deleteReply(rno);
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
	// 게시물 수정 시 내용 자동입력
	@ResponseBody
	@RequestMapping("board/modifyBoard")
	public BoardVO modifyBoard(int bno) {
		BoardVO board = bDao.boardInfo(bno);
		return board;
	}
	
	// 게시물 수정 시 첨부파일 자동입력
	@ResponseBody
	@RequestMapping("board/modifyFile")
	public List<FileVO> modifyFile(int bno) {
		List<FileVO> file = bDao.fileInfo(bno);
		return file;
	}
	
	// 게시물 수정
	@RequestMapping("board/updateBoard")
	public String updateBoard(BoardVO boardVO) {
		// 익명여부 null인 경우 x 값 넣어주기
		if(boardVO.getIsanony() == null) {
			boardVO.setIsanony("x");
		}
		
		// 글 수정
		bDao.updateBoard(boardVO);
		
		List<FileVO> file = boardVO.getFileList();
		
		// 첨부파일 모두 삭제 후
		bDao.deleteFile(boardVO.getBno());
		
		// 첨부파일이 있는 경우
		// 첨부파일 다시 추가
		if(file != null) {
			for(int i = 0; i < file.size(); i++) {
				file.get(i).setBno(boardVO.getBno()); // 첨부파일에 해당하는 글의 bno 값 setting
				bDao.insertFile(file.get(i)); // 파일 정보 insert
			}
		}
		
		return "redirect:/board/board.jsp";
	}
	
	// 게시글 검색
	@ResponseBody
	@RequestMapping("board/searchBoard")
	public List<BoardVO> searchBoard(int currentPage, String search) {
		PageVO pageVO = new PageVO(10, currentPage);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startBoard", pageVO.getStartBoard());
		map.put("endBoard", pageVO.getEndBoard());
		map.put("search", search);
		System.out.println(bDao.searchBoard(map));
		return bDao.searchBoard(map);
	}
	
	// 게시글 검색 내역 개수
	@ResponseBody
	@RequestMapping("board/countSearch")
	public PageVO2 countSearch(String search, int showPage) {
		int totalBoard = bDao.countSearch(search);
		System.out.println("개수 : " + bDao.countSearch(search));
		PageVO2 pageVO2 = new PageVO2(totalBoard, showPage);
		System.out.println(pageVO2);
		return pageVO2;
	}
}
