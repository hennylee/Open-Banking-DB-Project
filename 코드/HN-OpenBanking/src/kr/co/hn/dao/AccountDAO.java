package kr.co.hn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.co.hn.util.ConnectionFactory;
import kr.co.hn.vo.AccountTypeVO;
import kr.co.hn.vo.AccountVO;
import kr.co.hn.vo.BankCodeVO;
import kr.co.hn.vo.MemberVO;

public class AccountDAO {
	
	
	public List<AccountVO> findById(String memberId){
		List<AccountVO> list = new ArrayList<>();

		StringBuilder sql = new StringBuilder();
		sql.append("select a.account account, a.balance balance, a.alias alias, c.type type  ");
		sql.append(" from hn_account a, hn_member b, hn_acnt_type c ");
		sql.append(" where a.type_code = c.code ");
		sql.append("    and a.member_id = ?  ");
		sql.append("    and a.member_id = b.id ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		) {
			
			pstmt.setString(1, memberId);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				AccountTypeVO typeVO = new AccountTypeVO();
				typeVO.setType(rs.getString("type"));

				AccountVO vo = new AccountVO();
				vo.setAccount(rs.getString("account"));
				vo.setBalance(rs.getInt("balance"));
				vo.setAlias(rs.getString("alias"));
				vo.setTypeVO(typeVO);

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	
	
	public int opening(AccountVO vo) {
		
		int result = -1;
		
		StringBuilder sql = new StringBuilder();
		sql.append(" INSERT INTO hn_account( ");
		sql.append("	account ");
		sql.append("	,password ");
		sql.append("	,member_id ");
		sql.append("	,alias ");
		sql.append("    ,type_code ");
		sql.append("    ,bank_code ");
		sql.append(" ) VALUES( ");
		sql.append(" ? ,?, ?, ?, ?, ?)");
		
		try(
			Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){

			int loc = 1;
			pstmt.setString(loc++, vo.getAccount());
			pstmt.setInt(loc++, vo.getPassword());
			pstmt.setString(loc++, vo.getMemberID());
			pstmt.setString(loc++, vo.getAlias());
			pstmt.setString(loc++, vo.getTypeCode());
			pstmt.setString(loc++, "3000");
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public String createMidNum(String seqName) {
		String midNum = "";
		String sql = null;
		String sql1 = "select to_char(seq_hn_acnt_mid_1.nextval, 'FM000000') from dual ";
		String sql2 = "select to_char(seq_hn_acnt_mid_2.nextval, 'FM000000') from dual ";
		String sql3 = "select to_char(seq_hn_acnt_mid_3.nextval, 'FM000000') from dual ";
		String sql4 = "select to_char(seq_hn_acnt_mid_4.nextval, 'FM000000') from dual ";
		
		
		switch(seqName) {
			case "seq_hn_acnt_mid_1" : 
				sql = sql1;
				break;
			case "seq_hn_acnt_mid_2" : 
				sql = sql2;
				break;
			case "seq_hn_acnt_mid_3" : 
				sql = sql3;
				break;
			case "seq_hn_acnt_mid_4" : 
				sql = sql4;
				break;
		}

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		) {

			ResultSet rs = pstmt.executeQuery();

			if(rs.next()) {
				midNum = rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return midNum;
	}

	public List<BankCodeVO> getBankList() {
		List<BankCodeVO> list = new ArrayList<>();

		String sql = "select * from hn_bank_code ";

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				BankCodeVO vo = new BankCodeVO();
				vo.setCode(rs.getString("code"));
				vo.setName(rs.getString("name"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<AccountTypeVO> getAccountTypeList() {
		List<AccountTypeVO> list = new ArrayList<>();

		String sql = "select * from hn_acnt_type ";

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);) {

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				AccountTypeVO vo = new AccountTypeVO();
				vo.setCode(rs.getString("code"));
				vo.setType(rs.getString("type"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public String checkOpeningDate(MemberVO vo) {

		String possibleDate = null;
		StringBuilder sql = new StringBuilder();

		sql.append("select possible_date from( ");
		sql.append(" select to_char((b.opening_date + 30), 'yyyy-MM-dd') as possible_date ");
		sql.append(" 	from hn_member a, hn_account b ");
		sql.append(" 	where a.tel1 = ? and a.tel2 = ? and a.tel3 = ? ");
		sql.append(" 	and a.id = b.member_id and (b.opening_date + 30) > sysdate ");
		sql.append(" 	order by b.opening_date desc ");
		sql.append(")where rownum = 1 ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			int loc = 1;
			pstmt.setString(loc++, vo.getTel1());
			pstmt.setString(loc++, vo.getTel2());
			pstmt.setString(loc++, vo.getTel3());

			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				possibleDate = rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return possibleDate;
	}
}
