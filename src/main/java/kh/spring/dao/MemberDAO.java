package kh.spring.dao;

import java.util.List;

import kh.spring.dto.MemberDTO;

public interface MemberDAO {
	  public int join(MemberDTO dto) throws Exception;
	  public int login(MemberDTO dto) throws Exception;
	  public int idDuplCheck(String id) throws Exception;
	  public MemberDTO myInfo(String id) throws Exception;
	  public List<MemberDTO> selectAll() throws Exception;
	  public int updateMyInfo(MemberDTO dto,String id) throws Exception;
}
