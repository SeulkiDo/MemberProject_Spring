package kh.spring.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.spring.dao.CommentsDAO;
import kh.spring.dto.CommentsDTO;

@Repository
public class CommentsImpl implements CommentsDAO{
	@Autowired
	private JdbcTemplate template;
	
	public int insertComment(CommentsDTO dto) {
		String sql = "insert into board_comments values(?,?,?,default)";
  		return template.update(sql, dto.getSeq(), dto.getWriter(), dto.getComment());
	}
	
}
