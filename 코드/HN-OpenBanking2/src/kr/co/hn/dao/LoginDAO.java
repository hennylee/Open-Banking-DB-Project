package kr.co.hn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.co.hn.util.ConnectionFactory;
import kr.co.hn.vo.MemberVO;

public class LoginDAO {
	
	/**
	 * 사용자가 입력한 ID, PW로 로그인 여부 판단
	 * @return 해당 MemberVO
	 * @param 로그인 시 입력한 ID, PWD를 포함한 MemberVO
	 */
	public MemberVO login(MemberVO memberVO) {
		
		MemberVO userVO = null;
		
		/*
		 * StringBuilder는 AutoCloseable을 상속받지 않기 때문에 
		 * try with resource문에 작성할 수 없기 때문에 try~catch문 위에 작성하고 있는 것이다.
		 */
		StringBuilder sql = new StringBuilder();
		sql.append("select id, name, type "); // password는 사용할 일이 없기 때문에 받아오지 않는다.
		sql.append(" from hn_member ");
		sql.append(" where id = ? and password = ? and type = ? ");
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			pstmt.setString(1, memberVO.getId());
			pstmt.setString(2, memberVO.getPassword());
			pstmt.setString(3, memberVO.getType());
			
			ResultSet rs = pstmt.executeQuery();
			
			//로그인에 성공했다면
			if(rs.next()) { 
				userVO = new MemberVO();
				userVO.setId(rs.getString("id"));
				userVO.setName(rs.getString("name"));
				userVO.setType(rs.getString("type"));
			}
			// 로그인 실패했다면, userVO = null
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return userVO;
	}
	
	
	
	// 아이디 중복 체크
	public int idCheck(String id) {
		
		int result = -1;
		String sql = "select count(*) from hn_member where id = ? ";
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			
			int loc = 1;
			pstmt.setString(loc++, id);
			
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}
	
	// 이메일 중복 체크
	public int emailCheck(String emailId, String emailDomain) {
		
		int result = -1;
		String sql = "select count(*) from hn_member where email_id = ? and email_domain = ? ";
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				){
			
			int loc = 1;
			pstmt.setString(loc++, emailId);
			pstmt.setString(loc++, emailDomain);
			
			ResultSet rs = pstmt.executeQuery();
			result = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}
	
	
	
	
	
	
	// 오픈뱅킹 가입한 회원인지 확인하기? 회원 db에 넣는게 좋겠어!!
	public String openMemCheck(String id) {
		
		String sql = "select * from hn_open_register where member_id = ?";
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
			};
			
			
					
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
