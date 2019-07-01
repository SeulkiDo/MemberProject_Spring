package kh.spring.practice;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.spring.dto.BoardDTO;
import kh.spring.impl.BoardDAOImpl;


@Controller
public class BoardController {
   @Autowired
   private HttpSession session;
   @Autowired
   private BoardDAOImpl dao;
   
      @RequestMapping("/board")
      public String board(HttpServletRequest request) {
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//        int recordCountPerPage = 10;
//        int naviCountPerPage = 10;
        
    	
		int endNum = currentPage * 5;
		int startNum = endNum - 4;
		
		
         request.setAttribute("boardList", dao.boardList(startNum, endNum));     

         System.out.println("currentPage : " + currentPage);
         try {
			request.setAttribute("getNavi", dao.getNavi(currentPage));
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
         return "board";
      }
      
      @RequestMapping("/writeForm_MembersOnly")
      public String wirteForm() {
         return "writeForm";
      }


      @RequestMapping("/write_MembersOnly")
      public String write(BoardDTO dto, MultipartFile imageFile) {
    	    String writer = (String) session.getAttribute("loginId");
    	  
    		String path = "D:\\SpringOnly\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MemberProject\\resources\\";
    		File dir = new File(path + "boardImages/" + writer); //폴더경로
    		System.out.println("폴더 존재? : " + dir.isDirectory());
    		if(!dir.isDirectory()) { // 폴더가 있는지 확인.
    			System.out.println("폴더생성");
    			dir.mkdirs(); // 없으면 생성
    		}

        
         String resourcePath = session.getServletContext().getRealPath("/resources/boardImages/"+writer);
         String renamedFilePath = resourcePath + "/" + writer + "_" +System.currentTimeMillis()+ "_boardImage.png";
         System.out.println(writer);
         String newFileName = null;
          try {
             File newFile = new File(resourcePath + "/" + writer + "_"+System.currentTimeMillis()+ "_boardImage.png");
             imageFile.transferTo(newFile);
             String filePath = "/resources/" + newFile.getName();
             newFileName = newFile.getName();
             dto.setImage(newFileName);
             System.out.println("newFile.getName() : " + newFileName);
             dto.setWriter(writer);
             
         }catch (Exception e) {
            e.printStackTrace();
            return "error";
         }
         
      
         //System.out.println("글내용 : " + dto.getContents());
         dao.write(dto);
         return "redirect:board?currentPage=1";
      }
      
//      @ResponseBody
//      @RequestMapping("/showImage")
//      public String imageUpload(BoardDTO dto, MultipartFile formData) {
//
//         String writer = (String) session.getAttribute("loginId");
//         String resourcePath = session.getServletContext().getRealPath("/resources");
//         String renamedFilePath = resourcePath + "/" + writer + "_" +System.currentTimeMillis()+ "_boardImage.png";
//         System.out.println(writer);
//         String result = null;
//          try {
//             File newFile = new File(renamedFilePath);
//             formData.transferTo(newFile);
//             //String filePath = "/resources/" + newFile.getName();
//             result = newFile.getName();
//         }catch (IOException e) {
//            e.printStackTrace();
//         }
//         return result;
//      
//      }
      
      @RequestMapping("/read")
      public String read(HttpServletRequest request) {
    	  System.out.println("/read");
    	  int seq = 0;
    	  if(request.getParameter("seq")==null) { //글수정 후 넘어왔을 때
    		  seq = (Integer) session.getAttribute("boardNo");    		  
    	  }else { //목록에서 넘어왔을 때
    		seq = Integer.parseInt(request.getParameter("seq"));
    	  }
         request.setAttribute("selectedArticle", dao.selectOneArticle(seq));
         session.removeAttribute("boardNo"); //세션에 담은 boardNo 삭제
      return "read";
      }
      
      @RequestMapping("/editForm_MembersOnly")
      public String editForm(HttpServletRequest request) {
          int seq = Integer.parseInt(request.getParameter("seq"));
          System.out.println(seq);
          request.setAttribute("selectedArticle", dao.selectOneArticle(seq));
    	  return "editForm";
      }
      
      @RequestMapping("/edit_MembersOnly")
      public String edit(BoardDTO dto, MultipartFile imageFile) {
    	  System.out.println("수정된 글내용 : " + dto.getContents());
    	
    	   String writer = (String) session.getAttribute("loginId");
           String resourcePath = session.getServletContext().getRealPath("/resources/boardImages/"+writer);
           String renamedFilePath = resourcePath + "/" + writer + "_" +System.currentTimeMillis()+ "_boardImage.png";
 
           String result = null;
            try {
               File newFile = new File(resourcePath + "/" + writer + "_"+System.currentTimeMillis()+ "_boardImage.png");
               imageFile.transferTo(newFile);
               String filePath = "/resources/boardImages/" +writer + "/" + newFile.getName();
               result = newFile.getName();
               dto.setImage(newFile.getName());
               System.out.println("newFile.getName() : " + newFile.getName());
               session.setAttribute("boardNo", dto.getSeq());
               
           }catch (Exception e) {
              e.printStackTrace();
              return "error";
           }
           
    	  dao.edit(dto);
    	  return "redirect:read";
      }
      
      @RequestMapping("/delete_MembersOnly")
      public String delete(HttpServletRequest request) {
    	  int seq = Integer.parseInt(request.getParameter("seq"));
    	  dao.deleteOneArticle(seq);
    	  return "redirect:board?currentPage=1";
      }
      
}
