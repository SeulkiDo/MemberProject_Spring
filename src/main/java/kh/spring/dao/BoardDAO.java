package kh.spring.dao;

import java.util.List;

import kh.spring.dto.BoardDTO;

public interface BoardDAO {
   public int write(BoardDTO dto) throws Exception;
   public List<BoardDTO> boardList(int startNum, int endNum) throws Exception;
   public BoardDTO selectOneArticle(int seq) throws Exception;
   public int totalRecordNum() throws Exception;
   public String getNavi(int currentPage) throws Exception;
   public int edit(BoardDTO dto) throws Exception;
   public int deleteOneArticle(int seq) throws Exception;
}
