package kh.spring.practice;

import java.io.File;
import java.io.IOException;
import java.security.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.spring.dto.MemberDTO;
import kh.spring.impl.MemberDAOImpl;

@Controller
public class HomeController {
	
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
 
   @Autowired
   private HttpSession session;
   @Autowired
   private MemberDAOImpl dao;
   
   @RequestMapping("/")
   public String index() {
      session.getAttribute("loginId");
      session.getAttribute("loginResult");
      return "home";
   }
   
   @RequestMapping("error")
   public String error() {
	   return "error";
   }
   
   @RequestMapping("/joinForm")
   public String SignupForm() {
      return "joinForm";
   }
   
   @RequestMapping("/join")
   public String join(MemberDTO dto, MultipartFile image) {
	 
      String resourcePath = session.getServletContext().getRealPath("/resources");
      System.out.println("resourcePath(join) : " + resourcePath);
      try {
         File newFile = new File(resourcePath+"/"+dto.getId() +"_profileImage.png");
         image.transferTo(newFile);
         String filePath = "/resources/" + newFile.getName();
         System.out.println(filePath);
         dto.setProfileImage(newFile.getName());
         System.out.println(dto.getId());
         dao.join(dto);
      
   //   System.out.println(dto.getProfileImage());
      } catch (IOException e) {
         e.printStackTrace();
      }
      
      return "home";
   }
      
   @RequestMapping("/login")
   public String login(MemberDTO dto, HttpServletRequest request) {   
	   /*MyBatis---*/
	   String id = request.getParameter("id");
	   String pw = request.getParameter("pw");
	   dto.setId(id);
	   dto.setPw(pw);
	   int loginResult = dao.login(dto);
	   /*---MyBatis*/
	  session.setAttribute("loginId", dto.getId());
      session.setAttribute("loginResult", loginResult);
      request.setAttribute("myInfo", dao.myInfo(dto.getId()));
      return "home";
   }
   
   @RequestMapping("/logout")
   public String logout() {
      session.invalidate();
      return "home";
   }
   
   @ResponseBody
   @RequestMapping("/idDuplCheck")
   public String idDuplcheck(String id, HttpServletRequest request) {
      System.out.println("idDuplCheck");
      String inputId = request.getParameter("inputId");
      int idDuplCheckResult = dao.idDuplCheck(inputId);
      if(idDuplCheckResult>0) {
         return "x"; //사용 불가
      }else {
         return "o"; //사용가능
      }
   }
   
   
   @ResponseBody
   @RequestMapping("/profileImageUpload")
   public String uploadProc(MemberDTO dto, MultipartFile formData) {
      String resourcePath = session.getServletContext().getRealPath("/resources");
      String renamedFilePath = resourcePath+"/temp_profileImage.png";
      System.out.println("resourcePath(profileImageUpload) : " + resourcePath);
      String result = null;
      try {
         File newFile = new File(resourcePath+"/temp_profileImage.png");
         formData.transferTo(newFile);
         String filePath = "/resources/" + newFile.getName();
         result = newFile.getName();
         System.out.println(filePath);
         dto.setProfileImage(newFile.getName());
         
         System.out.println(result);
     
      } catch (IOException e) {
         e.printStackTrace();
      }
	return result;
      
   }
   
   @RequestMapping("/myInfo")
   public String myInfo(HttpServletRequest request, MemberDTO dto, MultipartFile image) {
      try {
         String id = (String) session.getAttribute("loginId");
         request.setAttribute("myInfo", dao.myInfo(id));
      } catch (Exception e) {
         e.printStackTrace();
      }
      
      return "myPage";
   }
   @RequestMapping("/updateMyInfo")
   public String updateMyInfo(HttpServletRequest request, MemberDTO dto, MultipartFile image) {
      String id = (String) session.getAttribute("loginId");
      String resourcePath = session.getServletContext().getRealPath("/resources");
      System.out.println("resourcePath : " + resourcePath);
      try {
         File newFile = new File(resourcePath+"/"+id +"_profileImage.png");
         image.transferTo(newFile);
         String filePath = "/resources/" + newFile.getName();
         System.out.println(filePath);
         dto.setProfileImage(newFile.getName());
         
         session.setAttribute("myProfileImage", dto.getProfileImage());
         System.out.println(filePath);
    	  
         dao.updateMyInfo(dto, id);   
      } catch (Exception e) {
         e.printStackTrace();
      }
      return "home";
   }
   
   @RequestMapping("/updateImagePopUp")
   public String gotoUpdateImage(HttpServletRequest request){
      return "updateImage";
   }
   
   @ResponseBody
   @RequestMapping("/updateImage")
   public String updateImage(HttpServletRequest request, MultipartFile formData) {
	 System.out.println("updateImage");
      String id = (String) session.getAttribute("loginId");
      System.out.println("아이디" + id);
      String resourcePath = session.getServletContext().getRealPath("/resources");
      System.out.println("resourcePath : " + resourcePath);
      System.out.println("image : " + formData);
//      try {
//         File newFile = new File(resourcePath+"/"+id +"_profileImage.png");
//         image.transferTo(newFile);
//       
//     
//         
//      } catch (Exception e) {
//         e.printStackTrace();
//      }
//      return "myPage";
      String result = null;
      try {
         File newFile = new File(resourcePath+"/temp_profileImage.png");
         formData.transferTo(newFile);
         String filePath = "/resources/" + newFile.getName();
         result = newFile.getName();
    
         System.out.println(result);
     
      } catch (IOException e) {
         e.printStackTrace();
      }
	return result;
   }
   
	
	@RequestMapping("/webchat")
	public String webchat() {
		return "webchat";
	}
   


}