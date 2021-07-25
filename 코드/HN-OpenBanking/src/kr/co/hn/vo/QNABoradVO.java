package kr.co.hn.vo;

public class QNABoradVO {
/*
CREATE TABLE HN_QNA(
    no NUMBER(38),
    group_no number(38), -- 글그룹 (= 최상단 부모글번호)
    group_order number(38) default 0, -- 그룹 동일 depth간 순서? (글번호로 정렬 가능할듯)
    group_depth number(38) default 0, -- 그룹 내 depth
    parent_no  number(38), -- 직계 부모 글번호
    writer varchar2(20),
    subject varchar2(200),
    content varchar2(4000),
    type char(1) default 'Q',
    view_cnt number(38) default 0,
    regdate date default sysdate,
    CONSTRAINT hn_qna_no_pk PRIMARY key(no)  
);
 */
	
    private int no;
    private int groupNo; // 글그룹 (= 최상단 부모글번호)
	private int groupDepth; // 그룹 내 depth
	private int parentNo; // 직계 부모 글번호
	private String writer;
	private String subject;
	private String content;
	private String type;
	private int viewCnt;
	private String regdate;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public int getGroupDepth() {
		return groupDepth;
	}
	public void setGroupDepth(int groupDepth) {
		this.groupDepth = groupDepth;
	}
	public int getParentNo() {
		return parentNo;
	}
	public void setParentNo(int parentNo) {
		this.parentNo = parentNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	
	
	
}
