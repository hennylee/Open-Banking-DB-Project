package kr.co.hn.vo;

public class TransactionVO {
	private int transNo;
    private String myAccount;
    private int myBalance;
    private String targetAccount;
    private String targetBank;
    private String targetName;
    private String transDate;
    private int transAmount;
    private String transType;
    private String myName;
    private String myBank;
    
    
	public String getMyName() {
		return myName;
	}
	public void setMyName(String myName) {
		this.myName = myName;
	}
	public String getMyBank() {
		return myBank;
	}
	public void setMyBank(String myBank) {
		this.myBank = myBank;
	}
	public int getTransNo() {
		return transNo;
	}
	public void setTransNo(int transNo) {
		this.transNo = transNo;
	}
	public String getMyAccount() {
		return myAccount;
	}
	public void setMyAccount(String myAccount) {
		this.myAccount = myAccount;
	}
	public int getMyBalance() {
		return myBalance;
	}
	public void setMyBalance(int myBalance) {
		this.myBalance = myBalance;
	}
	public String getTargetAccount() {
		return targetAccount;
	}
	public void setTargetAccount(String targetAccount) {
		this.targetAccount = targetAccount;
	}
	public String getTargetBank() {
		return targetBank;
	}
	public void setTargetBank(String targetBank) {
		this.targetBank = targetBank;
	}
	public String getTargetName() {
		return targetName;
	}
	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}
	public String getTransDate() {
		return transDate;
	}
	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}
	public int getTransAmount() {
		return transAmount;
	}
	public void setTransAmount(int transAmount) {
		this.transAmount = transAmount;
	}
	public String getTransType() {
		return transType;
	}
	public void setTransType(String transType) {
		this.transType = transType;
	}
	@Override
	public String toString() {
		return "TransactionVO [transNo=" + transNo + ", myAccount=" + myAccount + ", myBalance=" + myBalance
				+ ", targetAccount=" + targetAccount + ", targetBank=" + targetBank + ", targetName=" + targetName
				+ ", transDate=" + transDate + ", transAmount=" + transAmount + ", transType=" + transType + "]";
	}
    
    
    
    
}
