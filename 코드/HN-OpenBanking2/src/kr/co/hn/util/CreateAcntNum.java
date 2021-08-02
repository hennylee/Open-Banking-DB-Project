package kr.co.hn.util;

import java.util.Random;

import kr.co.hn.dao.AccountDAO;

public class CreateAcntNum {
	
	public String totalNum(String seqName) {
		String f = firstNum(seqName);
		String l = lastNum();
		
		return f.concat(l);
	}
	
	public String lastNum() {
		int certNumLength = 6;

		Random random = new Random(System.currentTimeMillis());

		int range = (int) Math.pow(10, certNumLength);
		int trim = (int) Math.pow(10, certNumLength - 1);
		int result = random.nextInt(range) + trim;

		if (result > range) {
			result = result - trim;
		}

		return String.valueOf(result);
	}

	public String firstNum(String seqName) {
		AccountDAO dao = new AccountDAO();
		return dao.createMidNum(seqName);
	}
}
