package kr.co.hn.util;

import java.security.MessageDigest;

public class ShaPasswordEncoder {

	public String passwordEncode(String password) {
		
		String encodedPassword = "";
		
		try{
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(password.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if(hex.length() == 1) hexString.append('0');
				hexString.append(hex);
			}

			//출력
			encodedPassword = hexString.toString();

		} catch(Exception ex){
			throw new RuntimeException(ex);
		}
		
		return encodedPassword;
	}
	
	public static void main(String[] args) {
		ShaPasswordEncoder s = new ShaPasswordEncoder();
		
		System.out.println(s.passwordEncode("nee1202"));
	}

}
