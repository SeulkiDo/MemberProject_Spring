package kh.spring.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String phone;
	private String email;
	private String zipcode;
	private String address1;
	private String address2;
	private Timestamp joindate;
	private String profileImage;
	
	
	public MemberDTO() {
	}
	
	
	
	public MemberDTO(String id, String pw, String name) {
		this.id = id;
		this.pw = pw;
		this.name = name;
	}



	public MemberDTO(String id, String pw, String name, String phone, String email, String zipcode, String address1,
			String address2, Timestamp joindate, String profileImage) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.joindate = joindate;
		this.profileImage = profileImage;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getPw() {
		return pw;
	}



	public void setPw(String pw) {
		this.pw = pw;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getZipcode() {
		return zipcode;
	}



	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}



	public String getAddress1() {
		return address1;
	}



	public void setAddress1(String address1) {
		this.address1 = address1;
	}



	public String getAddress2() {
		return address2;
	}



	public void setAddress2(String address2) {
		this.address2 = address2;
	}



	public Timestamp getJoindate() {
		return joindate;
	}



	public void setJoindate(Timestamp joindate) {
		this.joindate = joindate;
	}



	public String getProfileImage() {
		return profileImage;
	}



	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	

	
	
}
