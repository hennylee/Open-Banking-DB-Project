package kr.co.hn.vo;

import java.util.List;

public class AccountVO {
	private String account;
	private int password;
	private String memberID;
	private int balance;
	private String alias;
	private String openingDate;
	private String typeCode;
	private String bankName;
	private String bankCode;
	
	
	
	public String getbankName() {
		return bankName;
	}
	public void setbankName(String bankName) {
		this.bankName = bankName;
	}
	private AccountTypeVO typeVO;
	
	public AccountTypeVO getTypeVO() {
		return typeVO;
	}
	public void setTypeVO(AccountTypeVO typeVO) {
		this.typeVO = typeVO;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getPassword() {
		return password;
	}
	public void setPassword(int password) {
		this.password = password;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getOpeningDate() {
		return openingDate;
	}
	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	
	
}
