package kr.co.hn.vo;

/*enum type{
	S("관리자"), 
	U("일반사용자");
}*/

public class MemberVO {
	private String id;
	private String name;
	private String residentNum1;
	private String residentNum2;
	private String password;
	private String emailId;
	private String emailDomain;
	private String tel1;
	private String tel2;
	private String tel3;
	private String post;
	private String basicAddr;
	private String detailAddr;
	private String type; // 'S'면 관리자, 'U'면 일반사용자
	private String regDate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getResidentNum1() {
		return residentNum1;
	}
	public void setResidentNum1(String residentNum1) {
		this.residentNum1 = residentNum1;
	}
	public String getResidentNum2() {
		return residentNum2;
	}
	public void setResidentNum2(String residentNum2) {
		this.residentNum2 = residentNum2;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getEmailDomain() {
		return emailDomain;
	}
	public void setEmailDomain(String emailDomain) {
		this.emailDomain = emailDomain;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getBasicAddr() {
		return basicAddr;
	}
	public void setBasicAddr(String basicAddr) {
		this.basicAddr = basicAddr;
	}
	public String getDetailAddr() {
		return detailAddr;
	}
	public void setDetailAddr(String detailAddr) {
		this.detailAddr = detailAddr;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", name=" + name + ", residentNum1=" + residentNum1 + ", residentNum2="
				+ residentNum2 + ", password=" + password + ", emailId=" + emailId + ", emailDomain=" + emailDomain
				+ ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3 + ", post=" + post + ", basicAddr=" + basicAddr
				+ ", detailAddr=" + detailAddr + ", type=" + type + ", regDate=" + regDate + "]";
	}
	


	
}
