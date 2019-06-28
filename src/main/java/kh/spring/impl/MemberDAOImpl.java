package kh.spring.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import kh.spring.dao.MemberDAO;
import kh.spring.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO{

   @Autowired
   private JdbcTemplate template;
   @Autowired
   private SqlSessionTemplate sst;
   
//   public int join(MemberDTO dto){
//      String sql = "insert into members values(?,?,?,?,?,?,?,?,default,?)";
//      return template.update(sql, dto.getId(),dto.getPw(),dto.getName(),dto.getPhone(),dto.getEmail(),dto.getZipcode(),dto.getAddress1(),dto.getAddress2(),dto.getProfileImage());
//   }
   public int join(MemberDTO dto){ /*MyBatis*/
 	   return sst.insert("MemberDAO.join",dto);
	   
   }

//   public int login(MemberDTO dto) {
//      String sql = "select count(*) from members where id = ? and pw = ?";
//      return template.queryForObject(sql, Integer.class, dto.getId(), dto.getPw());
//   }
   public int login(MemberDTO dto) { /*MyBatis*/
	  return sst.selectOne("MemberDAO.login",dto);
   }
   
   public int idDuplCheck(String id) {
      String sql = "select count(*) from members where id ='"+id+"'";
      return template.queryForObject(sql, Integer.class);
   }
   
   public MemberDTO myInfo(String id){
      String sql = "select * from members where id='"+id+"'";
      return template.queryForObject(sql,new RowMapper<MemberDTO>() {
         
         @Override
         public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            MemberDTO dto = new MemberDTO();
            dto.setId(rs.getString("id"));
            dto.setPw(rs.getString("pw"));
            dto.setName(rs.getString("name"));
            dto.setPhone(rs.getString("phone"));
            dto.setEmail(rs.getString("email"));
            dto.setZipcode(rs.getString("zipcode"));
            dto.setAddress1(rs.getString("address1"));
            dto.setAddress2(rs.getString("address2"));
            dto.setJoindate(rs.getTimestamp("joindate"));
            dto.setProfileImage(rs.getString("profileImage"));
            return dto;
         }
         
      });      
   }
   
   public List<MemberDTO> selectAll(){
      String sql = "select * from members";
      return template.query(sql, new RowMapper<MemberDTO>() {
         
         @Override
         public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            MemberDTO dto = new MemberDTO();
            dto.setId(rs.getString("id"));
            dto.setPw(rs.getString("pw"));
            dto.setName(rs.getString("name"));
            dto.setPhone(rs.getString("phone"));
            dto.setEmail(rs.getString("email"));
            dto.setZipcode(rs.getString("zipcode"));
            dto.setAddress1(rs.getString("address1"));
            dto.setAddress2(rs.getString("address2"));
            dto.setJoindate(rs.getTimestamp("joindate"));
            dto.setProfileImage(rs.getString("image"));
            return dto;
         }
         
      });
   }

   
   public int updateMyInfo(MemberDTO dto,String id) {
	      String sql = "update members set pw=?, phone=?, zipcode=?, address1=?, address2=?, profileImage=? where id='"+id+"'";
	      return template.update(sql, dto.getPw(),dto.getPhone(),dto.getZipcode(),dto.getAddress1(),dto.getAddress2(),dto.getProfileImage());
	   }
   
//   public int updateMyInfo(MemberDTO dto,String id) {
//      String sql = "update members set pw=?, phone=?, zipcode=?, address1=?, address2=? where id='"+id+"'";
//      return template.update(sql, dto.getPw(),dto.getPhone(),dto.getZipcode(),dto.getAddress1(),dto.getAddress2());
//   }
   
   public int updateMyImage(String id) {
      String sql = "update members set profileImage=? where id='"+id+"'";
      return template.update(sql);
   }
   
   
}
