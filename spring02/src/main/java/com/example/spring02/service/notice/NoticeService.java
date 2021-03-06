package com.example.spring02.service.notice;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.example.spring02.model.board.dto.BoardDTO;

public interface NoticeService {
	public void deleteFile(String fullName);
	public List<Map<String, Object>> getAttach(int bno);
	public void create(BoardDTO dto) throws Exception;
	public BoardDTO read(int bno) throws Exception;
	public void update (BoardDTO dto) throws Exception;
	public void delete(int bno) throws Exception;
	public List<BoardDTO> listAll(String search_option, String keyword,
			int start, int end) throws Exception;
	public void increaseViewcnt(int bno, HttpSession session) throws Exception;
	public int countArticle(String search_option, String keyword) throws Exception;
}
