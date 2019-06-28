package kh.spring.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	private int seq;
	private String title;
	private String contents;
	private String writer;
	private Timestamp writeDate;
	private int viewCount;
	private String image;
	
	
	public BoardDTO() {
		super();
	}
	public BoardDTO(int seq, String title, String contents, String writer, Timestamp writeDate, int viewCount,
			String image) {
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.image = image;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getwriteDate() {
		return writeDate;
	}
	public void setwriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	//시간-----------------------------------------------------------
		public String getFormedTime() {
			long currentTime = System.currentTimeMillis();
			long writeTime = this.writeDate.getTime();
			
			if(currentTime - writeTime < (1000 * 60 * 60)) {
				long time = currentTime - writeTime;
				return time / 1000 / 60 + "분 전";
			}else if(currentTime - writeTime < (1000 * 60 * 60 * 24)) {
				long time = currentTime - writeTime;
				return time / 1000 / 60 / 60 + "시간 전";
			}else {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				return sdf.format(writeDate);
			}		
		}
		//---------------------------------------------------------------
	
	
}
