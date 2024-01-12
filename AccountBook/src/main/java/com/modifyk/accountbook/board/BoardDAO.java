package com.modifyk.accountbook.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BoardDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 글 작성
	public int insertBoard(BoardVO boardVO) {
		return my.insert("boardMapper.insertBoard", boardVO);
	}
	
	// 첨부파일 작성
	public int insertFile(FileVO fileVO) {
		return my.insert("boardMapper.insertFile", fileVO);
	}
	
	// 게시물 목록
	public List<BoardVO> selectBoard(PageVO pageVO) {
		return my.selectList("boardMapper.selectBoard", pageVO);
	}
	
	// 게시물 수
	public int countBoard() {
		return my.selectOne("boardMapper.countBoard");
	}
	
	// 게시물 내용
	public BoardVO boardInfo(int bno) {
		return my.selectOne("boardMapper.boardInfo", bno);
	}
	
	// 게시물 첨부파일 가져오기
	public List<FileVO> fileInfo(int bno) {
		return my.selectList("boardMapper.fileInfo", bno);
	}
	
	// 게시물 삭제
	public int deleteBoard(int bno) {
		return my.delete("boardMapper.deleteBoard", bno);
	}
	
	// 댓글 등록
	public int insertReply(ReplyVO replyVO) {
		return my.insert("boardMapper.insertReply", replyVO);
	}
	
	// 댓글 삭제
	public int deleteReply(int rno) {
		return my.delete("boardMapper.deleteReply", rno);
	}
	
	// 댓글 보여주기
	public List<ReplyVO> selectReply(int bno) {
		return my.selectList("boardMapper.selectReply", bno);
	}
	
	// 게시물 수정
	public int updateBoard(BoardVO boardVO) {
		return my.update("boardMapper.updateBoard", boardVO);
	}
	
	// 첨부파일 삭제
	public int deleteFile(int bno) {
		return my.delete("boardMapper.deleteFile", bno);
	}
	
	// 게시글 검색
	public List<BoardVO> searchBoard(Map<String, Object> map) {
		return my.selectList("boardMapper.searchBoard", map);
	}
	
	// 게시글 검색 내역 개수
	public int countSearch(String search) {
		return my.selectOne("boardMapper.countSearch", search);
	}
}
