package kr.co.hn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import kr.co.hn.util.ConnectionFactory;
import kr.co.hn.vo.OpenResigterVO;
import kr.co.hn.vo.TransactionVO;

public class OpenbankDAO {
	
	public int register(OpenResigterVO vo) {
		StringBuilder sql = new StringBuilder();
		sql.append("insert into hn_open_register(member_id, password) values(?, ?) ");
		
		int result = -1;
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			
			int loc = 1;
			pstmt.setString(loc++, vo.getMemberId());
			pstmt.setString(loc++, vo.getPassword());
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
