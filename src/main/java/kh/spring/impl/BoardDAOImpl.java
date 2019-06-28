package kh.spring.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{
   
   @Autowired
   private JdbcTemplate template;
   @Autowired
   private SqlSessionTemplate sst;
   
   //SimpleDateFormat sdf = new SimpleDateFormat();
   
   /*글작성*/
   public int write(BoardDTO dto) {
      String sql = "insert into freeboard values(freeboard_seq.nextval,?,?,?,default,default,?)";
      System.out.println("write메서드");
      return template.update(sql, dto.getTitle(), dto.getContents(), dto.getWriter(),dto.getImage());
   }
   
   /*게시판목록*/
   public List<BoardDTO> boardList(int startNum, int endNum) {
      String sql = "select * from (select row_number() over(order by seq desc) as rown, freeboard.* from freeboard) where rown between ? and ?";
      return template.query(sql, new Object[] {startNum,endNum}, new RowMapper<BoardDTO>() {
         @Override
         public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            BoardDTO dto = new BoardDTO();
            dto.setSeq(rs.getInt("seq"));
            dto.setTitle(rs.getString("title"));
            dto.setContents(rs.getString("contents"));
            dto.setWriter(rs.getString("writer"));
            dto.setwriteDate(rs.getTimestamp("writeDate"));
            dto.setViewCount(rs.getInt("viewCount"));
            dto.setImage(rs.getString("image"));
            return dto;
         }
      });
   }
   
   /*하나의 게시글 읽기*/
   public BoardDTO selectOneArticle(int seq) {
      String sql = "select * from freeboard where seq=?";
      return template.queryForObject(sql, new Object[] {seq}, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class));
   }
   
	//totalCount//
	/*(1)전체 게시글의 개수*/
	public int totalRecordNum(){
		String sql = "select count(*) from freeboard";
		return template.queryForObject(sql, Integer.class);
		
	}
   /*페이지 네비게이터*/
	public String getNavi(int currentPage){

		int recordTotalCount = totalRecordNum();
		int recordCountPerPage = 5; //12개의 글이 보이게 한다.	
		int naviCountPerPage = 5; //5개의 네비가 보이게 한다.

		int pageTotalCount = recordTotalCount / recordCountPerPage;
		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount++;
		}

		//현재  페이지 오류 검출 및 정정
		/*보안코드 : 현재페이지가 1보다 작다면 1로, 전체페이지보다 크다면 전체페이지(pageTotalCount)로 표시하겠다*/
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		int startNavi = (currentPage - 1)/naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage - 1); 

		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		System.out.println("현재 위치 : " + currentPage);
		System.out.println("네비 시작 : " + startNavi);
		System.out.println("네비 끝 : " + endNavi);
		
		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1) { 
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder();
		
		if(needPrev) {
			int prevStartNavi = startNavi-1;
			sb.append("	<li class=\"page-item\"><a class=\"page-link\" href=\"board?currentPage="+ prevStartNavi +"\"" + 
					"							aria-label=\"Previous\"> <span aria-hidden=\"true\">&laquo;</span>" + 
					"						</a></li>");
			
		}
		for(int i = startNavi; i <= endNavi; i++) {
			sb.append("<li class=\"page-item\"><a class=\"page-link\" href=\"board?currentPage="+ i +"\">" + i + "</a></li>");
		}
		if(needNext) {
			int nextEndNavi = endNavi+1;
			sb.append("<li class=\"page-item\"><a class=\"page-link\" href=\"board?currentPage="+ nextEndNavi++ +"\""+ 
					"							aria-label=\"Next\"> <span aria-hidden=\"true\">&raquo;</span>" + 
					"						</a></li>");
		}

		return sb.toString();
	}
	
	/*글수정*/
	public int edit(BoardDTO dto) {
		String sql = "update freeboard set title=?, contents=?, viewCount=0 where seq=?";
		return template.update(sql, dto.getTitle(),dto.getContents(),dto.getSeq());
	}
	/*글삭제*/
	public int deleteOneArticle(int seq) {
		String sql = "delete from freeboard where seq=?";
		return template.update(sql,seq);
	}
   
}