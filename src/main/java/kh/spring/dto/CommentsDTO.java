package kh.spring.dto;

import java.sql.Timestamp;

public class CommentsDTO {
	private int b_seq;
	private int c_seq;
	private String writer;
	private String comment;
	private Timestamp writerDate;
	
	
	public CommentsDTO() {
	}
	public CommentsDTO(int b_seq, int c_seq, String writer, String comment, Timestamp writerDate) {
		super();
		this.b_seq = b_seq;
		this.c_seq = c_seq;
		this.writer = writer;
		this.comment = comment;
		this.writerDate = writerDate;
	}
	public int getB_seq() {
		return b_seq;
	}
	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}
	public int getC_seq() {
		return c_seq;
	}
	public void setC_seq(int c_seq) {
		this.c_seq = c_seq;
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
