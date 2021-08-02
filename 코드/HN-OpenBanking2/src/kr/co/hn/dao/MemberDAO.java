package kr.co.hn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.co.hn.vo.MemberVO;
import kr.co.hn.util.ConnectionFactory;

public class MemberDAO {
	
	
	public String searchMyTel(String id) {
		String result = "";
		
		StringBuilder sql = new StringBuilder();
		sql.append("select tel1||tel2||tel3 from hn_member where id = ? ");
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			int loc = 1;
			pstmt.setString(loc++, id );
			
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			
			result = rs.getString(1);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int selfAuth(MemberVO vo) {
		int result = -1;
		
		StringBuilder sql = new StringBuilder();
		sql.append("select count(*) from hn_member ");
		sql.append("    where id=? ");
		sql.append("    and resident_num1 = ? ");
		sql.append("    and resident_num2 = ? ");
		sql.append("    and tel1 = ? ");
		sql.append("    and tel2 = ? ");
		sql.append("    and tel3 = ? ");
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			int loc = 1;
			pstmt.setString(loc++, vo.getId() );
			pstmt.setString(loc++, vo.getResidentNum1());
			pstmt.setString(loc++, vo.getResidentNum2() );
			pstmt.setString(loc++, vo.getTel1() );
			pstmt.setString(loc++, vo.getTel2() );
			pstmt.setString(loc++, vo.getTel3() );
			
			
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			
			result = rs.getInt(1);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public int join(MemberVO member) {
		
		int result = -1;
		StringBuilder sql = new StringBuilder();
		sql.append(" insert into hn_member( ");
		sql.append("    id, name, ");
		sql.append("    resident_num1, resident_num2, ");
		sql.append("    password, ");
		sql.append("    email_id, email_domain ");
		sql.append("    ,tel1, tel2, tel3 ");
		sql.append("    ,post, basic_addr, detail_addr ");
		sql.append("    ,type ");
		sql.append(" ) VALUES( ");
		sql.append(" ? ,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'U')");
		
		try(
			Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){

			int loc = 1;
			pstmt.setString(loc++, member.getId() );
			pstmt.setString(loc++, member.getName());
			pstmt.setString(loc++, member.getResidentNum1());
			pstmt.setString(loc++, member.getResidentNum2());
			pstmt.setString(loc++, member.getPassword());
			pstmt.setString(loc++, member.getEmailId());
			pstmt.setString(loc++, member.getEmailDomain());
			pstmt.setString(loc++, member.getTel1());
			pstmt.setString(loc++, member.getTel2());
			pstmt.setString(loc++, member.getTel3());
			pstmt.setString(loc++, member.getPost());
			pstmt.setString(loc++, member.getBasicAddr());
			pstmt.setString(loc++, member.getDetailAddr());
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
