package kh.spring.dto;

import java.sql.Timestamp;

public class CommentsDTO {
	private int seq;
	private String writer;
	private String comment;
	private Timestamp writerDate;
	
	
	public CommentsDTO() {
		super();
	}
	public CommentsDTO(int seq, String writer, String comment, Timestamp writerDate) {
		this.seq = seq;
		this.writer = writer;
		this.comment = comment;
		this.writerDate = writerDate;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Timestamp getWriterDate() {
		return writerDate;
	}
	public void setWriterDate(Timestamp writerDate) {
		this.writerDate = writerDate;
	}
	
	
}
